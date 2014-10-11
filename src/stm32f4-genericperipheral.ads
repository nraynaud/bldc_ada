with System;
with STM32F4; use STM32F4;

generic
   RCC_ENABLE_REGISTER_Base : Natural;
   RCC_RESET_REGISTER_Base : Natural;
   RCC_LOWPOW_REGISTER_Base : Natural;
   RCCBit : Natural;
package STM32F4.GenericPeripheral is
   RCC_ENABLE   : Boolean with Atomic, Size=>32, Address => PeriphBitBand(RCC_ENABLE_REGISTER_Base, RCCBit);
   RCC_RESET : Boolean with Atomic,
      Address => System'To_Address (Peripheral_Alias_Base+ (RCC_RESET_REGISTER_Base - Peripheral_Base)*32 + RCCBit*4);
   RCC_LOWPOWER : Boolean with Atomic,
      Address => System'To_Address (Peripheral_Alias_Base+ (RCC_LOWPOW_REGISTER_Base - Peripheral_Base)*32 + RCCBit*4);
end STM32F4.GenericPeripheral;
