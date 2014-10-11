pragma Restrictions (No_Elaboration_Code);
with System; use System;
with STM32F4.GenericPeripheral;
generic
   Register_Base : Positive;
   RCC_RESET_REGISTER_Base : Natural;
   RCC_ENABLE_REGISTER_Base : Natural;
   RCC_LOWPOW_REGISTER_Base : Natural;
   RCCBit : Natural;
   type Timer_Size is mod <>;
package STM32F4.TIM is
   package peripheral is new STM32F4.GenericPeripheral (
      RCC_RESET_REGISTER_Base  => RCC_RESET_REGISTER_Base,
      RCC_ENABLE_REGISTER_Base => RCC_ENABLE_REGISTER_Base,
      RCC_LOWPOW_REGISTER_Base => RCC_LOWPOW_REGISTER_Base,
      RCCBit                   => RCCBit);

   type Center_Alignment_type is (Edge, Down, Up, UpDown) with Size => 2;
   for Center_Alignment_type use (Edge=>0, Down=>1, Up =>2, UpDown=>3);

   type ClockDivision_type is (One, Two, Four) with Size => 2;
   for ClockDivision_type use (One=>0, Two=>1, Four =>2);

   type TIM_Register_CR1 is record
      CEN : Boolean;
      UDIS: Boolean;
      URS : Boolean;
      OPM : Boolean;
      DIR :Boolean;
      CMS : Center_Alignment_type;
      ARPE : Boolean;
      CKD :ClockDivision_type;
   end record;

   for TIM_Register_CR1 use record
       CEN at 0 range 0 .. 0;
       UDIS at 0 range 1 .. 1;
       URS at 0 range 2 .. 2;
       OPM at 0 range 3 .. 3;
       DIR at 0 range 4 .. 4;
       CMS at 0 range 5 .. 6;
       ARPE at 0 range 7 .. 7;
       CKD at 0 range 8 .. 9;
   end record;

   type MasterMode_type is (Reset, Enable, Update, Compare_Pulse, Compare_OC1, Compare_OC2, Compare_OC3, Compare_OC4)with Size => 3;
   for MasterMode_type use (Reset =>0, Enable=>1, Update=>2, Compare_Pulse=>3,
   Compare_OC1=>4, Compare_OC2=>5, Compare_OC3=>6, Compare_OC4 =>7);

   type TIM_Register_CR2 is record
         CCPC : Boolean;
         CCUS: Boolean;
         CCDS : Boolean;
         MMS : MasterMode_type;
         TI1S :Boolean;
         OIS1 : Boolean;
         OIS1N : Boolean;
         OIS2 : Boolean;
         OIS2N : Boolean;
         OIS3 : Boolean;
         OIS3N : Boolean;
         OIS4N : Boolean;
         RESERVED : Boolean :=False;
      end record with Volatile;

      for TIM_Register_CR2 use record
          CCPC at 0 range 0 .. 0;
          CCUS at 0 range 2 .. 2;
          CCDS at 0 range 3 .. 3;
          MMS at 0 range 4 .. 6;
          TI1S at 0 range 7 .. 7;
          OIS1 at 0 range 8  .. 8;
          OIS1N at 0 range  9.. 9;
          OIS2 at 0 range  10.. 10;
          OIS2N at 0 range  11.. 11;
          OIS3 at 0 range 12 .. 12;
          OIS3N at 0 range 13 .. 13;
          OIS4N at 0 range 14 .. 14;
          RESERVED at 0 range 15..15;
      end record;

    type SlaveMode is (Disabled, Encoder1, Encoder2, Encoder3, Reset, Gated, Trigger, External) with Size => 3;
    for SlaveMode use (Disabled =>0, Encoder1=>1, Encoder2=>2, Encoder3=>3, Reset=>4, Gated=>5, Trigger=>6, External=>7);

    type TriggerSelection is (Internal0, Internal1, Internal2, Internal3, TI1_Edge, TI1_Filtered, TI2_Filtered, External) with Size =>3;
    for TriggerSelection use(Internal0=>0, Internal1=>1, Internal2=>2, Internal3=>3,
    TI1_Edge=>4, TI1_Filtered=>5, TI2_Filtered=>6, External=>7);

    type Timer_Filter is (No_Filter, FCk_int_N2,FCk_int_N4,FCk_int_N8,
        FDTS2_N6, FDTS2_N8, FDTS4_N6, FDTS4_N8, FDTS8_N6, FDTS8_N8,
        FDTS16_N5, FDTS16_N6, FDTS16_N8, FDTS32_N5, FDTS32_N6, FDTS32_N8) with Size=>4;
    for Timer_Filter use (No_Filter=>0, FCk_int_N2=>1,FCk_int_N4=>2,FCk_int_N8=>3,
                                   FDTS2_N6=>4, FDTS2_N8=>5, FDTS4_N6=>6, FDTS4_N8=>7, FDTS8_N6=>8, FDTS8_N8=>9,
                                   FDTS16_N5=>10, FDTS16_N6=>11, FDTS16_N8=>12, FDTS32_N5=>13, FDTS32_N6=>14,
                                   FDTS32_N8=>15);
    type Trigger_Prescaler is (P_0, P_2, P_4, P_8) with Size => 2;
    for Trigger_Prescaler use(P_0=>0, P_2=>1, P_4=>2, P_8=>3);
    type TIM_Register_SMCR is record
        SMS:SlaveMode;
        TS:TriggerSelection;
        MSM:Boolean;
        EFT:Timer_Filter;
        ETPS:Trigger_Prescaler;
        ECE:Boolean;
        ETP:Boolean;
    end record with Volatile;
    for TIM_Register_SMCR use record
        SMS at 0 range 0..2;
        TS at 0 range 4..6;
        MSM at 0 range 7..7;
        EFT at 0 range 8..11;
        ETPS at 0 range 12..13;
        ECE at 0 range 14..14;
        ETP at 0 range 15..15;
    end record;

   type Capture_Compare_Selection is (Output, Input_TI1, Input_TI2, Input_TRC) with Size=>2;
   for Capture_Compare_Selection use(Output=>0, Input_TI1=>1, Input_TI2=>2, Input_TRC=>3);

   type Input_Prescaler is (P_1, P_2, P_4, P_8) with Size=>2;
   for Input_Prescaler use(P_1=>0, P_2=>1, P_4=>2, P_8=>3);

   type Output_Compare_Mode is (Frozen, Match_High, Match_Low, Toggle, Force_Low, Force_High, PWM1, PWM2) with Size => 3;
   for Output_Compare_Mode use (Frozen=>0, Match_High=>1, Match_Low=>2, Toggle=>3, Force_Low=>4, Force_High=>5,
   PWM1=>6, PWM2=>7);

   type TIM_Register_CCMR (CCxS : Capture_Compare_Selection := Output) is record
      case CCxS is
         when Output=>
            OCxFE:Boolean := false;
            OCxPE:Boolean := false;
            OCxM:Output_Compare_Mode := Frozen;
            OCxCE : Boolean := false;
         when Input_TI1 .. Input_TRC =>
            ICxPSC: Input_Prescaler := P_1;
            ICxFF: Timer_Filter := No_Filter;
      end case;
   end record with Size=>8;
   for TIM_Register_CCMR use record
           CCxS at 0 range 0..1;
           OCxFE at 0 range 2..2;
           OCxPE at 0 range 3..3;
           OCxM at 0 range 4..6;
           OCxCE at 0 range 7..7;
           ICxPSC at 0 range 2..3;
           ICxFF at 0 range 4..7;
   end record;

   type TIM_Register is record
      CR1   : TIM_Register_CR1;  --  control register 1
      CR2   : TIM_Register_CR2;  --  control register 2
      SMCR  : TIM_Register_SMCR;  --  slave mode control register
      -- TBD
      DIER  : Word;  --  DMA/interrupt enable register
      SR    : Word;       --  status register
      EGR   : Word;       --  event generation register
      CCMR_Ch1 : TIM_Register_CCMR; --  capture/compare mode register, split by channel
      CCMR_Ch2 : TIM_Register_CCMR;
      CCMR_Ch3 : TIM_Register_CCMR;
      CCMR_Ch4 : TIM_Register_CCMR;
      CCER  : Word;   --  capture/compare enable register
      CNT   : Timer_Size;   --  counter
      PSC   : Timer_Size;   --  prescaler
      ARR   : Timer_Size;   --   auto-reload register
      RCR   : Word;   --  repetition counter register
      CCR1  : Timer_Size;   --  capture/compare register 1
      CCR2  : Timer_Size;   --  capture/compare register 2
      CCR3  : Timer_Size;   --  capture/compare register 3
      CCR4  : Timer_Size;   --  capture/compare register 4
      BDTR  : Word;   --  alternate function high register
      DCR   : Word;   --  DMA control register
      DMAR  : Word;   --  DMA address for full transfer
   end record;

   for TIM_Register use record
      CR1   at 0 range 0 .. 15;
      CR2   at 4 range 0 .. 15;
      SMCR  at 8 range 0 .. 15;
      DIER  at 12 range 0 .. 31;
      SR    at 16 range 0 .. 31;
      EGR   at 20 range 0 .. 31;
      CCMR_Ch1 at 24 range 0 .. 7;
      CCMR_Ch2 at 25 range 0 .. 7;
      -- yes there is a hole here
      -- actually in this bank all the registers are 16 bits long with a 32bit alignment
      CCMR_Ch3 at 28 range 0 .. 7;
      CCMR_Ch4 at 29 range 0 .. 7;
      CCER  at 32 range 0 .. 31;
      CNT   at 36 range 0 .. 31;
      PSC   at 40 range 0 .. 31;
      ARR   at 44 range 0 .. 31;
      RCR   at 48 range 0 .. 31;
      CCR1  at 52 range 0 .. 15;
      CCR2  at 56 range 0 .. 15;
      CCR3  at 60 range 0 .. 15;
      CCR4  at 64 range 0 .. 15;
      BDTR  at 68 range 0 .. 31;
      DCR   at 72 range 0 .. 31;
      DMAR  at 76 range 0 .. 31;
   end record;

   TIM : TIM_Register with
        Volatile, Address => System'To_Address (Register_Base);
   pragma Import (Ada, TIM);

    ALIASED_CR1_CEN : Boolean with Atomic, Size=>32, Address => PeriphBitBand(Register_Base, 0);
end STM32F4.TIM;
