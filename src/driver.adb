
with LEDs;          use LEDs;
with Ada.Real_Time; use Ada.Real_Time;
with STM32F4;       use STM32F4;
with Registers;     use Registers;
with System.BB.Parameters;
with Ada.Interrupts.Names;
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
   type Encoder_mode is (Speed_Mode, Duty_Mode);

   DutyCyclePercent : Half_Word   := 50;
   PWMFrequency     : constant Half_Word := 20000;
   Speed            : constant Half_Word := 2;
   savedSpeed       : Half_Word          := Speed;
   timer_frequency  : constant Integer   := 1_000_000;
   prescaler        : constant Half_Word   := Half_Word(System.BB.Parameters.Clock_Frequency / timer_frequency);

   Current_Encoder_Mode : Encoder_mode := Speed_Mode;
   Next_LED : constant Index := 0;

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
      if Current_Encoder_Mode = Speed_Mode then
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
      end if;
      return savedSpeed;
   end readSpeed;

   function readDutyCycle return Half_Word is
      readDutyCycle : Half_Word;
   begin
      if Current_Encoder_Mode = Duty_Mode then
         readDutyCycle := TIM3.TIM.CNT;
         if TIM3.TIM.SR.UIF then
            -- there was an overflow or underflow, refuse it;
            TIM3.TIM.SR.UIF := False;
            TIM3.TIM.CNT := DutyCyclePercent;
         else
            DutyCyclePercent := readDutyCycle;
         end if;
      end if;
      return DutyCyclePercent;
   end readDutyCycle;

   protected Driver is
      pragma Interrupt_Priority;
   private
      procedure TIM_Handler;
      procedure Button_Handler;
      pragma Attach_Handler (TIM_Handler, Ada.Interrupts.Names.TIM8_UP_TIM13_Interrupt);
      pragma Attach_Handler (Button_Handler, Ada.Interrupts.Names.EXTI0_Interrupt);
      Phase      : Phases_index := 0;
   end Driver;

   protected body Driver is

      procedure TIM_Handler is
      timer      : Integer := timer_frequency / Integer(readSpeed) / 6 - 1;
      p          : constant step := Phases(Phase);
      counter    : constant Integer := Integer(timer_frequency) / Integer(PWMFrequency);
      compare    : constant Half_Word := Half_Word((counter * Integer(readDutyCycle) + 50) / 100); -- +50 is for integer division rounding.
      begin
         TIM8.TIM.SR.UIF := False;
         TIM1.TIM.ARR      := Half_Word(counter-1);
         TIM1.TIM.CCR1     := compare;
         TIM1.TIM.CCR2     := compare;
         TIM1.TIM.CCR3     := compare;
         TIM1.TIM.CCER     := (CC1E => p.C1 or p.C1N, CC2E => p.C2 or p.C2N, CC3E => p.C3 or p.C3N, others => False);
         TIM1.TIM.EGR.COMG := True;
         GPIOE.Device.BSRR :=(
            reset => (8|10|12 => True, others => False),
            set   => (8 => p.C1, 10 => p.C2, 12 => p.C3, others => False));
         timer := Integer'Max(timer, Integer(Half_Word'First));
         timer := Integer'Min(timer, Integer(Half_Word'Last));
         TIM8.TIM.ARR := Half_Word(timer);
         Toggle(Blue);
         Phase := Phase + 1;
      end TIM_Handler;

      procedure Button_Handler is
      begin
         EXTI.PR (0) := 1;
         case Current_Encoder_Mode is
            when Speed_Mode =>
               TIM3.TIM.ARR               := Half_Word(100);
               TIM3.TIM.CNT               := DutyCyclePercent;
               TIM3.TIM.SR.UIF            := False;
               Current_Encoder_Mode       := Duty_Mode;
               GPIOC.Device.BSRR          := (reset => (4 => True, others => False), set => (5 => True, others => False));
            when Duty_Mode =>
               TIM3.TIM.ARR               := Half_Word(65535);
               TIM3.TIM.CNT               := savedSpeed;
               TIM3.TIM.SR.UIF            := False;
               Current_Encoder_Mode       := Speed_Mode;
               GPIOC.Device.BSRR          := (reset => (5 => True, others => False), set => (4 => True, others => False));
         end case;
      end Button_Handler;
   end Driver;

   procedure prepareHardware is
   begin
      GPIOE.peripheral.RCC_ENABLE  := True;
      GPIOE.Device.MODER           := (8|10|12 => GPIOE.Output, 9|11|13 => GPIOE.Alternate, others => <>);
      GPIOE.Device.OTYPER (8..13)  := (others => GPIOE.PushPull);
      GPIOE.Device.OSPEEDR (8..13) := (others => GPIOE.S50MHz);
      GPIOE.Device.PUPDR (8..13)   := (others => GPIOE.Pull_Down);
      GPIOE.Device.AFR (8..13)     := (others => TIM1.GPIO_AF);

      GPIOC.peripheral.RCC_ENABLE := True;
      GPIOC.Device.MODER (6..7)   := (others => GPIOC.Alternate);
      GPIOC.Device.PUPDR (6..7)   := (others => GPIOC.Pull_Up);
      GPIOC.Device.AFR (6..7)     := (others => TIM3.GPIO_AF);

      GPIOC.Device.MODER (4..5)   := (others => GPIOC.Output);
      GPIOC.Device.OTYPER (4..5)  := (others => GPIOC.PushPull);
      GPIOC.Device.BSRR           := (reset=>(5 => True, others => False), set=> (4 => True, others => False));


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

      TIM3.peripheral.RCC_ENABLE := True;
      TIM3.TIM.SMCR.SMS          := TIM3.Encoder3;
      TIM3.TIM.ARR               := 65535;
      TIM3.TIM.CCMR_Ch1          := (CCxS => TIM3.Input_TI1, others=><>);
      TIM3.TIM.CCMR_Ch2          := (CCxS => TIM3.Input_TI1, others=><>);
      TIM3.TIM.CNT               := savedSpeed;
      TIM3.TIM.CCER              := (CC1E|CC2E=> True, others => False);
      TIM3.TIM.CR1               := (CEN => True,others =><>);

      TIM8.peripheral.RCC_ENABLE := True;
      TIM8.TIM.PSC               := Half_Word(prescaler - 1);
      TIM8.TIM.ARR               := 1;
      TIM8.TIM.DIER              := (UIE => True, others => <>);
      TIM8.TIM.BDTR              := (MOE =>True, DTG => 0, others=> <>);
      TIM8.TIM.CR2               := (CCPC =>True, others => <>);
      TIM8.TIM.CR1               := (ARPE|CEN => True,others => <>);

      GPIOA.peripheral.RCC_ENABLE  := True;
      GPIOA.Device.MODER (0) := GPIOA.Input;
      GPIOA.Device.PUPDR (0) := GPIOA.No_Pull;

      SYSCFG.EXTICR1 (0) := 0;
      EXTI.FTSR (0) := 0;
      EXTI.RTSR (0) := 1;
      EXTI.IMR (0) := 1;
   end prepareHardware;

   task body speedControl is
      Next_Start : Time    := Clock;
   begin
      prepareHardware;
      loop
         Toggle (Pattern (Next_LED));
         Next_Start := Next_Start + Milliseconds(1000) / Integer(readSpeed);
         delay until Next_Start;
      end loop;
   end speedControl;
end Driver;
