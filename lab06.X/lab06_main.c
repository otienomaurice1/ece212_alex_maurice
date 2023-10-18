/* 
 * File:   lab06_main.c
 * Author: otienom
 *
 * Created on October 17, 2023, 4:28 PM
 */

#include "ece212.h"

int main(int argc, char** argv) {

    int black = 340;//371
    int white = 320;// 248
    int sense_left; //declare left sensor variable
    int sense_right; // declare right sensor variable
   int speed_high = 0XFFFF; // declare speed
   int speed_low = 0X3111; // declare direction
 // add needed variables here
 // set initial speed and direction (straight)
 ece212_lafbot_setup();
 while(1){

    //read the sensors
   sense_left =  analogRead(LEFT_SENSOR);
   sense_right =  analogRead(RIGHT_SENSOR);

   // sample input sensors and determine if on track
   if( sense_left <=  white && sense_right <= white){
  writeLEDs(0b1001);
  RBACK = 0;
  RFORWARD = speed_high;
  LBACK = 0;
  LFORWARD = speed_high;
  //delayms(150);

   }
   else   if(sense_left <= white && sense_right >= black){
writeLEDs(0b1000);
  RBACK = 0;
  RFORWARD = speed_low;
  LBACK = 0;
 LFORWARD = speed_high;
 //delayms(50);

   }
    else if(sense_left >= black && sense_right <= white){
    writeLEDs(0b0001);
    RBACK = 0;
  RFORWARD = speed_high;
  LBACK = 0;
  LFORWARD = speed_low;
 // delayms(50);
   }
   else if(sense_left >= black && sense_right >= black){
    writeLEDs(0b1111);
    RBACK = 0;
  RFORWARD = speed_high;
  LBACK = 0;
  LFORWARD = speed_high;
  //delayms(50);
   }
   
  delayms(120);
 // if not, alter wheel speeds to try to correct
 // delay for some amount of time before repeating
 }
 return (EXIT_SUCCESS);

}