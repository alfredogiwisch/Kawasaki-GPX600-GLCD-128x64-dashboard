# Kawasaki-GPX600-GLCD-128x64-dashboard
Kawasaki GPX600 dashboard for measuring temperatures and voltages in real-time

I finish in april 2010 the GLCD digital dashboard development installing it on my motorcycle for testing purpouses. The first impression was happiness because it looks great and works very well !!!. The measuring of parameters in a digital way is a great progress that technology offers in this world of microcontrollers and technology devices.

The testing and debugging of the program plus the addition of new functions is my next task. At the moment the GLCD dashboard is ready to measure temperature in 4 locations: engine, radiator, oil pan, air filter box using the 10 bits ADC converter. The additional information in the updates screens are the battery charge voltage, the fuel tank gasoline level, and the low oil pressure warning using the factory oil pressure sensor.

I have measure the accuracy on temperatures readings and voltage charge sensing and the device is very accurate. For example only +- 0.05 to +- 0.10  volts accuracy error on 12V voltage measure and +- 2 celsius grads on temperatures readings. Same excellent results on speedometer speed, tachometer RPMs and gear indication.

For the gear indicator the same speed sensor on speedometer module is in use. The count of pulses on front wheel for speed calculation is quantified at 6 pulses (60 grads) per wheel rotation using an infrared sensor and 6 white strips. Due the small speed ratio on 5th and 6th gear the device is a bit inaccurate leading on some circumstances to a mismatch on 6th gear indication (sometimes and very rare changes between 6 and 5 when 6th speed is selected). One easy solution for this small issue is to increase the counter window for a better accuracy, but by the other hand this step will lead to a high delay or latency on the refresh rate. Another solution is to install an improved speed sensor on the front wheel but here the motorcycle original design should be strongly modified because a special codified disk should to be attached on the front wheel. Taking all this stuff into account we can say that the 6th indication issue is not so critical and can be accepted. To conclude I'm very satisfied with the final results on the GPX 600 digital dashboard project !!!

Please check my previous post that shows the other modules and sensors in action -> http://alfredoblogspage.blogspot.com.ar/2010/03/new-panel-board-for-my-motorcycle.html

To complete the project the next idea is to add new functions such a security PIN code function for engine start up and menu functions to set the radiator fan on/off operation trigger levels. At the same time a buzzer device would be included for warnings indication.

The motorcycle with the digital dashboard looks very futuristic !!. Some friends nickname my motorcycle as "The GPX600 BTTF (Back to the Future) Edition" because the new dashboard resembles the DeLorean time machine in the same way as a functioning vehicle with many improvements.

So, the best way to show my happiness is with pictures and a video.

https://youtu.be/Nr60ZzgX88c

https://youtu.be/IfyYGeAWg6M

The final program release in C language and schematics diagrams are below. The 18F452 is a RISC microprocessor with 70 instructions enough for development of middle complex solutions. On the code design I have simulated the entire project on ISIS Proteus 7 successfully, but on hardware testing I found some issues on the mathematical calculations maybe due logic core erratas.

Below  the final release in C language with all issues fixed for everyone, the same code that runs today on my GPX600. Enjoy!

-----------------------------------------------------------------------------------------------------------------------------
/*
 * Project name:
   Kawasaki GPX600 128x64 GLCD Dashboard

 * Revision History:
     - second release;
 * Description:
     - Init and Clear (pattern fill)
     - Image display
     - Basic geometry - lines, circles, boxes and rectangles
     - Text display and handling
 * Test configuration:
     MCU:             PIC18F452
     Oscillator:      HS, 08.0000 MHz
     Ext. Modules: GLCD 128x64, KS108/107 controller
*/

//Declarations------------------------------------------------------------------

