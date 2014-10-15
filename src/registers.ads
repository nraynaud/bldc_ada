--------------------------------------------------------------------
---
-----------
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

--  This file provides register declarations for those actually used by this
--  demonstration, for the STM32F4 (ARM Cortex M4F) microcontrollers from
--  ST Microelectronics.

with System;
with STM32F4;                     use STM32F4;
with STM32F4.GPIO;
with STM32F4.Reset_Clock_Control; use STM32F4.Reset_Clock_Control;
with STM32F4.SYSCONFIG_Control;   use STM32F4.SYSCONFIG_Control;
with STM32F4.TIM;

package Registers is

   pragma Warnings (Off, "*may call Last_Chance_Handler");
   pragma Warnings (Off, "*may be incompatible with alignment of object");

   RCC : RCC_Register with
     Volatile,
     Address => System'To_Address (RCC_Base);

   package GPIOA is new STM32F4.GPIO(Address => GPIOA_Base, RCCBit=>0, MODER_Reset =>16#A800_0000#);
   package GPIOB is new STM32F4.GPIO(Address => GPIOB_Base, RCCBit=>1, MODER_Reset =>16#0000_0280#);
   package GPIOC is new STM32F4.GPIO(Address => GPIOC_Base, RCCBit=>2);
   package GPIOD is new STM32F4.GPIO(Address => GPIOD_Base, RCCBit=>3);
   package GPIOE is new STM32F4.GPIO(Address => GPIOE_Base, RCCBit=>4);

   package TIM1 is new STM32F4.TIM(
        Register_Base            => TIM1_Base,
        RCC_RESET_REGISTER_Base  => RCC_Base + APB2RSTR_Offset,
        RCC_ENABLE_REGISTER_Base => RCC_Base + APB2ENR_Offset,
        RCC_LOWPOW_REGISTER_Base => RCC_Base + APB2LPENR_Offset,
        RCCBit                   => 0,
        Timer_Size               => Half_Word,
        AlternateFunction        => 1);
   package TIM3 is new STM32F4.TIM(
       Register_Base            => TIM3_Base,
       RCC_RESET_REGISTER_Base  => RCC_Base + APB1RSTR_Offset,
       RCC_ENABLE_REGISTER_Base => RCC_Base + APB1ENR_Offset,
       RCC_LOWPOW_REGISTER_Base => RCC_Base + APB1LPENR_Offset,
       RCCBit                   => 1,
       Timer_Size               => Half_Word,
       AlternateFunction        => 2);
   package TIM8 is new STM32F4.TIM(
        Register_Base            => TIM8_Base,
        RCC_RESET_REGISTER_Base  => RCC_Base + APB2RSTR_Offset,
        RCC_ENABLE_REGISTER_Base => RCC_Base + APB2ENR_Offset,
        RCC_LOWPOW_REGISTER_Base => RCC_Base + APB2LPENR_Offset,
        RCCBit                   => 1,
        Timer_Size               => Half_Word,
        AlternateFunction        => 3);

   EXTI : EXTI_Register with
     Volatile,
     Address => System'To_Address (EXTI_Base);
   pragma Import (Ada, EXTI);

   SYSCFG : SYSCFG_Register with
     Volatile,
     Address => System'To_Address (SYSCFG_Base);
   pragma Import (Ada, SYSCFG);


   pragma Warnings (On, "*may call Last_Chance_Handler");
   pragma Warnings (On, "*may be incompatible with alignment of object");

end Registers;
