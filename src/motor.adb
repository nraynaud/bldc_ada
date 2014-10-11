with Registers; use Registers;

package body motor is
   my_pins : constant Word := 2#11_1111_0000#;
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
      GPIOE.Device.BSRR := Shift_Left (my_pins, 16);
   end clearBits;

   procedure setBits is
   begin
      GPIOE.Device.BSRR := Word (currentPhase) or Shift_Left (my_pins, 16);
   end setBits;

   procedure setPhase (phase : Half_Word) is
   begin
      currentPhase := phase;
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
