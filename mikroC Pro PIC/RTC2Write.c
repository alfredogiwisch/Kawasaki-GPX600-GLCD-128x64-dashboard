/*
 * Project name:
     RTC2_Write (Writing date/time data to DS1307 through I2C)
 * Copyright:
     (c) MikroElektronika, 2005-2009
 * Revision History:
     20090504:
       -  Author: Igor Stancic;
 * Description:
     This project is simple demonstration how to set date and time on DS1307
     RTC (real-time clock). The code use MSSP module at PORTC.
     The example sets the following:
       TIME: 17:00:00
       DATE: 04/05/2009
     Please refer to DS1307 datasheet for more information on format date
     settings.
 * Test configuration:
     MCU:             PIC16F887
     Dev.Board:       EasyPIC5
     Oscillator:      HS, 8.000MHz
     Ext. Modules:    IC RTC (DS1307)
     SW:              mikroC PRO v1.65
 * NOTES:
      - For proper I2C communication, pins on PORTC must be in the pull-up mode,
        RC3 - pin 6 DS1307  - SCL,
        RC4 - pin 5 DS1307 - SDA,
        and the LEDs on board switched OFF!
*/

void main() {
   I2C1_Init(100000);     // initialize full master mode
   I2C1_Start();          // issue start signal
   I2C1_Wr(0xD0);         // address DS1307
   I2C1_Wr(0);            // start from word at address (REG0)
   I2C1_Wr(0x80);         // write $80 to REG0. (pause counter + 0 sec)
   I2C1_Wr(0);            // write 0 to minutes word to (REG1)
   I2C1_Wr(0x17);         // write 17 to hours word (24-hours mode)(REG2)
   I2C1_Wr(0x02);         // write 2 - Monday (REG3)
   I2C1_Wr(0x04);         // write 4 to date word (REG4)
   I2C1_Wr(0x05);         // write 5 (May) to month word (REG5)
   I2C1_Wr(0x09);         // write 09 to year word (REG6)
   I2C1_Stop();           // issue stop signal

   I2C1_Start();          // issue start signal
   I2C1_Wr(0xD0);         // address DS1307
   I2C1_Wr(0);            // start from word at address 0
   I2C1_Wr(0);            // write 0 to REG0 (enable counting + 0 sec)
   I2C1_Stop();           // issue stop signal
}//~!
