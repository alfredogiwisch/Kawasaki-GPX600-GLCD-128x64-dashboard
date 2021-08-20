#line 1 "C:/Users/Alfredo/Desktop/New Folder (2)/Glcd452/Glcd.c"
#line 30 "C:/Users/Alfredo/Desktop/New Folder (2)/Glcd452/Glcd.c"
const code char kawasaki1_bmp[1024];
const code char ninja21_bmp[1024];
 unsigned short int0 = 0;

 unsigned temper_rad;
 unsigned temper_eng;
 unsigned temper_oil;
 unsigned temper_int;
 unsigned max_rad;
 unsigned max_eng;
 unsigned max_oil;
 unsigned max_int;

 unsigned batt_level;
 unsigned max_batt;
 unsigned min_batt = 1800;
 unsigned fuel_level;
 unsigned max_fuel;
 unsigned min_fuel;


 unsigned meassure_rad;
 unsigned meassure_eng;
 unsigned meassure_oil;
 unsigned meassure_int;
 unsigned meassure_bat;
 unsigned meassure_fuel;
 unsigned meassure;
 char txt[6];


 int i;
#line 75 "C:/Users/Alfredo/Desktop/New Folder (2)/Glcd452/Glcd.c"
char GLCD_DataPort at PORTD;

sbit GLCD_CS1 at RB0_bit;
sbit GLCD_CS2 at RB1_bit;
sbit GLCD_RS at RB2_bit;
sbit GLCD_RW at RB3_bit;
sbit GLCD_EN at RB4_bit;
sbit GLCD_RST at RB5_bit;

sbit GLCD_CS1_Direction at TRISB6_bit;
sbit GLCD_CS2_Direction at TRISB7_bit;
sbit GLCD_RS_Direction at TRISB2_bit;
sbit GLCD_RW_Direction at TRISB3_bit;
sbit GLCD_EN_Direction at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;



void delay2S(){
 Delay_ms(2000);
}

