pragma Restrictions (No_Elaboration_Code);
with STM32F4.GenericPeripheral;

generic
   Register_Base            : Positive;
   RCC_RESET_REGISTER_Base  : Natural;
   RCC_ENABLE_REGISTER_Base : Natural;
   RCC_LOWPOW_REGISTER_Base : Natural;
   RCCBit                   : Natural;
   AlternateFunction        : Bits_4;
package STM32F4.USART is
   package peripheral is new STM32F4.GenericPeripheral
     (RCC_RESET_REGISTER_Base  => RCC_RESET_REGISTER_Base,
      RCC_ENABLE_REGISTER_Base => RCC_ENABLE_REGISTER_Base,
      RCC_LOWPOW_REGISTER_Base => RCC_LOWPOW_REGISTER_Base,
      RCCBit                   => RCCBit);

   GPIO_AF : constant Bits_4 := AlternateFunction;

   type USART_Register_SR is record
      PE   : Boolean := False;
      FE   : Boolean := False;
      NF   : Boolean := False;
      ORE  : Boolean := False;
      IDLE : Boolean := False;
      RXNE : Boolean := False;
      TC   : Boolean := True;
      TXE  : Boolean := True;
      LBD  : Boolean := False;
      CTS  : Boolean := False;
   end record with Size => 10;

   for USART_Register_SR use record
      PE   at 0 range 0 .. 0;
      FE   at 0 range 1 .. 1;
      NF   at 0 range 2 .. 2;
      ORE  at 0 range 3 .. 3;
      IDLE at 0 range 4 .. 4;
      RXNE at 0 range 5 .. 5;
      TC   at 0 range 6 .. 6;
      TXE  at 0 range 7 .. 7;
      LBD  at 0 range 8 .. 8;
      CTS  at 0 range 9 .. 9;
   end record;

   type USART_Register_BRR is record
      Fraction : Integer range 0 .. 15    := 0;
      Mantissa : Integer range 0 .. 4_095 := 0;
   end record with Size => 16;

   for USART_Register_BRR use record
      Fraction at 0 range 0 .. 3;
      Mantissa at 0 range 4 .. 15;
   end record;

   type USART_Register_CR1 is record
      SBK    : Boolean := False;
      RWU    : Boolean := False;
      RE     : Boolean := False;
      TE     : Boolean := False;
      IDLEIE : Boolean := False;
      RXNEIE : Boolean := False;
      TCIE   : Boolean := False;
      TXEIE  : Boolean := False;
      PEIE   : Boolean := False;
      PS     : Boolean := False;
      PCE    : Boolean := False;
      WAKE   : Boolean := False;
      M      : Boolean := False;
      UE     : Boolean := False;
      OVER8  : Boolean := False;
   end record with Size => 16;

   for USART_Register_CR1 use record
      SBK    at 0 range 0 .. 0;
      RWU    at 0 range 1 .. 1;
      RE     at 0 range 2 .. 2;
      TE     at 0 range 3 .. 3;
      IDLEIE at 0 range 4 .. 4;
      RXNEIE at 0 range 5 .. 5;
      TCIE   at 0 range 6 .. 6;
      TXEIE  at 0 range 7 .. 7;
      PEIE   at 0 range 8 .. 8;
      PS     at 0 range 9 .. 9;
      PCE    at 0 range 10 ..10;
      WAKE   at 0 range 11 ..11;
      M      at 0 range 12 ..12;
      UE     at 0 range 13 ..13;
      --reserved
      OVER8  at 0 range 15 .. 15;
   end record;

   type STOP_type is (S_1, S_0_5, S_2, S_1_5) with Size => 2;
   for STOP_type use (S_1 => 0, S_0_5 => 1, S_2 => 2, S_1_5 => 3);

   type USART_Register_CR2 is record
      ADD   : Integer range 0 .. 15 := 0;
      LBDL  : Boolean         := False;
      LBDIE : Boolean         := False;
      LBCL  : Boolean         := False;
      CPHA  : Boolean         := False;
      CPOL  : Boolean         := False;
      CLKEN : Boolean         := False;
      STOP  : STOP_type       := S_1;
      LINEN : Boolean         := False;
   end record with Size => 15;

   for USART_Register_CR2 use record
      ADD   at 0 range 0  ..  3;
      --reserved
      LBDL  at 0 range 5  ..  5;
      LBDIE at 0 range 6  ..  6;
      --reserved
      LBCL  at 0 range 8  ..  8;
      CPHA  at 0 range 9  ..  9;
      CPOL  at 0 range 10 .. 10;
      CLKEN at 0 range 11 .. 11;
      STOP  at 0 range 12 .. 13;
      LINEN at 0 range 14 .. 14;
   end record;


   type USART_Register_CR3 is record
      EIE    : Boolean := False;
      IREN   : Boolean := False;
      IRLP   : Boolean := False;
      HDSEL  : Boolean := False;
      NACK   : Boolean := False;
      SCEN   : Boolean := False;
      DMAR   : Boolean := False;
      DMAT   : Boolean := False;
      RTSE   : Boolean := False;
      CTSE   : Boolean := False;
      CTSIE  : Boolean := False;
      ONEBIT : Boolean := False;
   end record with Size => 12;

   for USART_Register_CR3 use record
      EIE    at 0 range 0 .. 0;
      IREN   at 0 range 1 .. 1;
      IRLP   at 0 range 2 .. 2;
      HDSEL  at 0 range 3 .. 3;
      NACK   at 0 range 4 .. 4;
      SCEN   at 0 range 5 .. 5;
      DMAR   at 0 range 6 .. 6;
      DMAT   at 0 range 7 .. 7;
      RTSE   at 0 range 8 .. 8;
      CTSE   at 0 range 9 .. 9;
      CTSIE  at 0 range 10 ..10;
      ONEBIT at 0 range 11 ..11;
   end record;

   type USART_Register_GTPR is record
      PSC : Integer range 0 .. 255 := 0;
      GT  : Integer range 0 .. 255 := 0;
   end record with size => 16;

   for USART_Register_GTPR use record
      PSC at 0 range 0 .. 7;
      GT  at 0 range 8 .. 15;
   end record;


   type USART_type is record
      SR  : USART_Register_SR;
      DR  : Integer range 0 .. 65535;
      BRR : USART_Register_BRR;
      CR1 : USART_Register_CR1;
      CR2 : USART_Register_CR2;
      CR3 : USART_Register_CR3;
      GTPR : USART_Register_GTPR;
   end record;

   for USART_type use record
      SR   at 0  range 0 .. 15;
      DR   at 4  range 0 .. 15;
      BRR  at 8  range 0 .. 15;
      CR1  at 12 range 0 .. 15;
      CR2  at 16 range 0 .. 15;
      CR3  at 20 range 0 .. 15;
      GTPR at 24 range 0 .. 15;
   end record;

   USART : USART_type with Address =>  System'To_Address (Register_Base);
   pragma Import (Ada, USART);

end STM32F4.USART;