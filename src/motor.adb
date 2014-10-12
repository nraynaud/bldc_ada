with Ada.Unchecked_Conversion;

with Registers; use Registers;

package body motor is
   subtype my_pins_index_type is GPIOE.pin_index range 4 .. 9;
   procedure setBits;
   procedure clearBits;

   currentPhase : GPIOE.pin_type;

   function AS_pins is new Ada.Unchecked_Conversion (Source => Half_Word, Target => GPIOE.pin_type);

   procedure disable is
   begin
      enabled := False;
      clearBits;
   end disable;

   procedure enable is
   begin
      enabled := True;
      setBits;
   end enable;

   procedure clearBits is
   begin
      GPIOE.Device.BSRR.reset (my_pins_index_type'Range) := (others => True);
   end clearBits;

   procedure setBits is
   begin
      GPIOE.Device.BSRR.set := currentPhase;
   end setBits;

   procedure setPhase (phase : Half_Word) is
   begin
      currentPhase := AS_pins (phase);
      if enabled then
         setBits;
      end if;
   end setPhase;

   procedure Initialize is
   begin
      --  Enable clock for GPIOE
      RCC.AHB1ENR.GPIOE := True;

      --  Configure PE04-10
      --GPIOE.Device.MODER (04 .. 10)   := (others => GPIOE.Output);
      --GPIOE.Device.OTYPER (04 .. 10)  := (others => GPIOE.PushPull);
      --GPIOE.Device.OSPEEDR (04 .. 10) := (others => GPIOE.S100MHz);
      --GPIOE.Device.PUPDR (04 .. 10)   := (others => GPIOE.No_Pull);

   end Initialize;
begin
   Initialize;
end motor;