const code char kawasaki_bmp[1024];
const code char gpx600_bmp[1024];
const code char dream_bmp[1024];
 unsigned short int0 = 0;

  unsigned temper_rad;
  unsigned temper_eng;
  unsigned temper_oil;
  unsigned temper_int;
  unsigned batt_level;
  unsigned max_batt;
  unsigned min_batt = 1800;
  unsigned fuel_level;
  unsigned meassure_rad;
  unsigned meassure_eng;
  unsigned meassure_oil;
  unsigned meassure_int;
  unsigned meassure_bat;
  unsigned meassure_fuel;
  unsigned meassure;
  char txt[6];


  int i;  int ii;
//#define KEYPAD_PORT      PORTD     // Select keypad port
//#define KEYPAD_MENU      F0        // Menu/Exit
//#define KEYPAD_SELECT    F1        // Select
//#define KEYPAD_INC       F2        // Inc number
//#define KEYPAD_DEC       F3        // Dec number
//#include "built_in.h"

//------------------------------------------------------------end-declarations

// Glcd module connections
char GLCD_DataPort at PORTD;

sbit GLCD_CS1 at RB0_bit;
sbit GLCD_CS2 at RB1_bit;
sbit GLCD_RS  at RB2_bit;
sbit GLCD_RW  at RB3_bit;
sbit GLCD_EN  at RB4_bit;
sbit GLCD_RST at RB5_bit;

sbit GLCD_CS1_Direction at TRISB6_bit;
sbit GLCD_CS2_Direction at TRISB7_bit;
sbit GLCD_RS_Direction  at TRISB2_bit;
sbit GLCD_RW_Direction  at TRISB3_bit;
sbit GLCD_EN_Direction  at TRISB4_bit;
sbit GLCD_RST_Direction at TRISB5_bit;
// End Glcd module connections


void delay2S(){                             // 2 seconds delay function
  Delay_ms(3000);
}

