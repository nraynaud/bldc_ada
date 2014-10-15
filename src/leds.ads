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

--  This file provides declarations for the user LEDs on the STM32F4 Discovery
--  board from ST Microelectronics.

with Registers; use Registers;

package LEDs is
   pragma Elaborate_Body;

   subtype User_LED is GPIOD.pin_index range 12..15;

   Green  : constant User_LED := 12;
   Orange : constant User_LED := 13;
   Red    : constant User_LED := 14;
   Blue   : constant User_LED := 15;

   LED3 : User_LED renames Orange;
   LED4 : User_LED renames Green;
   LED5 : User_LED renames Red;
   LED6 : User_LED renames Blue;

   procedure On (This : User_LED) with Inline;
   procedure Off (This : User_LED) with Inline;
   procedure Toggle (This : User_LED);

   procedure All_Off with Inline;
   procedure All_On  with Inline;

end LEDs;
