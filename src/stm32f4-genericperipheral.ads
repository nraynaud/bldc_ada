with STM32F4; use STM32F4;

generic
   RCC_ENABLE_REGISTER_Base : Natural;
   RCC_RESET_REGISTER_Base : Natural;
   RCC_LOWPOW_REGISTER_Base : Natural;
   RCCBit : Natural;
package STM32F4.GenericPeripheral is
   RCC_ENABLE : Boolean with Atomic, Size=>32, Address => PeriphBitBand(RCC_ENABLE_REGISTER_Base, RCCBit);
   pragma Import (Ada, RCC_ENABLE);
   RCC_RESET : Boolean with Atomic, Size=>32, Address => PeriphBitBand(RCC_RESET_REGISTER_Base,RCCBit);
   pragma Import (Ada, RCC_RESET);
   RCC_LOWPOWER : Boolean with Atomic, Size=>32, Address => PeriphBitBand(RCC_LOWPOW_REGISTER_Base,RCCBit);
   pragma Import (Ada, RCC_LOWPOWER);
end STM32F4.GenericPeripheral;
