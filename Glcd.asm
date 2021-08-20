
_delay2S:

;Glcd.c,93 :: 		void delay2S(){                             // 2 seconds delay function
;Glcd.c,94 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_delay2S0:
	DECFSZ      R13, 1, 0
	BRA         L_delay2S0
	DECFSZ      R12, 1, 0
	BRA         L_delay2S0
	DECFSZ      R11, 1, 0
	BRA         L_delay2S0
	NOP
;Glcd.c,95 :: 		}
	RETURN      0
; end of _delay2S

_imageNinja:

;Glcd.c,97 :: 		void imageNinja () {
;Glcd.c,98 :: 		Glcd_Image(ninja21_bmp);
	MOVLW       _ninja21_bmp+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_ninja21_bmp+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_ninja21_bmp+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;Glcd.c,99 :: 		delay2S();
	CALL        _delay2S+0, 0
;Glcd.c,100 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;Glcd.c,101 :: 		}
	RETURN      0
; end of _imageNinja

_temp_read:

;Glcd.c,102 :: 		void temp_read () {
;Glcd.c,104 :: 		Glcd_Set_Font(font5x7, 5, 7, 32);
	MOVLW       _font5x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       5
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,105 :: 		Glcd_Write_Text ("TEMPERATURE  READINGS", 0 , 0, 2); //title
	MOVLW       ?lstr1_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr1_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,107 :: 		Glcd_Write_Text ("=====================", 0 , 1, 2); // separation line
	MOVLW       ?lstr2_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr2_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,111 :: 		meassure_rad = 0;
	CLRF        _meassure_rad+0 
	CLRF        _meassure_rad+1 
;Glcd.c,112 :: 		for (i = 0; i < 10; i++) {
	CLRF        _i+0 
	CLRF        _i+1 
L_temp_read1:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read85
	MOVLW       10
	SUBWF       _i+0, 0 
L__temp_read85:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read2
;Glcd.c,113 :: 		temper_rad = adc_read(0);
	CLRF        FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temper_rad+0 
	MOVF        R1, 0 
	MOVWF       _temper_rad+1 
;Glcd.c,114 :: 		meassure_rad = meassure_rad + temper_rad * (0.48875);
	CALL        _Word2Double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__temp_read+0 
	MOVF        R1, 0 
	MOVWF       FLOC__temp_read+1 
	MOVF        R2, 0 
	MOVWF       FLOC__temp_read+2 
	MOVF        R3, 0 
	MOVWF       FLOC__temp_read+3 
	MOVF        _meassure_rad+0, 0 
	MOVWF       R0 
	MOVF        _meassure_rad+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__temp_read+0, 0 
	MOVWF       R4 
	MOVF        FLOC__temp_read+1, 0 
	MOVWF       R5 
	MOVF        FLOC__temp_read+2, 0 
	MOVWF       R6 
	MOVF        FLOC__temp_read+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_rad+0 
	MOVF        R1, 0 
	MOVWF       _meassure_rad+1 
;Glcd.c,112 :: 		for (i = 0; i < 10; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Glcd.c,115 :: 		}
	GOTO        L_temp_read1
L_temp_read2:
;Glcd.c,117 :: 		meassure_rad = meassure_rad / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _meassure_rad+0, 0 
	MOVWF       R0 
	MOVF        _meassure_rad+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_rad+0 
	MOVF        R1, 0 
	MOVWF       _meassure_rad+1 
;Glcd.c,119 :: 		WordToStr(meassure_rad, txt);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,120 :: 		Glcd_Write_Text ("Radiator sensor:", 0, 2, 2);
	MOVLW       ?lstr3_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr3_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,121 :: 		Glcd_Write_Text   (txt, 95, 2, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,125 :: 		meassure_eng = 0;
	CLRF        _meassure_eng+0 
	CLRF        _meassure_eng+1 
;Glcd.c,126 :: 		for (i = 0; i < 10; i++) {
	CLRF        _i+0 
	CLRF        _i+1 
L_temp_read4:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read86
	MOVLW       10
	SUBWF       _i+0, 0 
L__temp_read86:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read5
;Glcd.c,127 :: 		temper_eng = adc_read(1);
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temper_eng+0 
	MOVF        R1, 0 
	MOVWF       _temper_eng+1 
;Glcd.c,128 :: 		meassure_eng = meassure_eng + temper_eng * (0.48875);
	CALL        _Word2Double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__temp_read+0 
	MOVF        R1, 0 
	MOVWF       FLOC__temp_read+1 
	MOVF        R2, 0 
	MOVWF       FLOC__temp_read+2 
	MOVF        R3, 0 
	MOVWF       FLOC__temp_read+3 
	MOVF        _meassure_eng+0, 0 
	MOVWF       R0 
	MOVF        _meassure_eng+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__temp_read+0, 0 
	MOVWF       R4 
	MOVF        FLOC__temp_read+1, 0 
	MOVWF       R5 
	MOVF        FLOC__temp_read+2, 0 
	MOVWF       R6 
	MOVF        FLOC__temp_read+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_eng+0 
	MOVF        R1, 0 
	MOVWF       _meassure_eng+1 
;Glcd.c,126 :: 		for (i = 0; i < 10; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Glcd.c,129 :: 		}
	GOTO        L_temp_read4
L_temp_read5:
;Glcd.c,131 :: 		meassure_eng = meassure_eng / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _meassure_eng+0, 0 
	MOVWF       R0 
	MOVF        _meassure_eng+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_eng+0 
	MOVF        R1, 0 
	MOVWF       _meassure_eng+1 
;Glcd.c,132 :: 		WordToStr(meassure_eng, txt);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,133 :: 		Glcd_Write_Text ("Engine sensor:", 0, 3, 2);
	MOVLW       ?lstr4_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr4_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,134 :: 		Glcd_Write_Text   (txt, 95, 3, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,136 :: 		meassure_oil = 0;
	CLRF        _meassure_oil+0 
	CLRF        _meassure_oil+1 
;Glcd.c,137 :: 		for (i = 0; i < 10; i++) {
	CLRF        _i+0 
	CLRF        _i+1 
L_temp_read7:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read87
	MOVLW       10
	SUBWF       _i+0, 0 
L__temp_read87:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read8
;Glcd.c,138 :: 		temper_oil = adc_read(2);
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temper_oil+0 
	MOVF        R1, 0 
	MOVWF       _temper_oil+1 
;Glcd.c,139 :: 		meassure_oil = meassure_oil + temper_oil * (0.48875);
	CALL        _Word2Double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__temp_read+0 
	MOVF        R1, 0 
	MOVWF       FLOC__temp_read+1 
	MOVF        R2, 0 
	MOVWF       FLOC__temp_read+2 
	MOVF        R3, 0 
	MOVWF       FLOC__temp_read+3 
	MOVF        _meassure_oil+0, 0 
	MOVWF       R0 
	MOVF        _meassure_oil+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__temp_read+0, 0 
	MOVWF       R4 
	MOVF        FLOC__temp_read+1, 0 
	MOVWF       R5 
	MOVF        FLOC__temp_read+2, 0 
	MOVWF       R6 
	MOVF        FLOC__temp_read+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_oil+0 
	MOVF        R1, 0 
	MOVWF       _meassure_oil+1 
;Glcd.c,137 :: 		for (i = 0; i < 10; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Glcd.c,140 :: 		}
	GOTO        L_temp_read7
L_temp_read8:
;Glcd.c,142 :: 		meassure_oil = meassure_oil / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _meassure_oil+0, 0 
	MOVWF       R0 
	MOVF        _meassure_oil+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_oil+0 
	MOVF        R1, 0 
	MOVWF       _meassure_oil+1 
;Glcd.c,144 :: 		WordToStr(meassure_oil, txt);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,145 :: 		Glcd_Write_Text ("Oil pan sensor:", 0, 4, 2);
	MOVLW       ?lstr5_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr5_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,146 :: 		Glcd_Write_Text   (txt, 95, 4, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,148 :: 		meassure_int = 0;
	CLRF        _meassure_int+0 
	CLRF        _meassure_int+1 
;Glcd.c,151 :: 		for (i = 0; i < 10; i++) {
	CLRF        _i+0 
	CLRF        _i+1 
L_temp_read10:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read88
	MOVLW       10
	SUBWF       _i+0, 0 
L__temp_read88:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read11
;Glcd.c,152 :: 		temper_int = adc_read(3);
	MOVLW       3
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _temper_int+0 
	MOVF        R1, 0 
	MOVWF       _temper_int+1 
;Glcd.c,153 :: 		meassure_int = meassure_int + temper_int * (0.48875);
	CALL        _Word2Double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	MOVF        R0, 0 
	MOVWF       FLOC__temp_read+0 
	MOVF        R1, 0 
	MOVWF       FLOC__temp_read+1 
	MOVF        R2, 0 
	MOVWF       FLOC__temp_read+2 
	MOVF        R3, 0 
	MOVWF       FLOC__temp_read+3 
	MOVF        _meassure_int+0, 0 
	MOVWF       R0 
	MOVF        _meassure_int+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVF        FLOC__temp_read+0, 0 
	MOVWF       R4 
	MOVF        FLOC__temp_read+1, 0 
	MOVWF       R5 
	MOVF        FLOC__temp_read+2, 0 
	MOVWF       R6 
	MOVF        FLOC__temp_read+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_int+0 
	MOVF        R1, 0 
	MOVWF       _meassure_int+1 
;Glcd.c,151 :: 		for (i = 0; i < 10; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Glcd.c,154 :: 		}
	GOTO        L_temp_read10
L_temp_read11:
;Glcd.c,156 :: 		meassure_int = meassure_int / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _meassure_int+0, 0 
	MOVWF       R0 
	MOVF        _meassure_int+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_int+0 
	MOVF        R1, 0 
	MOVWF       _meassure_int+1 
;Glcd.c,157 :: 		WordToStr(meassure_int, txt);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,158 :: 		Glcd_Write_Text ("Intake sensor:", 0, 5, 2);
	MOVLW       ?lstr6_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr6_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,159 :: 		Glcd_Write_Text   (txt, 95, 5, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,160 :: 		Glcd_Write_Text ("=====================", 0 , 6, 2); // separation line
	MOVLW       ?lstr7_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr7_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,161 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font
	MOVLW       _Character8x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       8
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,162 :: 		if  (meassure_eng <= 60 && meassure_eng >= 5)
	MOVLW       0
	MOVWF       R0 
	MOVF        _meassure_eng+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read89
	MOVF        _meassure_eng+0, 0 
	SUBLW       60
L__temp_read89:
	BTFSS       STATUS+0, 0 
	GOTO        L_temp_read15
	MOVLW       0
	SUBWF       _meassure_eng+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read90
	MOVLW       5
	SUBWF       _meassure_eng+0, 0 
L__temp_read90:
	BTFSS       STATUS+0, 0 
	GOTO        L_temp_read15
L__temp_read80:
;Glcd.c,163 :: 		Glcd_Write_Text ("**WARMING UP**", 0 , 7, 2); //separation line
	MOVLW       ?lstr8_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr8_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_temp_read16
L_temp_read15:
;Glcd.c,164 :: 		else if  (meassure_eng <= 100 && meassure_eng >= 61)
	MOVLW       0
	MOVWF       R0 
	MOVF        _meassure_eng+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read91
	MOVF        _meassure_eng+0, 0 
	SUBLW       100
L__temp_read91:
	BTFSS       STATUS+0, 0 
	GOTO        L_temp_read19
	MOVLW       0
	SUBWF       _meassure_eng+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read92
	MOVLW       61
	SUBWF       _meassure_eng+0, 0 
L__temp_read92:
	BTFSS       STATUS+0, 0 
	GOTO        L_temp_read19
L__temp_read79:
;Glcd.c,165 :: 		Glcd_Write_Text ("**COOLING OK**", 0 , 7, 2); //separation line
	MOVLW       ?lstr9_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr9_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_temp_read20
L_temp_read19:
;Glcd.c,166 :: 		else if  (meassure_eng <= 110 && meassure_eng >= 101)
	MOVLW       0
	MOVWF       R0 
	MOVF        _meassure_eng+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read93
	MOVF        _meassure_eng+0, 0 
	SUBLW       110
L__temp_read93:
	BTFSS       STATUS+0, 0 
	GOTO        L_temp_read23
	MOVLW       0
	SUBWF       _meassure_eng+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read94
	MOVLW       101
	SUBWF       _meassure_eng+0, 0 
L__temp_read94:
	BTFSS       STATUS+0, 0 
	GOTO        L_temp_read23
L__temp_read78:
;Glcd.c,167 :: 		Glcd_Write_Text ("**FAN ACTIVE**", 0 , 7, 2); //separation line
	MOVLW       ?lstr10_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr10_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_temp_read24
L_temp_read23:
;Glcd.c,168 :: 		else if  (meassure_eng >= 111)
	MOVLW       0
	SUBWF       _meassure_eng+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read95
	MOVLW       111
	SUBWF       _meassure_eng+0, 0 
L__temp_read95:
	BTFSS       STATUS+0, 0 
	GOTO        L_temp_read25
;Glcd.c,169 :: 		Glcd_Write_Text ("**OVERHEATED**", 0 , 7, 2); //separation line
	MOVLW       ?lstr11_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr11_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_temp_read25:
L_temp_read24:
L_temp_read20:
L_temp_read16:
;Glcd.c,170 :: 		delay2S(); delay2S();
	CALL        _delay2S+0, 0
	CALL        _delay2S+0, 0
;Glcd.c,172 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;Glcd.c,173 :: 		Glcd_Set_Font(font5x7, 5, 7, 32);
	MOVLW       _font5x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       5
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,174 :: 		Glcd_Write_Text ("MAXIMAL  TEMPERATURES", 0 , 0, 2); //title
	MOVLW       ?lstr12_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr12_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,176 :: 		Glcd_Write_Text ("=====================", 0 , 1, 2); // separation line
	MOVLW       ?lstr13_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr13_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,179 :: 		if (max_rad < temper_rad)
	MOVF        _temper_rad+1, 0 
	SUBWF       _max_rad+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read96
	MOVF        _temper_rad+0, 0 
	SUBWF       _max_rad+0, 0 
L__temp_read96:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read26
;Glcd.c,180 :: 		max_rad = temper_rad ;
	MOVF        _temper_rad+0, 0 
	MOVWF       _max_rad+0 
	MOVF        _temper_rad+1, 0 
	MOVWF       _max_rad+1 
	GOTO        L_temp_read27
L_temp_read26:
;Glcd.c,183 :: 		meassure_rad = max_rad * (0.48875);
	MOVF        _max_rad+0, 0 
	MOVWF       R0 
	MOVF        _max_rad+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_rad+0 
	MOVF        R1, 0 
	MOVWF       _meassure_rad+1 
L_temp_read27:
;Glcd.c,184 :: 		WordToStr(meassure_rad, txt);
	MOVF        _meassure_rad+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _meassure_rad+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,185 :: 		Glcd_Write_Text ("Maximal radiator:", 0, 2, 2);
	MOVLW       ?lstr14_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr14_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,186 :: 		Glcd_Write_Text   (txt, 95, 2, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,187 :: 		if (max_eng < temper_eng)
	MOVF        _temper_eng+1, 0 
	SUBWF       _max_eng+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read97
	MOVF        _temper_eng+0, 0 
	SUBWF       _max_eng+0, 0 
L__temp_read97:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read28
;Glcd.c,188 :: 		max_eng = temper_eng  ;
	MOVF        _temper_eng+0, 0 
	MOVWF       _max_eng+0 
	MOVF        _temper_eng+1, 0 
	MOVWF       _max_eng+1 
	GOTO        L_temp_read29
L_temp_read28:
;Glcd.c,191 :: 		meassure_eng = max_eng * (0.48875);
	MOVF        _max_eng+0, 0 
	MOVWF       R0 
	MOVF        _max_eng+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_eng+0 
	MOVF        R1, 0 
	MOVWF       _meassure_eng+1 
L_temp_read29:
;Glcd.c,192 :: 		WordToStr(meassure_eng, txt);
	MOVF        _meassure_eng+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _meassure_eng+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,193 :: 		Glcd_Write_Text ("Maximal engine:", 0, 3, 2);
	MOVLW       ?lstr15_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr15_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,194 :: 		Glcd_Write_Text   (txt, 95, 3, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,197 :: 		if (max_oil < temper_oil)
	MOVF        _temper_oil+1, 0 
	SUBWF       _max_oil+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read98
	MOVF        _temper_oil+0, 0 
	SUBWF       _max_oil+0, 0 
L__temp_read98:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read30
;Glcd.c,198 :: 		max_oil = temper_oil  ;
	MOVF        _temper_oil+0, 0 
	MOVWF       _max_oil+0 
	MOVF        _temper_oil+1, 0 
	MOVWF       _max_oil+1 
	GOTO        L_temp_read31
L_temp_read30:
;Glcd.c,202 :: 		meassure_oil = max_oil * (0.48875);
	MOVF        _max_oil+0, 0 
	MOVWF       R0 
	MOVF        _max_oil+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_oil+0 
	MOVF        R1, 0 
	MOVWF       _meassure_oil+1 
L_temp_read31:
;Glcd.c,203 :: 		WordToStr(meassure_oil, txt);
	MOVF        _meassure_oil+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _meassure_oil+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,204 :: 		Glcd_Write_Text ("Maximal oil:", 0, 4, 2);
	MOVLW       ?lstr16_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr16_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,205 :: 		Glcd_Write_Text   (txt, 95, 4, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,207 :: 		if (max_int < temper_int)
	MOVF        _temper_int+1, 0 
	SUBWF       _max_int+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read99
	MOVF        _temper_int+0, 0 
	SUBWF       _max_int+0, 0 
L__temp_read99:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read32
;Glcd.c,208 :: 		max_int = temper_int  ;
	MOVF        _temper_int+0, 0 
	MOVWF       _max_int+0 
	MOVF        _temper_int+1, 0 
	MOVWF       _max_int+1 
	GOTO        L_temp_read33
L_temp_read32:
;Glcd.c,212 :: 		meassure_int = max_int * (0.48875);
	MOVF        _max_int+0, 0 
	MOVWF       R0 
	MOVF        _max_int+1, 0 
	MOVWF       R1 
	CALL        _Word2Double+0, 0
	MOVLW       113
	MOVWF       R4 
	MOVLW       61
	MOVWF       R5 
	MOVLW       122
	MOVWF       R6 
	MOVLW       125
	MOVWF       R7 
	CALL        _Mul_32x32_FP+0, 0
	CALL        _Double2Word+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_int+0 
	MOVF        R1, 0 
	MOVWF       _meassure_int+1 
L_temp_read33:
;Glcd.c,213 :: 		WordToStr(meassure_int, txt);
	MOVF        _meassure_int+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _meassure_int+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,214 :: 		Glcd_Write_Text ("Maximal intake:", 0, 5, 2);
	MOVLW       ?lstr17_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr17_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,215 :: 		Glcd_Write_Text   (txt, 95, 5, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,216 :: 		Glcd_Write_Text ("=====================", 0 , 6, 2); // separation line
	MOVLW       ?lstr18_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr18_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,217 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font
	MOVLW       _Character8x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       8
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,218 :: 		if  (meassure_eng < meassure_rad)
	MOVF        _meassure_rad+1, 0 
	SUBWF       _meassure_eng+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read100
	MOVF        _meassure_rad+0, 0 
	SUBWF       _meassure_eng+0, 0 
L__temp_read100:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read34
;Glcd.c,220 :: 		Glcd_Write_Text("TEMP  WARNINGS", 0 , 7, 2); //separation line
	MOVLW       ?lstr19_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr19_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_temp_read35
L_temp_read34:
;Glcd.c,221 :: 		else if  (meassure_eng > 110)
	MOVLW       0
	MOVWF       R0 
	MOVF        _meassure_eng+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__temp_read101
	MOVF        _meassure_eng+0, 0 
	SUBLW       110
L__temp_read101:
	BTFSC       STATUS+0, 0 
	GOTO        L_temp_read36
;Glcd.c,222 :: 		Glcd_Write_Text("TEMP  WARNINGS", 0 , 7, 2); //separation line
	MOVLW       ?lstr20_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr20_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_temp_read37
L_temp_read36:
;Glcd.c,225 :: 		Glcd_Write_Text("**NO WARNING**", 0 , 7, 2); //separation line
	MOVLW       ?lstr21_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr21_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_temp_read37:
L_temp_read35:
;Glcd.c,226 :: 		delay2S();  delay2S();
	CALL        _delay2S+0, 0
	CALL        _delay2S+0, 0
;Glcd.c,233 :: 		}
	RETURN      0
; end of _temp_read

_volt_read:

;Glcd.c,235 :: 		void volt_read () {
;Glcd.c,239 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;Glcd.c,240 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;Glcd.c,245 :: 		Glcd_Set_Font(font5x7, 5, 7, 32);
	MOVLW       _font5x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       5
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,246 :: 		Glcd_Write_Text ("VOLTAGES & REGULATION", 0 , 0, 2); //title
	MOVLW       ?lstr22_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr22_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,248 :: 		Glcd_Write_Text ("=====================", 0 , 1, 2); // separation line
	MOVLW       ?lstr23_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr23_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,251 :: 		meassure = 0;
	CLRF        _meassure+0 
	CLRF        _meassure+1 
;Glcd.c,252 :: 		for (i = 0; i < 10; i++) {
	CLRF        _i+0 
	CLRF        _i+1 
L_volt_read38:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__volt_read102
	MOVLW       10
	SUBWF       _i+0, 0 
L__volt_read102:
	BTFSC       STATUS+0, 0 
	GOTO        L_volt_read39
;Glcd.c,253 :: 		batt_level = adc_read(5);
	MOVLW       5
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _batt_level+0 
	MOVF        R1, 0 
	MOVWF       _batt_level+1 
;Glcd.c,254 :: 		meassure = meassure + batt_level * (2);
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	RLCF        R2, 1 
	BCF         R2, 0 
	RLCF        R3, 1 
	MOVF        R2, 0 
	ADDWF       _meassure+0, 1 
	MOVF        R3, 0 
	ADDWFC      _meassure+1, 1 
;Glcd.c,252 :: 		for (i = 0; i < 10; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Glcd.c,255 :: 		}
	GOTO        L_volt_read38
L_volt_read39:
;Glcd.c,257 :: 		meassure_bat = meassure / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _meassure+0, 0 
	MOVWF       R0 
	MOVF        _meassure+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_bat+0 
	MOVF        R1, 0 
	MOVWF       _meassure_bat+1 
;Glcd.c,259 :: 		WordToStr(meassure_bat, txt);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,260 :: 		Glcd_Write_Text ("Current voltage:", 0, 2, 2);
	MOVLW       ?lstr24_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr24_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,261 :: 		Glcd_Write_Text   (txt, 95, 2, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,262 :: 		if (max_batt < batt_level)
	MOVF        _batt_level+1, 0 
	SUBWF       _max_batt+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__volt_read103
	MOVF        _batt_level+0, 0 
	SUBWF       _max_batt+0, 0 
L__volt_read103:
	BTFSC       STATUS+0, 0 
	GOTO        L_volt_read41
;Glcd.c,263 :: 		max_batt = batt_level ;
	MOVF        _batt_level+0, 0 
	MOVWF       _max_batt+0 
	MOVF        _batt_level+1, 0 
	MOVWF       _max_batt+1 
	GOTO        L_volt_read42
L_volt_read41:
;Glcd.c,266 :: 		meassure = max_batt * (2);
	MOVF        _max_batt+0, 0 
	MOVWF       _meassure+0 
	MOVF        _max_batt+1, 0 
	MOVWF       _meassure+1 
	RLCF        _meassure+0, 1 
	BCF         _meassure+0, 0 
	RLCF        _meassure+1, 1 
L_volt_read42:
;Glcd.c,267 :: 		WordToStr(meassure, txt);
	MOVF        _meassure+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _meassure+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,268 :: 		Glcd_Write_Text ("Maximal voltage:", 0, 3, 2);
	MOVLW       ?lstr25_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr25_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,269 :: 		Glcd_Write_Text   (txt, 95, 3, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,271 :: 		if (min_batt > batt_level)
	MOVF        _min_batt+1, 0 
	SUBWF       _batt_level+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__volt_read104
	MOVF        _min_batt+0, 0 
	SUBWF       _batt_level+0, 0 
L__volt_read104:
	BTFSC       STATUS+0, 0 
	GOTO        L_volt_read43
;Glcd.c,272 :: 		min_batt = batt_level;
	MOVF        _batt_level+0, 0 
	MOVWF       _min_batt+0 
	MOVF        _batt_level+1, 0 
	MOVWF       _min_batt+1 
	GOTO        L_volt_read44
L_volt_read43:
;Glcd.c,274 :: 		meassure = min_batt * (2);
	MOVF        _min_batt+0, 0 
	MOVWF       _meassure+0 
	MOVF        _min_batt+1, 0 
	MOVWF       _meassure+1 
	RLCF        _meassure+0, 1 
	BCF         _meassure+0, 0 
	RLCF        _meassure+1, 1 
L_volt_read44:
;Glcd.c,275 :: 		WordToStr(meassure, txt);
	MOVF        _meassure+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _meassure+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,276 :: 		Glcd_Write_Text ("Minimal voltage:", 0, 4, 2);
	MOVLW       ?lstr26_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr26_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,277 :: 		Glcd_Write_Text   (txt, 95, 4, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,278 :: 		Glcd_Write_Text ("=====================", 0 , 7, 2);
	MOVLW       ?lstr27_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr27_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,279 :: 		Glcd_Write_Text ("=====================", 0 , 5, 2); //separation line
	MOVLW       ?lstr28_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr28_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,280 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font
	MOVLW       _Character8x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       8
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,283 :: 		if  (meassure_bat <= 1000 && meassure_bat >= 1100)
	MOVF        _meassure_bat+1, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__volt_read105
	MOVF        _meassure_bat+0, 0 
	SUBLW       232
L__volt_read105:
	BTFSS       STATUS+0, 0 
	GOTO        L_volt_read47
	MOVLW       4
	SUBWF       _meassure_bat+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__volt_read106
	MOVLW       76
	SUBWF       _meassure_bat+0, 0 
L__volt_read106:
	BTFSS       STATUS+0, 0 
	GOTO        L_volt_read47
L__volt_read82:
;Glcd.c,284 :: 		Glcd_Write_Text("*LOW VOLTAGES*", 0, 6, 2);
	MOVLW       ?lstr29_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr29_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_volt_read48
L_volt_read47:
;Glcd.c,285 :: 		else if (meassure_bat >= 1100 && meassure_bat <= 1400)
	MOVLW       4
	SUBWF       _meassure_bat+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__volt_read107
	MOVLW       76
	SUBWF       _meassure_bat+0, 0 
L__volt_read107:
	BTFSS       STATUS+0, 0 
	GOTO        L_volt_read51
	MOVF        _meassure_bat+1, 0 
	SUBLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__volt_read108
	MOVF        _meassure_bat+0, 0 
	SUBLW       120
L__volt_read108:
	BTFSS       STATUS+0, 0 
	GOTO        L_volt_read51
L__volt_read81:
;Glcd.c,286 :: 		Glcd_Write_Text("*VOLTAGES  OK*", 0, 6, 2);
	MOVLW       ?lstr30_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr30_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_volt_read52
L_volt_read51:
;Glcd.c,287 :: 		else if (meassure_bat > 1400)
	MOVF        _meassure_bat+1, 0 
	SUBLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__volt_read109
	MOVF        _meassure_bat+0, 0 
	SUBLW       120
L__volt_read109:
	BTFSC       STATUS+0, 0 
	GOTO        L_volt_read53
;Glcd.c,288 :: 		Glcd_Write_Text("*OVERCHARGING*", 0, 6, 2);
	MOVLW       ?lstr31_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr31_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_volt_read54
L_volt_read53:
;Glcd.c,290 :: 		Glcd_Write_Text("*BATTERY FAIL*", 0, 6, 2);
	MOVLW       ?lstr32_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr32_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_volt_read54:
L_volt_read52:
L_volt_read48:
;Glcd.c,291 :: 		delay2S(); delay2S();
	CALL        _delay2S+0, 0
	CALL        _delay2S+0, 0
;Glcd.c,292 :: 		Glcd_Set_Font(font5x7, 5, 7, 32);
	MOVLW       _font5x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       5
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,294 :: 		}
	RETURN      0
; end of _volt_read

_fuel_read:

;Glcd.c,295 :: 		void fuel_read () {
;Glcd.c,299 :: 		Glcd_Init();
	CALL        _Glcd_Init+0, 0
;Glcd.c,300 :: 		Glcd_Fill(0x00);
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;Glcd.c,305 :: 		Glcd_Set_Font(font5x7, 5, 7, 32);
	MOVLW       _font5x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       5
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,306 :: 		Glcd_Write_Text ("     FUEL   LEVEL    ", 0 , 0, 2); //title
	MOVLW       ?lstr33_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr33_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	CLRF        FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,308 :: 		Glcd_Write_Text ("=====================", 0 , 1, 2); // separation line
	MOVLW       ?lstr34_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr34_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       1
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,311 :: 		meassure = 0;
	CLRF        _meassure+0 
	CLRF        _meassure+1 
;Glcd.c,312 :: 		for (i = 0; i < 10; i++) {
	CLRF        _i+0 
	CLRF        _i+1 
L_fuel_read55:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__fuel_read110
	MOVLW       10
	SUBWF       _i+0, 0 
L__fuel_read110:
	BTFSC       STATUS+0, 0 
	GOTO        L_fuel_read56
;Glcd.c,313 :: 		fuel_level = adc_read(4);
	MOVLW       4
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _fuel_level+0 
	MOVF        R1, 0 
	MOVWF       _fuel_level+1 
;Glcd.c,314 :: 		meassure = meassure + fuel_level ;
	MOVF        R0, 0 
	ADDWF       _meassure+0, 1 
	MOVF        R1, 0 
	ADDWFC      _meassure+1, 1 
;Glcd.c,312 :: 		for (i = 0; i < 10; i++) {
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;Glcd.c,315 :: 		}
	GOTO        L_fuel_read55
L_fuel_read56:
;Glcd.c,317 :: 		meassure_fuel = meassure / 10;
	MOVLW       10
	MOVWF       R4 
	MOVLW       0
	MOVWF       R5 
	MOVF        _meassure+0, 0 
	MOVWF       R0 
	MOVF        _meassure+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _meassure_fuel+0 
	MOVF        R1, 0 
	MOVWF       _meassure_fuel+1 
;Glcd.c,319 :: 		WordToStr(meassure_fuel, txt);
	MOVF        R0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        R1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,320 :: 		Glcd_Write_Text ("Current fuel:", 0, 2, 2);
	MOVLW       ?lstr35_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr35_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,321 :: 		Glcd_Write_Text   (txt, 95, 2, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,322 :: 		if (max_fuel < fuel_level)
	MOVF        _fuel_level+1, 0 
	SUBWF       _max_fuel+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__fuel_read111
	MOVF        _fuel_level+0, 0 
	SUBWF       _max_fuel+0, 0 
L__fuel_read111:
	BTFSC       STATUS+0, 0 
	GOTO        L_fuel_read58
;Glcd.c,323 :: 		max_fuel = fuel_level ;
	MOVF        _fuel_level+0, 0 
	MOVWF       _max_fuel+0 
	MOVF        _fuel_level+1, 0 
	MOVWF       _max_fuel+1 
	GOTO        L_fuel_read59
L_fuel_read58:
;Glcd.c,326 :: 		meassure = max_fuel;
	MOVF        _max_fuel+0, 0 
	MOVWF       _meassure+0 
	MOVF        _max_fuel+1, 0 
	MOVWF       _meassure+1 
L_fuel_read59:
;Glcd.c,327 :: 		WordToStr(meassure, txt);
	MOVF        _meassure+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _meassure+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,328 :: 		Glcd_Write_Text ("Maximal fuel:", 0, 3, 2);
	MOVLW       ?lstr36_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr36_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,329 :: 		Glcd_Write_Text   (txt, 95, 3, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,331 :: 		if (min_fuel > fuel_level)
	MOVF        _min_fuel+1, 0 
	SUBWF       _fuel_level+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__fuel_read112
	MOVF        _min_fuel+0, 0 
	SUBWF       _fuel_level+0, 0 
L__fuel_read112:
	BTFSC       STATUS+0, 0 
	GOTO        L_fuel_read60
;Glcd.c,332 :: 		min_fuel = fuel_level;
	MOVF        _fuel_level+0, 0 
	MOVWF       _min_fuel+0 
	MOVF        _fuel_level+1, 0 
	MOVWF       _min_fuel+1 
	GOTO        L_fuel_read61
L_fuel_read60:
;Glcd.c,334 :: 		meassure = min_fuel;
	MOVF        _min_fuel+0, 0 
	MOVWF       _meassure+0 
	MOVF        _min_fuel+1, 0 
	MOVWF       _meassure+1 
L_fuel_read61:
;Glcd.c,335 :: 		WordToStr(meassure, txt);
	MOVF        _meassure+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVF        _meassure+1, 0 
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _txt+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;Glcd.c,336 :: 		Glcd_Write_Text ("Minimal fuel:", 0, 4, 2);
	MOVLW       ?lstr37_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr37_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,337 :: 		Glcd_Write_Text   (txt, 95, 4, 2);
	MOVLW       _txt+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(_txt+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	MOVLW       95
	MOVWF       FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,338 :: 		Glcd_Write_Text ("=====================", 0 , 7, 2);
	MOVLW       ?lstr38_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr38_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,339 :: 		Glcd_Write_Text ("=====================", 0 , 5, 2); //separation line
	MOVLW       ?lstr39_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr39_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       5
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,340 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font
	MOVLW       _Character8x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       8
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,343 :: 		if  (meassure_fuel >=301 && meassure_fuel <= 380)
	MOVLW       1
	SUBWF       _meassure_fuel+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__fuel_read113
	MOVLW       45
	SUBWF       _meassure_fuel+0, 0 
L__fuel_read113:
	BTFSS       STATUS+0, 0 
	GOTO        L_fuel_read64
	MOVF        _meassure_fuel+1, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__fuel_read114
	MOVF        _meassure_fuel+0, 0 
	SUBLW       124
L__fuel_read114:
	BTFSS       STATUS+0, 0 
	GOTO        L_fuel_read64
L__fuel_read84:
;Glcd.c,345 :: 		Glcd_Write_Text("***LOW FUEL***", 0, 6, 2);
	MOVLW       ?lstr40_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr40_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_fuel_read65
L_fuel_read64:
;Glcd.c,346 :: 		else if (meassure_fuel >= 51 && meassure_fuel <= 300)
	MOVLW       0
	SUBWF       _meassure_fuel+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__fuel_read115
	MOVLW       51
	SUBWF       _meassure_fuel+0, 0 
L__fuel_read115:
	BTFSS       STATUS+0, 0 
	GOTO        L_fuel_read68
	MOVF        _meassure_fuel+1, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__fuel_read116
	MOVF        _meassure_fuel+0, 0 
	SUBLW       44
L__fuel_read116:
	BTFSS       STATUS+0, 0 
	GOTO        L_fuel_read68
L__fuel_read83:
;Glcd.c,347 :: 		Glcd_Write_Text("***FUEL  OK***", 0, 6, 2);
	MOVLW       ?lstr41_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr41_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_fuel_read69
L_fuel_read68:
;Glcd.c,348 :: 		else if (meassure_fuel <= 50)
	MOVLW       0
	MOVWF       R0 
	MOVF        _meassure_fuel+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__fuel_read117
	MOVF        _meassure_fuel+0, 0 
	SUBLW       50
L__fuel_read117:
	BTFSS       STATUS+0, 0 
	GOTO        L_fuel_read70
;Glcd.c,349 :: 		Glcd_Write_Text("**OVERFILLED**", 0, 6, 2);
	MOVLW       ?lstr42_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr42_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
	GOTO        L_fuel_read71
L_fuel_read70:
;Glcd.c,351 :: 		Glcd_Write_Text("***NO *FUEL***", 0, 6, 2);
	MOVLW       ?lstr43_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr43_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       6
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
L_fuel_read71:
L_fuel_read69:
L_fuel_read65:
;Glcd.c,352 :: 		delay2S(); delay2S();
	CALL        _delay2S+0, 0
	CALL        _delay2S+0, 0
;Glcd.c,353 :: 		Glcd_Set_Font(font5x7, 5, 7, 32);
	MOVLW       _font5x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_font5x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       5
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,355 :: 		}
	RETURN      0
; end of _fuel_read

_interrut:

;Glcd.c,356 :: 		void interrut() {
;Glcd.c,357 :: 		if (PORTC.F2==0) {
	BTFSC       PORTC+0, 2 
	GOTO        L_interrut72
;Glcd.c,358 :: 		Glcd_Fill(0x00);                          // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;Glcd.c,359 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font
	MOVLW       _Character8x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       8
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,361 :: 		Glcd_Write_Text(" GPX600 MENU  ", 0 , 3, 2); //separation line
	MOVLW       ?lstr44_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr44_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       3
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,362 :: 		Glcd_Write_Text("SETUP & CONFIG", 0 , 4, 2); //separation line
	MOVLW       ?lstr45_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr45_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,364 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_interrut73:
	DECFSZ      R13, 1, 0
	BRA         L_interrut73
	DECFSZ      R12, 1, 0
	BRA         L_interrut73
	DECFSZ      R11, 1, 0
	BRA         L_interrut73
	NOP
;Glcd.c,365 :: 		}
L_interrut72:
;Glcd.c,366 :: 		if (PORTC.F1==0)  {
	BTFSC       PORTC+0, 1 
	GOTO        L_interrut74
;Glcd.c,367 :: 		Glcd_Fill(0x00);                          // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;Glcd.c,368 :: 		Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font
	MOVLW       _Character8x7+0
	MOVWF       FARG_Glcd_Set_Font_activeFont+0 
	MOVLW       hi_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+1 
	MOVLW       higher_addr(_Character8x7+0)
	MOVWF       FARG_Glcd_Set_Font_activeFont+2 
	MOVLW       8
	MOVWF       FARG_Glcd_Set_Font_aFontWidth+0 
	MOVLW       7
	MOVWF       FARG_Glcd_Set_Font_aFontHeight+0 
	MOVLW       32
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+0 
	MOVLW       0
	MOVWF       FARG_Glcd_Set_Font_aFontOffs+1 
	CALL        _Glcd_Set_Font+0, 0
;Glcd.c,370 :: 		Glcd_Write_Text("NO OIL WARNING", 0 , 4, 2); //separation line
	MOVLW       ?lstr46_Glcd+0
	MOVWF       FARG_Glcd_Write_Text_text+0 
	MOVLW       hi_addr(?lstr46_Glcd+0)
	MOVWF       FARG_Glcd_Write_Text_text+1 
	CLRF        FARG_Glcd_Write_Text_x_pos+0 
	MOVLW       4
	MOVWF       FARG_Glcd_Write_Text_page_num+0 
	MOVLW       2
	MOVWF       FARG_Glcd_Write_Text_color+0 
	CALL        _Glcd_Write_Text+0, 0
;Glcd.c,371 :: 		Delay_ms(2000);
	MOVLW       21
	MOVWF       R11, 0
	MOVLW       75
	MOVWF       R12, 0
	MOVLW       190
	MOVWF       R13, 0
L_interrut75:
	DECFSZ      R13, 1, 0
	BRA         L_interrut75
	DECFSZ      R12, 1, 0
	BRA         L_interrut75
	DECFSZ      R11, 1, 0
	BRA         L_interrut75
	NOP
;Glcd.c,372 :: 		}
L_interrut74:
;Glcd.c,373 :: 		}
	RETURN      0
; end of _interrut

_main:

;Glcd.c,374 :: 		void main()
;Glcd.c,376 :: 		ADCON0 = 0x00;
	CLRF        ADCON0+0 
;Glcd.c,377 :: 		ADCON1 = 0x00;
	CLRF        ADCON1+0 
;Glcd.c,380 :: 		TRISA = 0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;Glcd.c,383 :: 		TRISB = 0x00;
	CLRF        TRISB+0 
;Glcd.c,384 :: 		TRISC = 0b11100111; // Set port b pins 6 & 7 as imputs
	MOVLW       231
	MOVWF       TRISC+0 
;Glcd.c,385 :: 		PORTC = 0b00000000; // clear portb
	CLRF        PORTC+0 
;Glcd.c,391 :: 		Glcd_Init();                              // Initialize GLCD
	CALL        _Glcd_Init+0, 0
;Glcd.c,392 :: 		Glcd_Fill(0x00);                          // Clear GLCD
	CLRF        FARG_Glcd_Fill_pattern+0 
	CALL        _Glcd_Fill+0, 0
;Glcd.c,393 :: 		Glcd_Image(kawasaki1_bmp);                // Draw images
	MOVLW       _kawasaki1_bmp+0
	MOVWF       FARG_Glcd_Image_image+0 
	MOVLW       hi_addr(_kawasaki1_bmp+0)
	MOVWF       FARG_Glcd_Image_image+1 
	MOVLW       higher_addr(_kawasaki1_bmp+0)
	MOVWF       FARG_Glcd_Image_image+2 
	CALL        _Glcd_Image+0, 0
;Glcd.c,394 :: 		delay2S();
	CALL        _delay2S+0, 0
;Glcd.c,395 :: 		while(1) {
L_main76:
;Glcd.c,397 :: 		interrut ();
	CALL        _interrut+0, 0
;Glcd.c,398 :: 		imageNinja ();
	CALL        _imageNinja+0, 0
;Glcd.c,399 :: 		interrut ();
	CALL        _interrut+0, 0
;Glcd.c,400 :: 		temp_read ();
	CALL        _temp_read+0, 0
;Glcd.c,401 :: 		interrut ();
	CALL        _interrut+0, 0
;Glcd.c,402 :: 		volt_read ();
	CALL        _volt_read+0, 0
;Glcd.c,403 :: 		interrut ();
	CALL        _interrut+0, 0
;Glcd.c,404 :: 		fuel_read ();
	CALL        _fuel_read+0, 0
;Glcd.c,416 :: 		}
	GOTO        L_main76
;Glcd.c,418 :: 		}
	GOTO        $+0
; end of _main
