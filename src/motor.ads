with STM32F4; use STM32F4;

package motor is
   pragma Elaborate_Body;

   type Direction is (CCW, CW);

   procedure enable;
   procedure disable;
   procedure setPhase (phase : Half_Word);

   enabled : Boolean := True;
private
   procedure setBits;
   procedure clearBits;
   currentPhase : Half_Word;
end motor;
