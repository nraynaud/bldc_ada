pragma Restrictions (No_Elaboration_Code);

package STM32F4.Busses is

   type AHB1_type is record
      GPIOA      : Boolean;
      GPIOB      : Boolean;
      GPIOC      : Boolean;
      GPIOD      : Boolean;
      GPIOE      : Boolean;
      GPIOF      : Boolean;
      GPIOG      : Boolean;
      GPIOH      : Boolean;
      GPIOI      : Boolean;
      CRC        : Boolean;
      FLITF      : Boolean;-- enabled by default
      SRAM1      : Boolean;-- enabled by default
      SRAM2      : Boolean;-- enabled by default
      BKPSRAM    : Boolean;
      CCMDATARAM : Boolean; --not for reset
      DMA1       : Boolean;
      DMA2       : Boolean;
      ETHMAC     : Boolean;
      ETHMACTX   : Boolean; --not for reset
      ETHMACRX   : Boolean; --not for reset
      ETHMACPTP  : Boolean; --not for reset
      OTGHS      : Boolean;
      OTGHSULPI  : Boolean;
   end record with Size => 32;

   for AHB1_type use record
      GPIOA at 0 range 0 .. 0;
      GPIOB at 0 range 1 .. 1;
      GPIOC at 0 range 2 .. 2;
      GPIOD at 0 range 3 .. 3;
      GPIOE at 0 range 4 .. 4;
      GPIOF at 0 range 5 .. 5;
      GPIOG at 0 range 6 .. 6;
      GPIOH at 0 range 7 .. 7;
      GPIOI at 0 range 8 .. 8;

      CRC at 0 range 12 .. 12;

      FLITF   at 0 range 15 .. 15;
      SRAM1   at 0 range 16 .. 16;
      SRAM2   at 0 range 17 .. 17;
      BKPSRAM at 0 range 18 .. 18;

      CCMDATARAM at 0 range 20 .. 20;
      DMA1       at 0 range 21 .. 21;
      DMA2       at 0 range 22 .. 22;

      ETHMAC    at 0 range 25 .. 25;
      ETHMACTX  at 0 range 26 .. 26;
      ETHMACRX  at 0 range 27 .. 27;
      ETHMACPTP at 0 range 28 .. 28;
      OTGHS     at 0 range 29 .. 29;
      OTGHSULPI at 0 range 30 .. 30;
   end record;

   type APB1_type is record
      TIM2  : Boolean;
      TIM3  : Boolean;
      TIM4  : Boolean;
      TIM5  : Boolean;
      TIM6  : Boolean;
      TIM7  : Boolean;
      TIM12 : Boolean;
      TIM13 : Boolean;
      TIM14 : Boolean;

      WWDG  : Boolean;

      SPI2  : Boolean;
      SPI3  : Boolean;

      UART2 : Boolean;
      UART3 : Boolean;
      UART4 : Boolean;
      UART5 : Boolean;
      I2C1  : Boolean;
      I2C2  : Boolean;
      I2C3  : Boolean;

      CAN1  : Boolean;
      CAN2  : Boolean;

      PWR   : Boolean;
      DACR  : Boolean;
   end record with Size => 32;

   for APB1_type use record
      TIM2  at 0 range 0 .. 0;
      TIM3  at 0 range 1 .. 1;
      TIM4  at 0 range 2 .. 2;
      TIM5  at 0 range 3 .. 3;
      TIM6  at 0 range 4 .. 4;
      TIM7  at 0 range 5 .. 5;
      TIM12 at 0 range 6 .. 6;
      TIM13 at 0 range 7 .. 7;
      TIM14 at 0 range 8 .. 8;

      WWDG  at 0 range 11 .. 11;

      SPI2  at 0 range 14 .. 14;
      SPI3  at 0 range 15 .. 15;

      UART2 at 0 range 17 .. 17;
      UART3 at 0 range 18 .. 18;
      UART4 at 0 range 19 .. 19;
      UART5 at 0 range 20 .. 20;
      I2C1  at 0 range 21 .. 21;
      I2C2  at 0 range 22 .. 22;
      I2C3  at 0 range 23 .. 23;

      CAN1  at 0 range 25 .. 25;
      CAN2  at 0 range 26 .. 26;

      PWR   at 0 range 28 .. 28;
      DACR  at 0 range 29 .. 29;
   end record;

   type AHB2_type is record
      DCMI  : Boolean;
      CRYPT : Boolean;
      HASH  : Boolean;
      RNG   : Boolean;
      OTGFS : Boolean;
   end record with Size => 32;

   for AHB2_type use record
      DCMI  at 0 range 0 .. 0;
      CRYPT at 0 range 4 .. 4;
      HASH  at 0 range 5 .. 5;
      RNG   at 0 range 6 .. 6;
      OTGFS at 0 range 7 .. 7;
   end record;

   type APB2_type is record
    TIM1: Boolean;
    TIM8: Boolean;

    USART1: Boolean;
    USART6: Boolean;
    ADC1: Boolean;
    ADC2: Boolean;
    ADC3: Boolean;
    SDIO: Boolean;
    SPI1: Boolean;
    SYSCFG: Boolean;
    TIM9: Boolean;
    TIM10: Boolean;
    TIM11: Boolean;
   end record with Size =>32;

   for APB2_type use record
    TIM1 at 0 range 0 .. 0;
    TIM8 at 0 range 1 .. 1;

    USART1  at 0 range 4 .. 4;
    USART6  at 0 range 5 .. 5;

    ADC1  at 0 range 8 .. 8;--reset all the ADCs
    ADC2  at 0 range 9 .. 9;
    ADC3 at 0 range 10 .. 10;
    SDIO at 0 range 11 .. 11;
    SPI1 at 0 range 12 .. 12;

    SYSCFG  at 0 range 14 .. 14;

    TIM9 at 0 range 16 .. 16;
    TIM10 at 0 range 17 .. 17;
    TIM11 at 0 range 18 .. 18;
   end record;
end STM32F4.Busses;
