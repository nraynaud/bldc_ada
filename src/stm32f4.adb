
package body STM32F4 is
   function PeriphBitBand (register_base, bit_number : Natural) return System.Address is
   begin
      pragma Compile_Time_Error (register_base >= Peripheral_Base and register_base < Peripheral_Base + 1024*1024, "address was not a bit-banded peripheral");
      return System'To_Address(Peripheral_Alias_Base + (register_base - Peripheral_Base) * 32 + bit_number * 4);
   end PeriphBitBand;
end STM32F4;