void imageNinja () {
 Glcd_Image(ninja21_bmp);
 delay2S();
 Glcd_Fill(0x00);
}
void temp_read () {

 Glcd_Set_Font(font5x7, 5, 7, 32);
 Glcd_Write_Text ("TEMPERATURE  READINGS", 0 , 0, 2);

 Glcd_Write_Text ("=====================", 0 , 1, 2);



 meassure_rad = 0;
 for (i = 0; i < 10; i++) {
 temper_rad = adc_read(0);
 meassure_rad = meassure_rad + temper_rad * (0.48875);
 }

 meassure_rad = meassure_rad / 10;

 WordToStr(meassure_rad, txt);
 Glcd_Write_Text ("Radiator sensor:", 0, 2, 2);
 Glcd_Write_Text (txt, 95, 2, 2);



 meassure_eng = 0;
 for (i = 0; i < 10; i++) {
 temper_eng = adc_read(1);
 meassure_eng = meassure_eng + temper_eng * (0.48875);
 }

 meassure_eng = meassure_eng / 10;
 WordToStr(meassure_eng, txt);
 Glcd_Write_Text ("Engine sensor:", 0, 3, 2);
 Glcd_Write_Text (txt, 95, 3, 2);

 meassure_oil = 0;
 for (i = 0; i < 10; i++) {
 temper_oil = adc_read(2);
 meassure_oil = meassure_oil + temper_oil * (0.48875);
 }

 meassure_oil = meassure_oil / 10;

 WordToStr(meassure_oil, txt);
 Glcd_Write_Text ("Oil pan sensor:", 0, 4, 2);
 Glcd_Write_Text (txt, 95, 4, 2);

 meassure_int = 0;


 for (i = 0; i < 10; i++) {
 temper_int = adc_read(3);
 meassure_int = meassure_int + temper_int * (0.48875);
 }

 meassure_int = meassure_int / 10;
 WordToStr(meassure_int, txt);
 Glcd_Write_Text ("Intake sensor:", 0, 5, 2);
 Glcd_Write_Text (txt, 95, 5, 2);
 Glcd_Write_Text ("=====================", 0 , 6, 2);
 Glcd_Set_Font(Character8x7, 8, 7, 32);
 if (meassure_eng <= 60 && meassure_eng >= 5)
 Glcd_Write_Text ("**WARMING UP**", 0 , 7, 2);
 else if (meassure_eng <= 100 && meassure_eng >= 61)
 Glcd_Write_Text ("**COOLING OK**", 0 , 7, 2);
 else if (meassure_eng <= 110 && meassure_eng >= 101)
 Glcd_Write_Text ("**FAN ACTIVE**", 0 , 7, 2);
 else if (meassure_eng >= 111)
 Glcd_Write_Text ("**OVERHEATED**", 0 , 7, 2);
 delay2S(); delay2S();

 Glcd_Fill(0x00);
 Glcd_Set_Font(font5x7, 5, 7, 32);
 Glcd_Write_Text ("MAXIMAL  TEMPERATURES", 0 , 0, 2);

 Glcd_Write_Text ("=====================", 0 , 1, 2);


 if (max_rad < temper_rad)
 max_rad = temper_rad ;
 else

 meassure_rad = max_rad * (0.48875);
 WordToStr(meassure_rad, txt);
 Glcd_Write_Text ("Maximal radiator:", 0, 2, 2);
 Glcd_Write_Text (txt, 95, 2, 2);
 if (max_eng < temper_eng)
 max_eng = temper_eng ;
 else

 meassure_eng = max_eng * (0.48875);
 WordToStr(meassure_eng, txt);
 Glcd_Write_Text ("Maximal engine:", 0, 3, 2);
 Glcd_Write_Text (txt, 95, 3, 2);


 if (max_oil < temper_oil)
 max_oil = temper_oil ;
 else


 meassure_oil = max_oil * (0.48875);
 WordToStr(meassure_oil, txt);
 Glcd_Write_Text ("Maximal oil:", 0, 4, 2);
 Glcd_Write_Text (txt, 95, 4, 2);

 if (max_int < temper_int)
 max_int = temper_int ;
 else


 meassure_int = max_int * (0.48875);
 WordToStr(meassure_int, txt);
 Glcd_Write_Text ("Maximal intake:", 0, 5, 2);
 Glcd_Write_Text (txt, 95, 5, 2);
 Glcd_Write_Text ("=====================", 0 , 6, 2);
 Glcd_Set_Font(Character8x7, 8, 7, 32);
 if (meassure_eng < meassure_rad)

 Glcd_Write_Text("TEMP  WARNINGS", 0 , 7, 2);
 else if (meassure_eng > 110)
 Glcd_Write_Text("TEMP  WARNINGS", 0 , 7, 2);
 else

 Glcd_Write_Text("**NO WARNING**", 0 , 7, 2);
 delay2S(); delay2S();






}

