/*
 * Project name:
     RTC2_Read (Reading date/time data from DS1307 through I2C)
 * Copyright:
     (c) MikroElektronika, 2005-2009
 * Revision History:
     20090504:
       -  Author: Igor Stancic;
 * Description:
     This project is simple demonstration how to read date and time from DS1307
     RTC (real-time clock). The code MCU use MSSP module at PORTC.
     Date and time are printed at LCD.
 * Test configuration:
     MCU:             PIC16F887
     Dev.Board:       EasyPIC5
     Oscillator:      HS, 8.000MHz
     Ext. Modules:    IC RTC (DS1307), LCD 2x16 chars
     SW:              mikroC PRO v1.65
 * NOTES:
     - For proper I2C communication, pins on PORTC must be in the pull-up mode,
       RC3 - pin 6 DS1307  - SCL,
       RC4 - pin 5 DS1307 - SDA,
       and the LEDs on board switched OFF!
*/

unsigned char sec, min1, hr, week_day, day, mn, year;
char *txt, tnum[4];

// LCD module connections
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
// End LCD module connections

void Zero_Fill(char *value) {    // fill text repesentation
  if (value[1] == 0) {           //      with leading zero
    value[1] = value[0];
    value[0] = 48;
    value[2] = 0;
  }
}//~

//--------------------- Reads time and date information from RTC (DS1307)
void Read_Time(char *sec, char *min, char *hr, char *week_day, char *day, char *mn, char *year) {
  I2C1_Start();
  I2C1_Wr(0xD0);
  I2C1_Wr(0);
  I2C1_Repeated_Start();
  I2C1_Wr(0xD1);
  *sec =I2C1_Rd(1);
  *min =I2C1_Rd(1);
  *hr =I2C1_Rd(1);
  *week_day =I2C1_Rd(1);
  *day =I2C1_Rd(1);
  *mn =I2C1_Rd(1);
  *year =I2C1_Rd(0);
  I2C1_Stop();
}//~

//-------------------- Formats date and time
void Transform_Time(char  *sec, char *min, char *hr, char *week_day, char *day, char *mn, char *year) {
  *sec  =  ((*sec & 0x70) >> 4)*10 + (*sec & 0x0F);
  *min  =  ((*min & 0xF0) >> 4)*10 + (*min & 0x0F);
  *hr   =  ((*hr & 0x30) >> 4)*10 + (*hr & 0x0F);
  *week_day =(*week_day & 0x07);
  *day  =  ((*day & 0xF0) >> 4)*10 + (*day & 0x0F);
  *mn   =  ((*mn & 0x10) >> 4)*10 + (*mn & 0x0F);
  *year =  ((*year & 0xF0)>>4)*10+(*year & 0x0F);
}//~

//-------------------- Output values to LCD
void Display_Time(char sec, char min, char hr, char week_day, char day, char mn, char year) {
   switch(week_day){
     case 1: txt="Sun"; break;
     case 2: txt="Mon"; break;
     case 3: txt="Tue"; break;
     case 4: txt="Wed"; break;
     case 5: txt="Thu"; break;
     case 6: txt="Fri"; break;
     case 7: txt="Sat"; break;
   }
   LCD_Out(1,1,txt);
   Lcd_Chr(1, 6, (day / 10)   + 48);    // Print tens digit of day variable
   Lcd_Chr(1, 7, (day % 10)   + 48);    // Print oness digit of day variable
   Lcd_Chr(1, 9, (mn / 10) + 48);
   Lcd_Chr(1,10, (mn % 10) + 48);
   Lcd_Chr(1,15,  year  + 48);          // Print year vaiable + 8 (start from year 2008)

   Lcd_Chr(2, 6, (hr / 10)   + 48);
   Lcd_Chr(2, 7, (hr % 10)   + 48);
   Lcd_Chr(2, 9, (min / 10) + 48);
   Lcd_Chr(2,10, (min % 10) + 48);
   Lcd_Chr(2,12, (sec / 10) + 48);
   Lcd_Chr(2,13, (sec % 10) + 48);
   
}//~

//------------------ Performs project-wide init
void Init_Main() {
  ANSEL=0;
  ANSELH=0;

  Lcd_Init();                // Initialize LCD
  Lcd_Cmd(_LCD_CLEAR);       // Clear LCD display
  Lcd_Cmd(_LCD_CURSOR_OFF);  // Turn cursor off

  I2C1_Init(100000);                        // initialize I2C
  LCD_Chr(1,8,'.');
  LCD_Chr(1,11,'.');
  txt = "Time:";
  LCD_Out(2,1,txt);
  LCD_Chr(2,8,':');
  LCD_Chr(2,11,':');
  txt = "200";
  LCD_Out(1,12,txt);
  LCD_Cmd(_LCD_CURSOR_OFF);
}//~

//----------------- Main procedure
void main() {
  Init_Main();                                               // perform initialization
  while (1) {
    Read_Time(&sec,&min1,&hr,&week_day,&day,&mn,&year);      // read time from RTC(DS1307)
    Transform_Time(&sec,&min1,&hr,&week_day,&day,&mn,&year); // format date and time
    Display_Time(sec, min1, hr, week_day, day, mn, year);    // prepare and display on LCD
    Delay_ms(1000);                                          // wait 1s
  }
}//
