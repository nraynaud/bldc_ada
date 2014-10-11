-------------------------------------------------------
-------------------------
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

with Ada.Unchecked_Conversion;

with Registers; use Registers;

package body LEDs is

   function As_Half_Word is new Ada.Unchecked_Conversion (Source => User_LED, Target => Half_Word);

   procedure On (This : User_LED) is
   begin
      GPIOD.Device.BSRR := Word (As_Half_Word (This));
   end On;

   procedure Off (This : User_LED) is
   begin
      GPIOD.Device.BSRR := Shift_Left (Word (As_Half_Word (This)), 16);
   end Off;

   All_LEDs : constant Half_Word := Green'Enum_Rep or Red'Enum_Rep or Blue'Enum_Rep or Orange'Enum_Rep;

   pragma Compile_Time_Error (All_LEDs /= 16#F000#, "Invalid representation for All_LEDs_On");

   procedure All_Off is
   begin
      GPIOD.Device.BSRR := Word (Shift_Left (All_LEDs, 16));
   end All_Off;

   procedure All_On is
   begin
      GPIOD.Device.BSRR := Word (All_LEDs);
   end All_On;

   procedure Initialize is
   begin
      --  Enable clock for GPIO-D
      GPIOD.peripheral.RCC_ENABLE := True;
      --  Configure PD12-15
      GPIOD.Device.MODER (12 .. 15)   := (others => GPIOD.Output);
      GPIOD.Device.OTYPER (12 .. 15)  := (others => GPIOD.PushPull);
      GPIOD.Device.OSPEEDR (12 .. 15) := (others => GPIOD.S100MHz);
      GPIOD.Device.PUPDR (12 .. 15)   := (others => GPIOD.No_Pull);

   end Initialize;

begin
   Initialize;
end LEDs;