void volt_read () {



 Glcd_Init();
 Glcd_Fill(0x00);




 Glcd_Set_Font(font5x7, 5, 7, 32);
 Glcd_Write_Text ("VOLTAGES & REGULATION", 0 , 0, 2);

 Glcd_Write_Text ("=====================", 0 , 1, 2);


 meassure = 0;
 for (i = 0; i < 10; i++) {
 batt_level = adc_read(5);
 meassure = meassure + batt_level * (2);
 }

 meassure_bat = meassure / 10;

 WordToStr(meassure_bat, txt);
 Glcd_Write_Text ("Current voltage:", 0, 2, 2);
 Glcd_Write_Text (txt, 95, 2, 2);
 if (max_batt < batt_level)
 max_batt = batt_level ;
 else

 meassure = max_batt * (2);
 WordToStr(meassure, txt);
 Glcd_Write_Text ("Maximal voltage:", 0, 3, 2);
 Glcd_Write_Text (txt, 95, 3, 2);

 if (min_batt > batt_level)
 min_batt = batt_level;
 else
 meassure = min_batt * (2);
 WordToStr(meassure, txt);
 Glcd_Write_Text ("Minimal voltage:", 0, 4, 2);
 Glcd_Write_Text (txt, 95, 4, 2);
 Glcd_Write_Text ("=====================", 0 , 7, 2);
 Glcd_Write_Text ("=====================", 0 , 5, 2);
 Glcd_Set_Font(Character8x7, 8, 7, 32);


if (meassure_bat <= 1000 && meassure_bat >= 1100)
 Glcd_Write_Text("*LOW VOLTAGES*", 0, 6, 2);
 else if (meassure_bat >= 1100 && meassure_bat <= 1400)
 Glcd_Write_Text("*VOLTAGES  OK*", 0, 6, 2);
 else if (meassure_bat > 1400)
 Glcd_Write_Text("*OVERCHARGING*", 0, 6, 2);
 else
 Glcd_Write_Text("*BATTERY FAIL*", 0, 6, 2);
 delay2S(); delay2S();
 Glcd_Set_Font(font5x7, 5, 7, 32);

}
void fuel_read () {



 Glcd_Init();
 Glcd_Fill(0x00);




 Glcd_Set_Font(font5x7, 5, 7, 32);
 Glcd_Write_Text ("     FUEL   LEVEL    ", 0 , 0, 2);

 Glcd_Write_Text ("=====================", 0 , 1, 2);


 meassure = 0;
 for (i = 0; i < 10; i++) {
 fuel_level = adc_read(4);
 meassure = meassure + fuel_level ;
 }

 meassure_fuel = meassure / 10;

 WordToStr(meassure_fuel, txt);
 Glcd_Write_Text ("Current fuel:", 0, 2, 2);
 Glcd_Write_Text (txt, 95, 2, 2);
 if (max_fuel < fuel_level)
 max_fuel = fuel_level ;
 else

 meassure = max_fuel;
 WordToStr(meassure, txt);
 Glcd_Write_Text ("Maximal fuel:", 0, 3, 2);
 Glcd_Write_Text (txt, 95, 3, 2);

 if (min_fuel > fuel_level)
 min_fuel = fuel_level;
 else
 meassure = min_fuel;
 WordToStr(meassure, txt);
 Glcd_Write_Text ("Minimal fuel:", 0, 4, 2);
 Glcd_Write_Text (txt, 95, 4, 2);
 Glcd_Write_Text ("=====================", 0 , 7, 2);
 Glcd_Write_Text ("=====================", 0 , 5, 2);
 Glcd_Set_Font(Character8x7, 8, 7, 32);


if (meassure_fuel >=301 && meassure_fuel <= 380)

 Glcd_Write_Text("***LOW FUEL***", 0, 6, 2);
 else if (meassure_fuel >= 51 && meassure_fuel <= 300)
 Glcd_Write_Text("***FUEL  OK***", 0, 6, 2);
 else if (meassure_fuel <= 50)
 Glcd_Write_Text("**OVERFILLED**", 0, 6, 2);
 else
 Glcd_Write_Text("***NO *FUEL***", 0, 6, 2);
 delay2S(); delay2S();
 Glcd_Set_Font(font5x7, 5, 7, 32);

}
void interrut() {
if (PORTC.F2==0) {
 Glcd_Fill(0x00);
 Glcd_Set_Font(Character8x7, 8, 7, 32);

 Glcd_Write_Text(" GPX600 MENU  ", 0 , 3, 2);
 Glcd_Write_Text("SETUP & CONFIG", 0 , 4, 2);

 Delay_ms(2000);
}
if (PORTC.F1==0) {
 Glcd_Fill(0x00);
 Glcd_Set_Font(Character8x7, 8, 7, 32);

 Glcd_Write_Text("NO OIL WARNING", 0 , 4, 2);
 Delay_ms(2000);
}
}
void main()
{
 ADCON0 = 0x00;
 ADCON1 = 0x00;


 TRISA = 0xFF;


 TRISB = 0x00;
 TRISC = 0b11100111;
 PORTC = 0b00000000;





 Glcd_Init();
 Glcd_Fill(0x00);
 Glcd_Image(kawasaki1_bmp);
 delay2S();
 while(1) {

 interrut ();
 imageNinja ();
 interrut ();
 temp_read ();
 interrut ();
 volt_read ();
 interrut ();
 fuel_read ();
#line 416 "C:/Users/Alfredo/Desktop/New Folder (2)/Glcd452/Glcd.c"
 }

 }








