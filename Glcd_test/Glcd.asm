
_delay2S:

;Glcd.c,54 :: 		void delay2S(){                             // 2 seconds delay function
;Glcd.c,55 :: 		Delay_ms(2000);
	MOVLW      21
	MOVWF      R11+0
	MOVLW      75
	MOVWF      R12+0
	MOVLW      190
	MOVWF      R13+0
L_delay2S0:
	DECFSZ     R13+0, 1
	GOTO       L_delay2S0
	DECFSZ     R12+0, 1
	GOTO       L_delay2S0
	DECFSZ     R11+0, 1
	GOTO       L_delay2S0
	NOP
;Glcd.c,56 :: 		}
	RETURN
; end of _delay2S

_main:

;Glcd.c,58 :: 		void main() {
;Glcd.c,68 :: 		Glcd_Init();                              // Initialize GLCD
	CALL       _Glcd_Init+0
;Glcd.c,69 :: 		Glcd_Fill(0x00);                          // Clear GLCD
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Glcd.c,70 :: 		Glcd_Image(kawasaki1_bmp);                // Draw images
	MOVLW      _kawasaki1_bmp+0
	MOVWF      FARG_Glcd_Image_image+0
	MOVLW      hi_addr(_kawasaki1_bmp+0)
	MOVWF      FARG_Glcd_Image_image+1
	CALL       _Glcd_Image+0
;Glcd.c,71 :: 		delay2S();
	CALL       _delay2S+0
;Glcd.c,72 :: 		while(1) {
L_main1:
;Glcd.c,75 :: 		Glcd_Image(ninja21_bmp);
	MOVLW      _ninja21_bmp+0
	MOVWF      FARG_Glcd_Image_image+0
	MOVLW      hi_addr(_ninja21_bmp+0)
	MOVWF      FARG_Glcd_Image_image+1
	CALL       _Glcd_Image+0
;Glcd.c,76 :: 		delay2S();
	CALL       _delay2S+0
;Glcd.c,78 :: 		Glcd_Fill(0x00);                        // Clear GLCD
	CLRF       FARG_Glcd_Fill_pattern+0
	CALL       _Glcd_Fill+0
;Glcd.c,80 :: 		Glcd_Write_Text ("TEMPERATURE  READINGS", 0 , 1, 2);
	MOVLW      ?lstr1_Glcd+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	CLRF       FARG_Glcd_Write_Text_x_pos+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      2
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Glcd.c,83 :: 		Glcd_Write_Text ("Radiator sensor: 97C", 0, 4, 1);
	MOVLW      ?lstr2_Glcd+0
	MOVWF      FARG_Glcd_Write_Text_text+0
	CLRF       FARG_Glcd_Write_Text_x_pos+0
	MOVLW      4
	MOVWF      FARG_Glcd_Write_Text_page_num+0
	MOVLW      1
	MOVWF      FARG_Glcd_Write_Text_color+0
	CALL       _Glcd_Write_Text+0
;Glcd.c,85 :: 		delay2S();
	CALL       _delay2S+0
;Glcd.c,93 :: 		}
	GOTO       L_main1
;Glcd.c,94 :: 		}
	GOTO       $+0
; end of _main