void imageNinja () {
  Glcd_Image(gpx600_bmp);
        delay2S();
}
 void imageDream () {
  Glcd_Image(dream_bmp);
        delay2S();
}
void temp_read () {
     ii = 0;
     Glcd_Fill(0x00);
     do {
  Glcd_Set_Font(font5x7, 5, 7, 32);
    Glcd_Write_Text ("TEMPERATURE  READINGS", 0 , 0, 2); //title
    Glcd_Write_Text ("=====================", 0 , 1, 2); // separation line

    //radiator sensor adc reading & displaying
    meassure_rad = 0;
    for (i = 0; i < 10; i++) {
    temper_rad = adc_read(0);
    meassure_rad = meassure_rad + temper_rad * (0.48875);
    }
    meassure_rad = meassure_rad / 10;
    WordToStr(meassure_rad, txt);
    Glcd_Write_Text ("Radiator sensor:", 0, 2, 2);
    Glcd_Write_Text   (txt, 95, 2, 2);


    //engine sensor adc reading & displaying
    meassure_eng = 0;
    for (i = 0; i < 10; i++) {
    temper_eng = adc_read(1);
    meassure_eng = meassure_eng + temper_eng * (0.48875);
    }

    meassure_eng = meassure_eng / 10;
    WordToStr(meassure_eng, txt);
    Glcd_Write_Text ("Engine sensor:", 0, 3, 2);
    Glcd_Write_Text   (txt, 95, 3, 2);

    meassure_oil = 0;
    for (i = 0; i < 10; i++) {
    temper_oil = adc_read(2);
    meassure_oil = meassure_oil + temper_oil * (0.48875);
    }

    meassure_oil = meassure_oil / 10;
    WordToStr(meassure_oil, txt);
    Glcd_Write_Text ("Oil pan sensor:", 0, 4, 2);
    Glcd_Write_Text   (txt, 95, 4, 2);
    //intake sensor adc reading & displaying
    meassure_int = 0;
    for (i = 0; i < 10; i++) {
    temper_int = adc_read(3);
    meassure_int = meassure_int + temper_int * (0.48875);
    }

    meassure_int = meassure_int / 10;
    WordToStr(meassure_int, txt);
    Glcd_Write_Text ("Intake sensor:", 0, 5, 2);
    Glcd_Write_Text   (txt, 95, 5, 2);
    Glcd_Write_Text ("=====================", 0 , 6, 2); // separation line
    Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font
    if  (meassure_eng <= 60 && meassure_eng >= 5)
    Glcd_Write_Text ("**WARMING UP**", 0 , 7, 2); //separation line
    else if  (meassure_eng <= 97 && meassure_eng >= 61)
    Glcd_Write_Text ("**COOLING OK**", 0 , 7, 2); //separation line
    else if  (meassure_eng <= 110 && meassure_eng >= 98)
    Glcd_Write_Text ("**FAN ACTIVE**", 0 , 7, 2); //separation line
    else if  (meassure_eng >= 111)
    Glcd_Write_Text ("**OVERHEATED**", 0 , 7, 2); //separation line
    Delay_ms(1000);

ii++;
}
while (ii<8 br="">}

void volt_read () {

      ii = 0;
      Glcd_Fill(0x00);
     do {
     Glcd_Set_Font(font5x7, 5, 7, 32);
     Glcd_Write_Text ("VOLTAGES & FUEL LEVEL", 0 , 0, 2); //title
     Glcd_Write_Text ("=====================", 0 , 1, 2); // separation line

//radiator sensor adc reading & displaying

    meassure = 0;
    for (i = 0; i < 10; i++) {
    batt_level = adc_read(5);
    meassure = meassure + batt_level * (2);
    }

    meassure_bat = meassure / 10;
    WordToStr(meassure_bat, txt);
    Glcd_Write_Text ("Current voltage:", 0, 2, 2);
    Glcd_Write_Text   (txt, 95, 2, 2);
    if (max_batt < batt_level)
    max_batt = batt_level ;
    else
    //display maximal battery voltage
    meassure = max_batt * (2);
    WordToStr(meassure, txt);
    Glcd_Write_Text ("Maximal voltage:", 0, 3, 2);
    Glcd_Write_Text   (txt, 95, 3, 2);
    if (min_batt > batt_level)
    min_batt = batt_level;
    else
    meassure = min_batt * (2);
    WordToStr(meassure, txt);
    Glcd_Write_Text ("Minimal voltage:", 0, 4, 2);
    Glcd_Write_Text   (txt, 95, 4, 2);
    meassure = 0;
    for (i = 0; i < 10; i++) {
   fuel_level = adc_read(4);
    meassure = meassure + fuel_level ;
    }

    meassure_fuel = meassure / 10;
    WordToStr(meassure_fuel, txt);
    Glcd_Write_Text ("Fuel tank level:", 0, 5, 2);
    Glcd_Write_Text   (txt, 95, 5, 2);
    Glcd_Write_Text ("=====================", 0 , 6, 2); // separation line
    Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font

if  (meassure_bat <= 1000 && meassure_bat >= 1100)
    Glcd_Write_Text("*LOW VOLTAGES*", 0, 7, 2);
else if (meassure_bat >= 1100 && meassure_bat <= 1450)
    Glcd_Write_Text("*VOLTAGES  OK*", 0, 7, 2);
    else if (meassure_bat > 1451)
    Glcd_Write_Text("*OVERCHARGING*", 0, 7, 2);
    else
    Glcd_Write_Text("*BATTERY FAIL*", 0, 7, 2);
    Delay_ms(1000);



  ii++;
}
while (ii<8 br="">}

void interrut() {
if (PORTC.F2==0) {
    Glcd_Fill(0x00);                          // Clear GLCD
    Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font
    Glcd_Write_Text(" GPX600 MENU  ", 0 , 3, 2); //separation line
    Glcd_Write_Text("SETUP & CONFIG", 0 , 4, 2); //separation line

    Delay_ms(2000);
}
if (PORTC.F1==0)  {
    Glcd_Fill(0x00);                          // Clear GLCD
    Glcd_Set_Font(Character8x7, 8, 7, 32);     // Change font

    Glcd_Write_Text("NO OIL WARNING", 0 , 4, 2); //separation line
    Delay_ms(2000); Delay_ms(1000);
}
}
void main()
{
  ADCON0 = 0x00;
  ADCON1 = 0x00;

  // Pins AN2 and AN3 are configured as analog
  TRISA = 0xFF;
  // All port A pins are configured as inputs
  // Rest of pins is configured as digital
  TRISB = 0x00;
  TRISC = 0b11100111; // Set port b pins 6 & 7 as imputs
  PORTC = 0b00000000; // clear portb
  //RCON.IPEN = 1; //enable priority levels on interrupts
  //INTCON.GIEH = 1; //enable all high-priority interrupts
  //INTCON.GIEL = 1; //enable all low-priority interrupts
  //INTCON.INT0IE = 1; //enable INT0 external interrupt
  //INTCON3.INT1IE = 1; //enable INT1 external interrupt
  Glcd_Init();                              // Initialize GLCD
  Glcd_Fill(0x00);                          // Clear GLCD
  Glcd_Image(kawasaki_bmp);                // Draw images
  delay2S();


  interrut ();
  imageDream ();
  imageNinja ();
  interrut ();
  while(1) {
  interrut ();
  temp_read ();
  interrut ();
  imageNinja ();
  interrut ();
  volt_read ();
  imageDream ();

  //fuel_level = adc_read(3);
  //batt_level = adc_read(4);

  }

  }

// ------------------------------------------------------
// GLCD Picture name: kawasaki.BMP
// GLCD Model: KS0108 128x64
// ------------------------------------------------------

unsigned char const kawasaki_BMP[1024] = {
 255,255,255,255,  3,  3,  3,  3,  3,  3,  3,  3,  3,227,227,227,
 227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,
 227,227,227,227,227,227,227,227,227,227,227,227,  3,  3,  3,  3,
   3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,  3,
   3,  3,  3,  3,  3,  3,  3,  3,  3, 35, 35, 35, 99, 99,227,227,
 227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,
 227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,227,
 227,227,227, 99,  3,  3,  3,  3,  3,  3,  3,  3,255,255,255,255,
 255,255,255,255,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,  0,  0,  0,  0,
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,128,128,192,224,240,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,127, 63, 31,
  15,  3,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,255,
 255,255,255,255,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255, 32, 32, 32, 32,
  32, 32, 32, 32, 32, 32, 32, 32, 32, 32,112,112,112,112,248,248,
 248,248,248,252,252,254,254,254,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 223,223,143,143,143,  7,  7,  7,  3,  1,  1,  0,  0,  0,  0,  0,
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,255,
 255,255,255,255,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,  0,  0,  0,  0,
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
   0,  0,  0,  1,  1,  3,  3,  3,  7,  7, 15, 31, 31, 63,127,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,254,252,252,248,248,240,224,192,
 128,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,255,
 255,255,255,255,  0,  0,  0,  0,  0,  0,  0,  0,  0, 63, 63, 63,
  63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
  63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,  0,  0,  0,  0,
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,
   0,  0,  0,  0,  0,  0,  0,  0,  0, 32, 32, 32, 48, 48, 56, 63,
  63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
  63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63, 63,
  63, 62, 60, 48,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,255,
 255,255,255,255,  0,  0,  0,  0,  0,  0,  0,  0,  0,248,248,248,
 248,  0,128,192,224,240,248,248,120, 56, 24,  8,  0,  0,  0,  0,
 128,128,128,128,128,  0,  0,  0,  0,128,128,128,128,  0,  0,  0,
   0,128,128,128,  0,  0,  0,  0,128,128,128,128,  0,  0,  0,  0,
 128,128,128,128,128,  0,  0,  0,  0,  0,  0,128,128,128,128,128,
 128,  0,  0,  0,  0,  0,  0,  0,128,128,128,128,128,128,  0,  0,
   0,248,248,248,248,248,  0,  0,  0,  0,  0,  0,  0,  0,  0, 56,
  56, 56, 56,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,255,
 255,255,255,255,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,
 255, 31, 63, 63,127,255,255,249,224,192,128,  0,  0,198,231,231,
 247,243,115, 59, 63,255,255,254,248,  7, 63,255,255,252,240,252,
 255,127, 63,255,254,248,248,254,255,255, 63,131,196,198,231,231,
 119, 51, 51,187,255,255,254,252,  0,158,191,191, 63, 57, 57,123,
 247,247,230,192,  0,198,231,231,247,115, 51, 59,191,255,255,254,
   0,255,255,255,255,255,252,254,254,255,239,199,  3,  1,  0,255,
 255,255,255,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255,255,
 255,255,255,255,192,192,192,192,192,192,192,192,192,199,199,199,
 199,192,192,192,192,193,195,199,199,199,199,198,192,195,199,199,
 199,198,198,198,199,199,199,199,199,192,192,193,199,199,199,199,
 199,192,192,192,199,199,199,199,199,192,192,195,199,199,199,198,
 198,198,199,199,199,199,199,199,192,195,199,199,199,198,198,198,
 199,199,195,193,192,195,199,199,199,198,198,199,199,199,199,199,
 192,199,199,199,199,199,192,192,193,199,199,199,198,196,192,199,
 199,199,199,192,192,192,192,192,192,192,192,192,255,255,255,255
};


// ------------------------------------------------------
// GLCD Picture name: gpx600.BMP
// GLCD Model: KS0108 128x64
// ------------------------------------------------------

unsigned char const gpx600_BMP[1024] = {
 255,255,255,255,255,255,127,  7,  3,  3,  3,  3,  3,  3,195,195,
 195,195,195,195,195,195,195,195,243,255,127,  7,  3,  3,  3,  3,
   3,  3,195,195,131,  3,  3,  3,  3,  3,  3,  3,255,255,255,  7,
   3,  3,  3,  3,  3,131,255,255,255, 15,  3,  3,  3,  3,  3,  3,
 255,255,127,  7,  3,  3,  3,  3,  3,  3,195,195,195,195,195,195,
 195,195,195,195,243,255,127,  7,  3,  3,  3,  3,  3,  3,195,195,
 131,  3,  3,  3,  3,  3,  3,  3,255,255,127,  7,  3,  3,  3,  3,
   3,  3,195,195,131,  3,  3,  3,  3,  3,  3,  3,255,255,255,255,
 255,255,255,255,255, 15,  0,  0,  0,  0,  0,  0,240,255,255, 31,
   3,  1,  1,  1,  1,  1,193,255,255, 15,  0,  0,  0,  0,  0,  0,
 192,224,225,225,224,224,224,224,224,224,240,254,255, 63, 31, 30,
  12,  0,  0,  0,192,224,225,  1,  0,  0,  0,  8, 28, 62,254,255,
 255, 15,  0,  0,  0,  0,  0,  0,192,224,225,  1,  1,  1,  1,  1,
   1,  1,193,255,255, 15,  0,  0,  0,  0,  0,  0,240,255,255, 31,
   1,  0,  0,  0,  0,  0,224,254,255, 15,  0,  0,  0,  0,  0,  0,
 240,255,255, 31,  1,  0,  0,  0,  0,  0,224,254,255,255,255,255,
 255,255,255,255,240,240,240,240,240,240,240,240,240,240,240,240,
 240,240,240,240,240,252,255,255,240,240,240,240,240,240,240,254,
 255,255,255,255,255,255,255,255,255,255,255,255,240,240,240,240,
 112, 48, 48,126,255,255,241,240,240,112,112,112,240,252,255,255,
 240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,240,
 240,252,255,255,240,240,240,240,240,240,240,240,240,112, 48, 48,
  16, 16, 16, 16, 48,252,255,255,240,240,240,240,240,240,240,240,
 240,240,240,240,240,240,240,240,240,252,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,127,127, 63, 31, 31, 15,  7,  3,  3,  1,  1,  1,
 227,255,255,255,255,255,255,127,127, 63, 31, 15,131,129,193, 96,
 120,120,124,222,199,199,193,225,224,224,240,248,248,253,255,127,
 255,255,255,255,255,255,255,255,127,127,127, 63, 63, 63, 63, 63,
 127,255,255,255,255,255,127,127,127, 71,227,241,240,248,248,252,
 252,252,254,254,255,255,255,127,127,127,127, 63, 63, 31, 31, 31,
  31, 31, 31, 63,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,127, 63, 31, 15,  7,
   7,  3,129,192,112, 56, 12,  3,  0,  0,  0,  0,128,240,126,127,
  63, 31, 15,  7,  3,129,192,208,  8,  4,  4,  2,  1,  1,  0,  0,
  64,  0, 32,145,159,223, 79,103, 39,  3,  3,  1,  1,  0,  0,128,
 128,  1,  3,  3, 33, 17,  0,  0,  0,128,128,192, 64, 48, 16, 24,
   4,  7,  3,  1,  1,  0, 64, 32, 32, 56, 25, 15, 15,  7,  7,  3,
 131,129,193, 65, 97, 32, 32, 48, 24, 24,  8,  0,  0,  0,128,208,
 248,248,252,255,127,127,127, 63, 63, 63, 63,127,127,255,255,255,
 255,255,255,255,255, 63, 31, 15,  7,  3,  0,  0,  0,128,192,240,
 252,127, 31,  7,  0,  0,  0,  0,  0,  0, 28,  3,  3,  1,128,192,
 224,176,  8,  4,  3,  1,  1,128,128,192,192,224,240,248,248,252,
 222,134,131,  3,  1,  0,  0,192,224,248,252,252,254,230,195,193,
 128,128,128,128,192, 64, 32, 32, 18,  9,  5,  0,  0,128,128,192,
 224,224,248,252,194,193,128,  0,  0,128,192,192,194,226,227,227,
 241,241,248,248,192,192,128,128,192,192,192,224,226,227,225,225,
 240,248,248,248,248,248,248,252,252,252,252,254,254,255,255,255,
 255,255,255,255,255,188, 56, 56,184, 60,124,254,255,191,191, 63,
  57,176,176,240,112, 48,176,184,184, 56,252,188,190, 62, 63,191,
 191,255, 63,191, 63, 63,191, 63,255,191,191, 63, 63, 63,255,191,
  63, 63,191,255,255,255,255,255,127,127, 63,159,159,135,131,131,
 195,195,193,193,224,224,224,224,224,248,248,190, 62, 63,191,191,
 191, 63,191, 63, 63,191, 63,127,255,255,191,191, 63, 63,191,191,
 255, 63,191, 63, 63,191, 63,255,191,191, 63, 63,191,191,255,127,
  63,191,191, 63,127,191, 63, 63,255,191, 63, 63,191,255,255,255,
 255,255,255,255,255,223,192,192,223,207,224,240,255,223,223,192,
 192,223,223,255,224,192,223,219,195,227,251,223,223,192,192,223,
 223,255,254,223,192,192,223,254,255,223,193,192,247,192,193,223,
 192,192,223,223,223,199,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,223,192,192,221,216,
 223,198,223,192,192,223,207,224,240,255,223,223,192,192,223,223,
 255,254,223,192,192,223,254,255,223,223,192,192,223,223,255,224,
 192,223,223,192,224,223,192,192,220,243,192,192,255,255,255,255
};
// ------------------------------------------------------
// GLCD Picture name: dream.BMP
// GLCD Model: KS0108 128x64
// ------------------------------------------------------

unsigned char const dream_BMP[1024] = {
 255,255,255,255,255,255,255,255, 31, 31, 31, 31, 31, 31, 31, 31,
  31, 31,255,255,255,255,255,255,255,255,255,255,223,159, 31, 31,
  31, 31, 31, 31, 31, 31, 31, 31, 31,255,255,255,255, 31, 31, 31,
 255,127, 63, 31, 31,159,223,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255, 31, 31, 31,255,255,
 255,255,255,255, 31, 31, 31,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,  0,  0,  0,  0,  0,  0,  0,  0,
   0,  0,247,247,247,247,247,247,247,227,227,227,193,128,  0,  0,
   0,  0,  0,  8,  8, 12, 28, 62,127,255,255,255,255,  0,  0,  0,
 193,128,  0,  4, 30,127,255,255, 55, 17, 17,153,137,  1,  1,  3,
 255,253,193,  1,  3, 63,  1,193,  1,  7, 15,  1,  1,225,255, 55,
  17, 17,153,137,  1,  1,  3,255,255,195,129,129,137,  1, 17, 51,
 255, 63, 17, 17,145,137,  1,  1,  3,255,255,  0,  0,  0,135,  1,
   1, 49,253,255,  1,  1,  1,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,252,252,252,252,252,252,252,252,
 252,252,255,255,255,255,255,127, 63,159,223,127,125, 60, 60,188,
 188,188, 60, 60,252,252,252,252,252,255,255,255,255,248,248,248,
 255,255,254,248,248,248,249,255,252,248,248,249,253,248,120, 56,
 191,255,255,254,248,248,248,255,254,248,248,248,254,255,255,252,
 248,120,121,124,120,120,120,251,254,252,248,248,249,248,252,254,
 255,252,248,248,249,249,248,120,120,123,127,120,120,120, 63, 62,
  56,184,185,191,184,184,184,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,127,
  31,159,199,227,237,241,242,125,125,126, 62,159,159,223,239,111,
  55,179,156, 30, 15, 79, 39,  7, 19, 19,163,159,223,207,239,  7,
  35,163,145,217,221,236,236,228,147,195,209,233,237,246,243,243,
 253,237,240,240,248,236,225,244,242,195,211, 89, 93, 45,174, 14,
 150,211,235,225,233,244,246,243,243,251,251,125, 61, 29, 29, 12,
  78,110,126,190,254,222,207, 71, 67,  3, 17, 17,157,223,255,239,
 231,227,225,240,248,252,254,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,159,199,227,249,252,254,
 255,255,255,253,253,252,248,250,194,227,227,225,229,237,206,223,
 159,189,188, 60,126,126,255,254,254,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,127, 63, 95, 47,183,219,233,229,246,250,249,253,254,127,
 191,159,207, 71,  7,  3, 19, 27, 13, 79,110,126,250,217,200,192,
  64,  0, 34, 19,155,223,255,238,230,226,224,241,249,253,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,254,254,252,253,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,252,254,254,255,255,255,255,255,159,143,143,143,199,231,243,
 251,255,254,246,243,241,240,248,248,252,254,255,255,255,253,252,
 252,252,254,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,
 255,255,255,255,255,255,251,  3,  3,251,251,243,  7, 15,255,255,
 251,251,  3,  3,251,251,255,255, 15,  7,243,187,187, 55, 35,191,
 255,255,251,251,  3,  3,251,251,255,255,227,251,251,  3,  3,251,
 251,227,255,255,123, 11,  3,115,  3, 15,127,255,251,251,  3,  3,
 251,251,255,127,255,255,255,255,255,255,255,255,255,251,  3,  3,
 251,251,243,  7, 15,255,251,  3,  3,187,187, 67,199,255,255,251,
   3,  3,219,139,251, 99,255,255,255,123, 11,  3,115,  3, 15,127,
 251,  3,  3,231,159,159,231,  3,  3,251,255,255,255,255,255,255,
 255,255,255,255,255,255,253,252,252,253,253,252,254,255,255,255,
 253,253,252,252,253,253,255,255,255,254,252,253,253,252,254,255,
 255,255,253,253,252,252,253,253,255,255,255,253,253,252,252,253,
 253,255,255,253,252,252,253,255,253,252,252,253,253,253,252,252,
 253,253,253,252,255,255,255,255,255,255,255,255,255,253,252,252,
 253,253,252,254,255,255,253,252,252,253,255,254,252,253,253,253,
 252,252,253,253,253,252,255,255,253,252,252,253,255,253,252,252,
 253,252,252,253,255,255,253,252,252,253,255,255,255,255,255,255
};

