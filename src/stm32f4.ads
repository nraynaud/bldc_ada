-------------------------------------------------
-------------------------------
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

--  This file provides type definitions for the STM32F4 (ARM Cortex M4F)
--  microcontrollers from ST Microelectronics.

with System; use System;
with Interfaces;

package STM32F4 is

   type Word is new Interfaces.Unsigned_32;  -- for shift/rotate
   type Half_Word is new Interfaces.Unsigned_16;  -- for shift/rotate
   type Byte is new Interfaces.Unsigned_8;   -- for shift/rotate

   type Bits_1 is mod 2 ** 1 with Size => 1;
   type Bits_2  is mod 2**2 with Size => 2;
   type Bits_4  is mod 2**4 with Size => 4;

   type Bits_32x1 is array (0 .. 31) of Bits_1 with Pack, Size => 32;
   type Bits_16x2 is array (0 .. 15) of Bits_2 with Pack, Size => 32;
   type Bits_8x4  is array (0 ..  7) of Bits_4 with Pack, Size => 32;

   --  Define address bases for the various system components

   Peripheral_Base : constant := 16#4000_0000#;

   -- bit banding alias
   Peripheral_Alias_Base : constant := 16#4200_0000#;

   APB1_Peripheral_Base : constant := Peripheral_Base;
   APB2_Peripheral_Base : constant := Peripheral_Base + 16#0001_0000#;
   AHB1_Peripheral_Base : constant := Peripheral_Base + 16#0002_0000#;
   AHB2_Peripheral_Base : constant := Peripheral_Base + 16#1000_0000#;
   AHB3_Peripheral_Base : constant := Peripheral_Base + 16#A000_0000#;

   FSMC_Base            : constant := AHB3_Peripheral_Base + 16#0000#;

   RNG_Base             : constant := AHB2_Peripheral_Base + 16#6_0800#;
   HASH_Base            : constant := AHB2_Peripheral_Base + 16#6_0400#;
   CRYP_Base            : constant := AHB2_Peripheral_Base + 16#6_0000#;
   DCMI_Base            : constant := AHB2_Peripheral_Base + 16#5_0000#;
   USBFS_Base           : constant := AHB2_Peripheral_Base + 16#0_0000#;

   USBHS_Base           : constant := AHB1_Peripheral_Base + 16#2_0000#;
   ETH_Base             : constant := AHB1_Peripheral_Base + 16#8000#;
   DMA2_Base            : constant := AHB1_Peripheral_Base + 16#6400#;
   DMA1_Base            : constant := AHB1_Peripheral_Base + 16#6000#;
   BKPSRAM_Base         : constant := AHB1_Peripheral_Base + 16#4000#;
   FLASH_Base           : constant := AHB1_Peripheral_Base + 16#3C00#;
   RCC_Base             : constant := AHB1_Peripheral_Base + 16#3800#;
   CRC_Base             : constant := AHB1_Peripheral_Base + 16#3000#;
   GPIOI_Base           : constant := AHB1_Peripheral_Base + 16#2000#;
   GPIOH_Base           : constant := AHB1_Peripheral_Base + 16#1C00#;
   GPIOG_Base           : constant := AHB1_Peripheral_Base + 16#1800#;
   GPIOF_Base           : constant := AHB1_Peripheral_Base + 16#1400#;
   GPIOE_Base           : constant := AHB1_Peripheral_Base + 16#1000#;
   GPIOD_Base           : constant := AHB1_Peripheral_Base + 16#0C00#;
   GPIOC_Base           : constant := AHB1_Peripheral_Base + 16#0800#;
   GPIOB_Base           : constant := AHB1_Peripheral_Base + 16#0400#;
   GPIOA_Base           : constant := AHB1_Peripheral_Base + 16#0000#;

   TIM11_Base           : constant := APB2_Peripheral_Base + 16#4800#;
   TIM10_Base           : constant := APB2_Peripheral_Base + 16#4400#;
   TIM9_Base            : constant := APB2_Peripheral_Base + 16#4000#;
   EXTI_Base            : constant := APB2_Peripheral_Base + 16#3C00#;
   SYSCFG_Base          : constant := APB2_Peripheral_Base + 16#3800#;
   SPI1_Base            : constant := APB2_Peripheral_Base + 16#3000#;
   SDIO_Base            : constant := APB2_Peripheral_Base + 16#2C00#;
   ADC_Base             : constant := APB2_Peripheral_Base + 16#2000#;
   USART6_Base          : constant := APB2_Peripheral_Base + 16#1400#;
   USART1_Base          : constant := APB2_Peripheral_Base + 16#1000#;
   TIM8_Base            : constant := APB2_Peripheral_Base + 16#0400#;
   TIM1_Base            : constant := APB2_Peripheral_Base + 16#0000#;

   DAC_Base             : constant := APB1_Peripheral_Base + 16#7400#;
   PWR_Base             : constant := APB1_Peripheral_Base + 16#7000#;
   CAN2_Base            : constant := APB1_Peripheral_Base + 16#6800#;
   CAN1_Base            : constant := APB1_Peripheral_Base + 16#6400#;
   I2C3_Base            : constant := APB1_Peripheral_Base + 16#5C00#;
   I2C2_Base            : constant := APB1_Peripheral_Base + 16#5800#;
   I2C1_Base            : constant := APB1_Peripheral_Base + 16#5400#;
   UART5_Base           : constant := APB1_Peripheral_Base + 16#5000#;
   UART4_Base           : constant := APB1_Peripheral_Base + 16#4C00#;
   USART3_Base          : constant := APB1_Peripheral_Base + 16#4800#;
   USART2_Base          : constant := APB1_Peripheral_Base + 16#4400#;
   I2S3_Base            : constant := APB1_Peripheral_Base + 16#4000#;
   SPI3_Base            : constant := APB1_Peripheral_Base + 16#3C00#;
   SPI2_Base            : constant := APB1_Peripheral_Base + 16#3800#;
   I2S2_Base            : constant := APB1_Peripheral_Base + 16#3400#;
   IWDG_Base            : constant := APB1_Peripheral_Base + 16#3000#;
   WWDG_Base            : constant := APB1_Peripheral_Base + 16#2C00#;
   RTC_Base             : constant := APB1_Peripheral_Base + 16#2800#;
   TIM14_Base           : constant := APB1_Peripheral_Base + 16#2000#;
   TIM13_Base           : constant := APB1_Peripheral_Base + 16#1C00#;
   TIM12_Base           : constant := APB1_Peripheral_Base + 16#1800#;
   TIM7_Base            : constant := APB1_Peripheral_Base + 16#1400#;
   TIM6_Base            : constant := APB1_Peripheral_Base + 16#1000#;
   TIM5_Base            : constant := APB1_Peripheral_Base + 16#0C00#;
   TIM4_Base            : constant := APB1_Peripheral_Base + 16#0800#;
   TIM3_Base            : constant := APB1_Peripheral_Base + 16#0400#;
   TIM2_Base            : constant := APB1_Peripheral_Base + 16#0000#;

   AHB1RSTR_Offset  : constant := 16#10#;
   APB1RSTR_Offset  : constant := 16#20#;
   APB2RSTR_Offset  : constant := 16#24#;

   AHB1ENR_Offset   : constant := 16#30#;
   APB1ENR_Offset   : constant := 16#40#;
   APB2ENR_Offset   : constant := 16#44#;

   AHB1LPENR_Offset : constant := 16#50#;
   APB1LPENR_Offset : constant := 16#60#;
   APB2LPENR_Offset : constant := 16#64#;

   function PeriphBitBand (register_base,bit_number : Natural) return System.Address;
end STM32F4;
