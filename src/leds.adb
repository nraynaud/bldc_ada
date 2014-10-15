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

package body LEDs is

   procedure On (This : User_LED) is
   begin
      GPIOD.Device.BSRR.set (This)  := True;
   end On;

   procedure Toggle (This : User_LED) is
   begin
      if GPIOD.Device.ODR (This) /= False then
         Off (This);
      else
         On (This);
      end if;
   end Toggle;

   procedure Off (This : User_LED) is
   begin
      GPIOD.Device.BSRR.reset (This)  := True;
   end Off;

   procedure All_Off is
   begin
      GPIOD.Device.BSRR.reset (User_LED'Range)   := (others => True);
   end All_Off;

   procedure All_On is
   begin
      GPIOD.Device.BSRR.set (User_LED'Range)   := (others => True);
   end All_On;

   procedure Initialize is
   begin
      --  Enable clock for GPIO-D
      GPIOD.peripheral.RCC_ENABLE := True;
      --  Configure PD12-15
      GPIOD.Device.MODER   (User_LED'Range) := (others => GPIOD.Output);
      GPIOD.Device.OTYPER  (User_LED'Range) := (others => GPIOD.PushPull);
      GPIOD.Device.OSPEEDR (User_LED'Range) := (others => GPIOD.S100MHz);
      GPIOD.Device.PUPDR   (User_LED'Range) := (others => GPIOD.No_Pull);

   end Initialize;

begin
   Initialize;
end LEDs;
