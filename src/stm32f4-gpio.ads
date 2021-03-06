------------------------------------------------
--------------
------
----------------
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

--  This file provides register definitions for the STM32F4 (ARM Cortex M4F)
--  microcontrollers from ST Microelectronics.

pragma Restrictions (No_Elaboration_Code);
with System;
with Ada.Unchecked_Conversion;

with STM32F4.GenericPeripheral;
generic
   Address : Natural;
   RCCBit : Natural;
   MODER_Reset : Word := 16#0000_0000#;
package STM32F4.GPIO is

   package peripheral is new STM32F4.GenericPeripheral (
      RCC_RESET_REGISTER_Base  => RCC_Base + AHB1RSTR_Offset,
      RCC_ENABLE_REGISTER_Base => RCC_Base + AHB1ENR_Offset,
      RCC_LOWPOW_REGISTER_Base => RCC_Base + AHB1LPENR_Offset,
      RCCBit                   => RCCBit);

   type pin_index is mod 16;
   type ModeType is (Input, Output, Alternate, Analog);
   for ModeType use (Input => 0, Output => 1, Alternate => 2, Analog => 3);
   type MODER_type is array (pin_index) of ModeType with Pack, Size => 32;

   type OutputType is (PushPull, OpenDrain);
   for OutputType use (PushPull => 0, OpenDrain => 1);
   type OTYPER_type is array (pin_index) of OutputType with Pack, Size => 16;

   type SpeedType is (S2MHz,S25MHz,S50MHz, S100MHz);
   for SpeedType use (S2MHz=>0,S25MHz=>1,S50MHz=>2, S100MHz=>3);
   type OSPEEDR_type is array(pin_index) of SpeedType with Pack, Size => 32;

   type PullType is (No_Pull, Pull_Up, Pull_Down);
   for PullType use (No_Pull=>0, Pull_Up=>1, Pull_Down =>2);
   type PUPDR_type is array(pin_index) of PullType with Pack, Size => 32;

   --  AFL constants
   AF_USART1 : constant Bits_4 := 7;

   type pin_type is array (pin_index) of Boolean with Pack, size => 16;

   type BSRR_TYPE is record
      set : pin_type;
      reset : pin_type;
   end record with Pack, Size=>32 ;

   type AFR_type is array (pin_index) of Bits_4 with Pack, Size =>64;

   type GPIO_Register is record
      MODER   : MODER_type;  --  mode register
      OTYPER  : OTYPER_type;  --  output type register
      OSPEEDR : OSPEEDR_type;  --  output speed register
      PUPDR   : PUPDR_type;  --  pull-up/pull-down register
      IDR     : pin_type;       --  input data register
      ODR     : pin_type;       --  output data register
      BSRR    : BSRR_TYPE;       --  bit set/reset register
      LCKR    : pin_type;       --  configuration lock register
      AFR    : AFR_type;   --  alternate function register coalesced
   end record;

   for GPIO_Register use record
      MODER   at 0  range 0 .. 31;
      OTYPER  at 4  range 0 .. 15;
      OSPEEDR at 8  range 0 .. 31;
      PUPDR   at 12 range 0 .. 31;
      IDR     at 16 range 0 .. 15;
      ODR     at 20 range 0 .. 15;
      BSRR    at 24 range 0 .. 31;
      LCKR    at 28 range 0 .. 15;
      AFR     at 32 range 0 .. 63;
   end record;

   Device             : GPIO_Register with Volatile, Address => System'To_Address (Address);
   pragma Import (Ada, Device);
   MODERResetValue : constant MODER_type;
private
   function As_MODER_Reset is new Ada.Unchecked_Conversion (Source => Word, Target => MODER_type);
   MODERResetValue : constant MODER_type := As_MODER_Reset(MODER_Reset);
end STM32F4.GPIO;
