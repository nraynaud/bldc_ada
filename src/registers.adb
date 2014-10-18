package body Registers is
   function getAPB2ClockSpeed return Positive is
      HSICLK : constant := 16_000_000;
      SYSCLK : constant := HSICLK;
      HCLK   : constant Positive :=  (case RCC.CFGR.HPRE is
         when SC_1   => SYSCLK / 1,
         when SC_2   => SYSCLK / 2,
         when SC_4   => SYSCLK / 4,
         when SC_8   => SYSCLK / 8,
         when SC_16  => SYSCLK / 16,
         when SC_64  => SYSCLK / 64,
         when SC_128 => SYSCLK / 128,
         when SC_256 => SYSCLK / 256,
         when SC_512 => SYSCLK / 512);
      PCLK2 : constant Positive := (case RCC.CFGR.PPRE2 is
         when AC_1  => HCLK,
         when AC_2  => HCLK / 2,
         when AC_4  => HCLK / 4,
         when AC_8  => HCLK / 8,
         when AC_16 => HCLK / 16);
   begin
      return PCLK2;
   end getAPB2ClockSpeed;
end Registers;