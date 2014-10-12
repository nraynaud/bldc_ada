----------------------------------------------------------------------
----------
--                                                                          --
--                             GNAT EXAMPLE                                 --
--                                                                          --
--             Copyright (C) 2014, Free Software Foundation, Inc.           --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

with motor;         use motor;
with LEDs;          use LEDs;
with Button;        use Button;
with Ada.Real_Time; use Ada.Real_Time;
with STM32F4;       use STM32F4;
with Registers;     use Registers;

package body Driver is
   type Index is mod 4;
   type Phases_index is mod 6;

   MaxSpeed            : Integer := 2000;
   MaxDutyCyclePercent : Integer := 80;

   MinSpeed            : Integer := 200;
   MinDutyCyclePercent : Integer := 80;

   DutyCyclePercent : Integer := 10;
   PWMFrequency     : Integer := 1000;
   Speed            : Integer := 2000;

   Next_LED : Index := 0;

   Pattern : constant array (Index) of User_LED         := (Orange, Red, Blue, Green);
   Phases  : constant array (Phases_index) of Half_Word :=
     (2#00_10_11_0000#,
      2#11_10_00_0000#,
      2#11_00_10_0000#,
      2#00_11_10_0000#,
      2#10_11_00_0000#,
      2#10_00_11_0000#);

   task body PWM is
      onPeriod   : Time_Span;
      offPeriod  : Time_Span;
      period     : Time_Span;
      Next_Start : Time    := Clock;
      PWM_On     : Boolean := True;
   begin
     GPIOE.peripheral.RCC_ENABLE := True;
     GPIOE.Device.MODER (9)   := GPIOE.Alternate;
     GPIOE.Device.OTYPER (9)  := GPIOE.PushPull;
     GPIOE.Device.OSPEEDR (9) := GPIOE.S50MHz;
     GPIOE.Device.PUPDR (9)   := GPIOE.No_Pull;
     GPIOE.Device.AFR (9)     := 1;

     GPIOA.peripheral.RCC_ENABLE := True;
     GPIOA.Device.MODER (8)   := GPIOA.Alternate;
     GPIOA.Device.OTYPER (8)  := GPIOA.PushPull;
     GPIOA.Device.OSPEEDR (8) := GPIOA.S50MHz;
     GPIOA.Device.PUPDR (8)   := GPIOA.No_Pull;
     GPIOA.Device.AFR (8)     := 1;

     TIM1.peripheral.RCC_ENABLE := True;
     TIM1.TIM.PSC            := 2;
     TIM1.TIM.CR1.CEN         := True;
     TIM1.TIM.CR1.ARPE        := True;
     TIM1.TIM.CCER.CC1E           := True;
     TIM1.TIM.ARR                := 665;
     TIM1.TIM.CCR1                := 333;
     TIM1.TIM.CCMR_Ch1       := (CCxS => TIM1.Output, OCxFE => False, OCxPE => True, OCxM => TIM1.PWM1, OCxCE =>False);
      loop
         period    := Microseconds (1_000_000) / PWMFrequency;
         onPeriod  := period / 3;
         offPeriod := 2 * period / 3;
         if (PWM_On) then
            Off (Pattern (Next_LED));
            PWM_On     := False;
            Next_Start := Next_Start + offPeriod;
         else
            On (Pattern (Next_LED));
            PWM_On     := True;
            Next_Start := Next_Start + onPeriod;
         end if;
         delay until Next_Start;
      end loop;
   end PWM;
end Driver;
