------------------------------------------------------------
----
------------------
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

with STM32F4.Busses; use STM32F4.Busses;
package STM32F4.Reset_Clock_Control is

   type Clock_Switch_type is (HSI, HSE, PLL) with Size => 2;
   for Clock_Switch_type use (HSI => 0, HSE => 1, PLL => 3);

   type HPRE_type is (SC_1, SC_2, SC_4, SC_8, SC_16, SC_64, SC_128, SC_256, SC_512) with Size => 4;
   for HPRE_type use (SC_1 => 0, SC_2 => 2#1000#, SC_4 => 2#1001#, SC_8 => 2#1010#, SC_16 => 2#1011#, SC_64=> 2#1100#,
      SC_128 => 2#1101#, SC_256 => 2#1110#, SC_512 => 2#1111#);

   type PPRE_type is (AC_1, AC_2, AC_4, AC_8, AC_16) with Size => 3;
   for PPRE_type use (AC_1 => 0, AC_2 => 2#100#, AC_4 => 2#101#, AC_8 => 2#110#, AC_16 => 2#111#);

   type MCO1_type is (HSI, LSE, HSE, PLL) with Size =>2;
   for MCO1_type use (HSI => 0, LSE => 1, HSE => 2, PLL => 3);

   type MCOPRE_type is (MCO_1,MCO_2,MCO_3,MCO_4,MCO_5) with Size =>3;
   for MCOPRE_type use (MCO_1 => 0, MCO_2 => 2#100#, MCO_3 => 2#101#, MCO_4 => 2#110#, MCO_5 => 2#111#);

   type MCO2_type is (SYSCLK, PLLI2S, HSE, PLL) with Size =>2;
   for MCO2_type use (SYSCLK => 0, PLLI2S => 1, HSE => 2, PLL => 3);

   type RCC_Register_CFGR is record
      SW      : Clock_Switch_type     := HSI;
      SWS     : Clock_Switch_type     := HSI;
      HPRE    : HPRE_type             := SC_1;
      PPRE1   : PPRE_type             := AC_1;
      PPRE2   : PPRE_type             := AC_1;
      RTCPRE  : Integer range 0 ..31 := 0;
      MCO1    : MCO1_type             := HSI;
      I2SSRC  : Boolean               := False;
      MCO1PRE : MCOPRE_type           := MCO_1;
      MCO2PRE : MCOPRE_type           := MCO_1;
      MCO2    : MCO2_type             := SYSCLK;
   end record with Size => 32;

   for RCC_Register_CFGR use record
      SW      at 0 range 0  .. 1;
      SWS     at 0 range 2  .. 3;
      HPRE    at 0 range 4  .. 7;
      PPRE1   at 0 range 10 .. 12;
      PPRE2   at 0 range 13 .. 15;
      RTCPRE  at 0 range 16 .. 20;
      MCO1    at 0 range 21 .. 22;
      I2SSRC  at 0 range 23 .. 23;
      MCO1PRE at 0 range 24 .. 26;
      MCO2PRE at 0 range 27 .. 29;
      MCO2    at 0 range 30 .. 31;
   end record;

   type RCC_Register is record
      CR         : Word;  --  RCC clock control register at 16#00#
      PLLCFGR    : Word;  --  RCC PLL configuration register at 16#04#
      CFGR       : RCC_Register_CFGR;  --  RCC clock configuration register at 16#08#
      CIR        : Word;  --  RCC clock interrupt register at 16#0C#
      AHB1RSTR   : AHB1_type;      --  RCC AHB1 peripheral reset register at
      AHB2RSTR   : AHB2_type;  --  RCC AHB2 peripheral reset register at 16#14#
      AHB3RSTR   : Word;  --  RCC AHB3 peripheral reset register at 16#18#
      Reserved_0 : Word;  --  Reserved at 16#1C#
      APB1RSTR   : APB1_type;  --  RCC APB1 peripheral reset register at 16#20#
      APB2RSTR   : APB2_type;  --  RCC APB2 peripheral reset register at 16#24#
      Reserved_1 : Word;  --  Reserved at 16#28#
      Reserved_2 : Word;  --  Reserved at 16#2c#
      AHB1ENR    : AHB1_type;      --  RCC AHB1 peripheral clock register at
                                   --16#30#
      AHB2ENR    : AHB2_type;  --  RCC AHB2 peripheral clock register at 16#34#
      AHB3ENR    : Word;  --  RCC AHB3 peripheral clock register at 16#38#
      Reserved_3 : Word;  --  Reserved at 16#0C#
      APB1ENR    : APB1_type;  --  RCC APB1 peripheral clock enable at 16#40#
      APB2ENR    : APB2_type;  --  RCC APB2 peripheral clock enable at 16#44#
      Reserved_4 : Word;  --  Reserved at 16#48#
      Reserved_5 : Word;  --  Reserved at 16#4c#
      AHB1LPENR  : AHB1_type;      --  RCC AHB1 periph. low power clk en. at
                                   --16#50#
      AHB2LPENR  : AHB2_type;  --  RCC AHB2 periph. low power clk en. at 16#54#
      AHB3LPENR  : Word;  --  RCC AHB3 periph. low power clk en. at 16#58#
      Reserved_6 : Word;  --  Reserved, 16#5C#
      APB1LPENR  : APB1_type;  --  RCC APB1 periph. low power clk en. at 16#60#
      APB2LPENR  : APB2_type;  --  RCC APB2 periph. low power clk en. at 16#64#
      Reserved_7 : Word;  --  Reserved at 16#68#
      Reserved_8 : Word;  --  Reserved at 16#6C#
      BDCR       : Word;  --  RCC Backup domain control register at 16#70#
      CSR        : Word;  --  RCC clock control/status register at 16#74#
      Reserved_9 : Word;  --  Reserved at 16#78#
      Reserved_10: Word;  --  Reserved at 16#7C#
      SSCGR      : Word;  --  RCC spread spectrum clk gen. reg. at 16#80#
      PLLI2SCFGR : Word;  --  RCC PLLI2S configuration register at 16#84#
   end record;

   for RCC_Register use record
      CR          at 0                range 0 .. 31;
      PLLCFGR     at 4                range 0 .. 31;
      CFGR        at 8                range 0 .. 31;
      CIR         at 12               range 0 .. 31;
      AHB1RSTR    at AHB1RSTR_Offset  range 0 .. 31;
      AHB2RSTR    at 20               range 0 .. 31;
      AHB3RSTR    at 24               range 0 .. 31;
      Reserved_0  at 28               range 0 .. 31;
      APB1RSTR    at APB1RSTR_Offset  range 0 .. 31;
      APB2RSTR    at APB2RSTR_Offset  range 0 .. 31;
      Reserved_1  at 40               range 0 .. 31;
      Reserved_2  at 44               range 0 .. 31;
      AHB1ENR     at AHB1ENR_Offset   range 0 .. 31;
      AHB2ENR     at 52               range 0 .. 31;
      AHB3ENR     at 56               range 0 .. 31;
      Reserved_3  at 60               range 0 .. 31;
      APB1ENR     at APB1ENR_Offset   range 0 .. 31;
      APB2ENR     at APB2ENR_Offset   range 0 .. 31;
      Reserved_4  at 72               range 0 .. 31;
      Reserved_5  at 76               range 0 .. 31;
      AHB1LPENR   at AHB1LPENR_Offset range 0 .. 31;
      AHB2LPENR   at 84               range 0 .. 31;
      AHB3LPENR   at 88               range 0 .. 31;
      Reserved_6  at 92               range 0 .. 31;
      APB1LPENR   at APB1LPENR_Offset range 0 .. 31;
      APB2LPENR   at APB2LPENR_Offset range 0 .. 31;
      Reserved_7  at 104              range 0 .. 31;
      Reserved_8  at 108              range 0 .. 31;
      BDCR        at 112              range 0 .. 31;
      CSR         at 116              range 0 .. 31;
      Reserved_9  at 120              range 0 .. 31;
      Reserved_10 at 124              range 0 .. 31;
      SSCGR       at 128              range 0 .. 31;
      PLLI2SCFGR  at 132              range 0 .. 31;
   end record;

   --  Constants for RCC CR register
   HSION     : constant Word := 2 ** 0;  -- Internal high-speed clock enable
   HSIRDY    : constant Word := 2 ** 1;  -- Internal high-speed clock ready
   HSEON     : constant Word := 2 ** 16; -- External high-speed clock enable
   HSERDY    : constant Word := 2 ** 17; -- External high-speed clock ready
   HSEBYP    : constant Word := 2 ** 18; -- External HS clk. resonator bypass
   CSSON     : constant Word := 2 ** 19; -- Clock security system enable
   PLLON     : constant Word := 2 ** 24; -- Main PLL enable
   PLLRDY    : constant Word := 2 ** 25; -- Main PLL ready
   PLLI2SON  : constant Word := 2 ** 26; -- Main PLL enable
   PLLI2SRDY : constant Word := 2 ** 27; -- Main PLL ready

   PLLSRC_HSE : constant := 2 ** 22; -- PLL source clock is HSE

   --  Constants for RCC CFGR register

   --  AHB prescaler
   HPRE_DIV1   : constant Word := 16#00#; -- AHB is SYSCLK
   HPRE_DIV2   : constant Word := 16#80#; -- AHB is SYSCLK / 2
   HPRE_DIV4   : constant Word := 16#90#; -- AHB is SYSCLK / 4
   HPRE_DIV8   : constant Word := 16#A0#; -- AHB is SYSCLK / 8
   HPRE_DIV16  : constant Word := 16#B0#; -- AHB is SYSCLK / 16
   HPRE_DIV64  : constant Word := 16#C0#; -- AHB is SYSCLK / 64
   HPRE_DIV128 : constant Word := 16#D0#; -- AHB is SYSCLK / 128
   HPRE_DIV256 : constant Word := 16#E0#; -- AHB is SYSCLK / 256
   HPRE_DIV512 : constant Word := 16#F0#; -- AHB is SYSCLK / 512

   --  APB1 prescaler
   PPRE1_DIV1  : constant Word := 16#0000#; -- APB1 is HCLK / 1
   PPRE1_DIV2  : constant Word := 16#1000#; -- APB1 is HCLK / 2
   PPRE1_DIV4  : constant Word := 16#1400#; -- APB1 is HCLK / 4
   PPRE1_DIV8  : constant Word := 16#1800#; -- APB1 is HCLK / 8
   PPRE1_DIV16 : constant Word := 16#1C00#; -- APB1 is HCLK / 16

   --  APB2 prescaler
   PPRE2_DIV1  : constant Word := 16#0000#; -- APB2 is HCLK / 1
   PPRE2_DIV2  : constant Word := 16#8000#; -- APB2 is HCLK / 2
   PPRE2_DIV4  : constant Word := 16#A000#; -- APB2 is HCLK / 4
   PPRE2_DIV8  : constant Word := 16#C000#; -- APB2 is HCLK / 8
   PPRE2_DIV16 : constant Word := 16#E000#; -- APB2 is HCLK / 16

   --  MCO1 clock selector
   MCO1SEL_HSI : constant Word := 0 * 2 ** 21; -- HSI clock on MC01 pin
   MCO1SEL_LSE : constant Word := 1 * 2 ** 21; -- LSE clock on MC01 pin
   MCO1SEL_HSE : constant Word := 2 * 2 ** 21; -- HSE clock on MC01 pin
   MCO1SEL_PLL : constant Word := 3 * 2 ** 21; -- PLL clock on MC01 pin

   --  MCO1 prescaler
   MCO1PRE_DIV1 : constant Word := 0 * 2 ** 24; -- MC01 divides by 1
   MCO1PRE_DIV2 : constant Word := 4 * 2 ** 24; -- MC01 divides by 2
   MCO1PRE_DIV3 : constant Word := 5 * 2 ** 24; -- MC01 divides by 3
   MCO1PRE_DIV4 : constant Word := 6 * 2 ** 24; -- MC01 divides by 4
   MCO1PRE_DIV5 : constant Word := 7 * 2 ** 24; -- MC01 divides by 5

   --  MCO2 clock selector
   MCO2SEL_SYSCLK : constant Word := 0 * 2 ** 30; -- SYSCLK clock on MCO2 pin
   MCO2SEL_PLLI2S : constant Word := 1 * 2 ** 30; -- SYSCLK clock on MCO2 pin
   MCO2SEL_HSE    : constant Word := 2 * 2 ** 30; -- SYSCLK clock on MCO2 pin
   MCO2SEL_PLL    : constant Word := 3 * 2 ** 30; -- SYSCLK clock on MCO2 pin

   --  MCO2 prescaler
   MCO2PRE_DIV1 : constant Word := 0 * 2 ** 27; -- MCO2 divides by 1
   MCO2PRE_DIV2 : constant Word := 4 * 2 ** 27; -- MCO2 divides by 4
   MCO2PRE_DIV3 : constant Word := 5 * 2 ** 27; -- MCO2 divides by 5
   MCO2PRE_DIV4 : constant Word := 6 * 2 ** 27; -- MCO2 divides by 6
   MCO2PRE_DIV5 : constant Word := 7 * 2 ** 27; -- MCO2 divides by 7

   --  I2S clock source
   I2SSRC_PLLI2S : constant Word := 0 * 2 ** 23; -- I2SSRC is PLLI2S
   I2SSRC_PCKIN  : constant Word := 1 * 2 ** 23; -- I2SSRC is I2S_CKIN

   --  System clock switch
   SW_HSI : constant Word := 16#0#; -- HSI selected as system clock
   SW_HSE : constant Word := 16#1#; -- HSI selected as system clock
   SW_PLL : constant Word := 16#2#; -- PLL selected as system clock

   --  System clock switch status
   SWS_HSI : constant Word := 16#0#; -- HSI used as system clock
   SWS_HSE : constant Word := 16#4#; -- HSI used as system clock
   SWS_PLL : constant Word := 16#8#; -- PLL used as system clock

   --  Constants for RCC CR register
   LSION  : constant Word := 2 ** 0; -- Int. low-speed clock enable
   LSIRDY : constant Word := 2 ** 1; -- Int. low-speed clock enable

end STM32F4.Reset_Clock_Control;