unsigned char const kawasaki1_bmp[1024] = {
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,224,224,
 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,
 224,224,224,224,224,224,224,224,224,224,224,224,224, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 96,224,
 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,
 224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,224,
 224,224,224,224, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,128,192,224,240,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,127, 63,
 31, 15, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255, 32, 32, 32,
 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 32, 48,112,112,112,120,
 248,248,248,248,252,252,254,254,254,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 223,223,159,143,143, 15, 7, 7, 7, 3, 1, 1, 1, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 1, 1, 3, 3, 7, 7, 7, 15, 31, 63,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,254,252,248,248,240,240,224,
 192,128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 63, 63,
 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 48,
 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
 63, 63, 62, 60, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,240,240,
 240,240, 0, 0,128,192,224,240,240,240,112, 48, 16, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0,240,240,240,240,240, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 112,112,112,112, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,255,255,
 255,255, 62,127,127,255,255,255,243,192,128, 0, 0, 0,140,206,
 206,239,231,231,119,127,254,254,252,240, 15,127,255,255,248,224,
 248,254,255,127,255,252,240,240,252,255,255,127, 7,136,140,206,
 206,239,103,103,119,255,254,252,248, 0, 60,126,127,127,115,115,
 247,239,238,204,128, 0,140,206,206,239,231,103,119,127,255,254,
 252, 0,255,255,255,255,255,248,252,252,254,222,142, 6, 2, 0,
 254,254,254,254, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 15, 15,
 15, 15, 0, 0, 0, 0, 3, 7, 15, 15, 15, 15, 12, 0, 7, 15,
 15, 15, 13, 12, 12, 14, 15, 15, 15, 15, 0, 0, 3, 15, 15, 15,
 15, 15, 0, 0, 1, 15, 15, 15, 15, 15, 1, 0, 7, 15, 15, 15,
 13, 12, 12, 14, 15, 15, 15, 15, 15, 0, 7, 15, 15, 14, 12, 12,
 12, 15, 15, 7, 3, 0, 7, 15, 15, 15, 12, 12, 14, 15, 15, 15,
 15, 0, 15, 15, 15, 15, 15, 1, 1, 3, 15, 15, 15, 12, 8, 0,
 15, 15, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
};





