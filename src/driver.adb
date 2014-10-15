with motor;         use motor;
with LEDs;          use LEDs;
with Button;        use Button;
with Ada.Real_Time; use Ada.Real_Time;
with STM32F4;       use STM32F4;
with Registers;     use Registers;
with System.BB.Parameters;
package body Driver is
   type Index is mod 3;
   type Phases_index is mod 6;
   type step is record
      C1 : Boolean;
      C1N :Boolean;
      C2 : Boolean;
      C2N :Boolean;
      C3 : Boolean;
      C3N :Boolean;
   end record;

   DutyCyclePercent : Integer := 40;
   PWMFrequency     : Integer := 20000;
   Speed            : Half_Word := 2;
   savedSpeed       : Half_Word := Speed;
   timer_frequency  : constant Integer := 2_000_000;
   prescaler        : constant Integer := System.BB.Parameters.Clock_Frequency / timer_frequency;

   Next_LED : Index := 0;

   Pattern : constant array (Index) of User_LED         := (Orange, Red, Green);
   Phases  : constant array (Phases_index) of step :=
     ((True,  False, False, True,  False, False),
      (True,  False, False, False, False, True),
      (False, False, True,  False, False, True),
      (False, True,  True,  False, False, False),
      (False, True,  False, False, True,  False),
      (False, False, False, True,  True,  False));

   function readSpeed return Half_Word is
      readSpeed : Half_Word;
   begin
      readSpeed := TIM3.TIM.CNT;
      if TIM3.TIM.SR.UIF then
         -- there was an overflow or underflow, refuse it;
         TIM3.TIM.SR.UIF := False;
         TIM3.TIM.CNT := savedSpeed;
      else
         savedSpeed := readSpeed;
      end if;
      if savedSpeed = 0 then
         savedSpeed := 1;
      end if;
      return savedSpeed;
   end readSpeed;

   procedure prepareHardware is
   begin
      GPIOE.peripheral.RCC_ENABLE     := True;
      GPIOE.Device.MODER (8..13)      := (others => GPIOE.Alternate);
      GPIOE.Device.OTYPER (8..13)     := (others => GPIOE.PushPull);
      GPIOE.Device.OSPEEDR (8..13)    := (others => GPIOE.S50MHz);
      GPIOE.Device.PUPDR (8..13)      := (others => GPIOE.Pull_Down);
      GPIOE.Device.AFR (8..13)        := (others => TIM1.GPIO_AF);
      GPIOE.Device.MODER (8)          := GPIOE.Output;
      GPIOE.Device.MODER (10)         := GPIOE.Output;
      GPIOE.Device.MODER (12)         := GPIOE.Output;

      TIM1.peripheral.RCC_ENABLE := True;
      TIM1.TIM.PSC               := Half_Word(prescaler - 1);
      TIM1.TIM.CCER              := (CC1E=> True, others => False);
      TIM1.TIM.ARR               := 10000;
      TIM1.TIM.CCR1              := 3000;
      TIM1.TIM.CCMR_Ch1          := (ocxpe => True, CCxS => TIM1.Output, OCxM => TIM1.PWM1, others => <>);
      TIM1.TIM.CCMR_Ch2          := (ocxpe => True, CCxS => TIM1.Output, OCxM => TIM1.PWM1, others => <>);
      TIM1.TIM.CCMR_Ch3          := (ocxpe => True, CCxS => TIM1.Output, OCxM => TIM1.PWM1, others => <>);
      TIM1.TIM.CR1               := (ARPE|CEN => True,others =><>);
      TIM1.TIM.BDTR              := (MOE =>True, DTG => 0, others=><>);
      TIM1.TIM.CR2               := (CCPC =>True, others=><>);

      GPIOC.peripheral.RCC_ENABLE := True;
      GPIOC.Device.MODER (6)      := GPIOC.Alternate;
      GPIOC.Device.MODER (7)      := GPIOC.Alternate;
      GPIOC.Device.PUPDR (6)      := GPIOC.Pull_Up;
      GPIOC.Device.PUPDR (7)      := GPIOC.Pull_Up;
      GPIOC.Device.AFR (6)        := TIM3.GPIO_AF;
      GPIOC.Device.AFR (7)        := TIM3.GPIO_AF;

      TIM3.peripheral.RCC_ENABLE  := True;
      TIM3.TIM.SMCR.SMS           := TIM3.Encoder3;
      TIM3.TIM.ARR                := 65535;
      TIM3.TIM.CCMR_Ch1           := (CCxS => TIM3.Input_TI1, others=><>);
      TIM3.TIM.CCMR_Ch2           := (CCxS => TIM3.Input_TI1, others=><>);
      TIM3.TIM.CNT                := savedSpeed;
      TIM3.TIM.CCER               := (CC1E|CC2E=> True, others => False);
      TIM3.TIM.CR1                := (CEN => True,others =><>);
   end prepareHardware;

   task body speedControl is
      period     : Time_Span;
      Next_Start : Time    := Clock;
      PWM_On     : Boolean := True;
      Phase      : Phases_index := 0;
      p          : step;
      counter    : constant Integer := timer_frequency / PWMFrequency;
      compare    : constant Half_Word := Half_Word((counter * DutyCyclePercent + 50) / 100); -- +50 is for integer division rounding.
   begin
      prepareHardware;
      loop
         if (PWM_On) then
            Off (Pattern (Next_LED));
            PWM_On     := False;
         else
            On (Pattern (Next_LED));
            PWM_On     := True;
         end if;
            p := Phases(Phase);
            TIM1.TIM.ARR      := Half_Word(counter-1);
            TIM1.TIM.CCR1     := compare;
            TIM1.TIM.CCR2     := compare;
            TIM1.TIM.CCR3     := compare;
            TIM1.TIM.CCER     := (CC1E => p.C1 or p.C1N, CC2E => p.C2 or p.C2N, CC3E => p.C3 or p.C3N, others => <>);
            TIM1.TIM.EGR.COMG := True;
            GPIOE.Device.BSRR.reset (8 ..12) := (True, False, True, False, True);
            GPIOE.Device.BSRR.set (8 ..12) := (p.C1, False, p.C2, False, p.C3);
            Next_Start := Next_Start + Milliseconds(1000) / Integer(readSpeed);
            Phase := Phase+1;
         delay until Next_Start;
      end loop;
   end speedControl;
end Driver;