unsigned char const ninja21_bmp[1024] = {
 0, 0, 0, 0, 0, 0, 0,240,248,248,248,248,248,248,120,120,
 120,120,120,120,120,120,120,120, 24, 0, 0,240,248,248,248,248,
 248,248,120,120,248,248,248,248,248,248,248,248, 0, 0, 0,240,
 248,248,248,248,248,248, 0, 0, 0,224,248,248,248,248,248,248,
 0, 0, 0,240,248,248,248,248,248,248,120,120,120,120,120,120,
 120,120,120,120, 24, 0, 0,240,248,248,248,248,248,248,120,120,
 248,248,248,248,248,248,248,248, 0, 0, 0,240,248,248,248,248,
 248,248,120,120,248,248,248,248,248,248,248,248, 0, 0, 0, 0,
 0, 0, 0, 0, 0,224,255,255,255,255,255,255, 31, 1, 0,192,
 248,252,252,252,252,252,124, 0, 0,224,255,255,255,255,255,255,
 127, 63, 60, 60, 62, 63, 63, 63, 63, 63, 31, 3, 0,128,192,195,
 231,255,255,255,127, 62, 60,252,254,255,255,239,199,131, 3, 1,
 0,224,255,255,255,255,255,255,127, 63, 60,252,252,252,252,252,
 252,252,124, 0, 0,224,255,255,255,255,255,255, 31, 1, 0,192,
 252,255,255,255,255,255, 63, 3, 0,224,255,255,255,255,255,255,
 31, 1, 0,192,252,255,255,255,255,255, 63, 3, 0, 0, 0, 0,
 0, 0, 0, 0, 30, 31, 31, 31, 31, 31, 31, 31, 30, 30, 30, 31,
 31, 31, 31, 31, 31, 7, 0, 0, 30, 31, 31, 31, 31, 31, 31, 3,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 31, 31, 31,
 31, 31, 31, 3, 0, 0, 28, 31, 31, 31, 31, 31, 31, 7, 0, 0,
 30, 31, 31, 31, 31, 31, 31, 31, 30, 30, 30, 31, 31, 31, 31, 31,
 31, 7, 0, 0, 30, 31, 31, 31, 31, 31, 31, 31, 30, 30, 30, 31,
 159,159,159,159, 31, 7, 0, 0, 30, 31, 31, 31, 31, 31, 31, 31,
 30, 30, 30, 31, 31, 31, 31, 31, 31, 7, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0,128,128,192,224,240,240,248,248,248,
 112, 0, 0, 0, 0, 0, 0, 0, 0, 0,128,192,240,248,248,124,
 30, 31, 15,134,224,224,248,120,124,126, 62, 30, 28, 8, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0,224,112, 56, 60, 30, 31, 15,
 15, 15, 7, 7, 3, 0, 0, 0, 0, 0, 0, 0, 0,128,128,128,
 128,128,128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,128,192,224,
 224,240,248,252, 62, 30,207,243,255,255,255,255,255, 63, 7, 3,
 0,128,192,224,240,248,252,190,222,239,239,247,249,249,252,254,
 254,254,126,184,128,128,192, 96, 96,240,240,248,248,252,252,254,
 252,248,240,240,120,184,252,252,254,254,254,255,255, 63,191,159,
 238,224,240,248,248,252,254,126,126, 30,152,192,192,224,224,240,
 240,248,248,248,120,124,124, 62,158,158,222,255,255,255,255,191,
 31, 31, 15, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0,128,192,224,240,252,254,255,255,255, 63,
 15, 3,129,224,254,255,255,255,255,255,143,243,241,248,254,254,
 127, 63,223,239,243,249,248,252,255,255,255,127, 63, 31, 31, 15,
 134,231,243,241,249,252,254,254,127, 31, 15, 15, 7,103,243,249,
 253,255,255,255,255,255,127,127,183,217,233,252,254,255,255,255,
 127,127, 31, 15,247,251,254,255,255,255,255,255,247,119,115,115,
 57, 57, 28, 30,254,255,255,255,255,255,255,127,119,115,121,120,
 60, 28, 28, 28, 30, 30, 30, 15, 15, 15, 15, 6, 6, 0, 0, 0,
 0, 0, 0, 0, 0, 15, 31, 31, 31, 15, 15, 7, 3, 1, 0, 0,
 24, 62, 63, 63, 63, 63, 63, 31, 31, 31, 15, 15, 7, 7, 1, 0,
 0, 1, 3, 3, 3, 3, 3, 1, 1, 0, 0, 0, 0, 0, 0, 0,
 0, 1, 1, 3, 3, 3, 3, 0, 0, 0, 0,128,128,224,240,240,
 241,241,249,249,124,126,127,127,127, 31, 31, 7, 7, 1, 1, 0,
 0, 0, 0,240,240, 16, 17,243,227, 1,240,240, 0,224,240, 16,
 16, 48, 32, 0,240,240, 1, 17, 16,240,240, 16, 16, 0, 0,192,
 112,112,192, 0, 0,240,240, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 3, 1, 1, 1, 1, 1,
 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 0, 0, 0, 31, 31, 16, 16, 31, 15, 0, 31, 31, 0, 15, 31, 16,
 17, 31, 15, 0, 31, 31, 0, 0, 0, 31, 31, 0, 0, 0, 28, 31,
 2, 2, 31, 28, 0, 31, 31, 16, 16, 16, 0, 0, 0, 0, 0, 0
};
