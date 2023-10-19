#include "ece212.h"
int main() {
    int black = 340;//371
    int white = 280;// 248
    int sense_left; //declare left sensor variable
    int sense_right; // declare right sensor variable
    int speed; // declare speed
    int dir; // declare direction
 // add needed variables here
 // set initial speed and direction (straight)
 ece212_lafbot_setup();
 while(1){

    //read the sensors
   sense_left =  analogread(LEFT_SENSOR);
   sense_right =  analogread(RIGHT_sENSOR);

   // sample input sensors and determine if on track
   if( sense_left <=  white && sense_right <= white){
  writeLEDs(0b1001);
  RBACK = 0;
  RFOWARD = 0X7FFF;
  LBACK = 0;
  LFOWARD = 0X7FFF;

   }
   else if(sense_left <= white && sense_right >= black){
writeLEDs(0b1000);
  RBACK = 0;
  RFOWARD = 0X7FFF;
  LBACK = 0;
  LFOWARD = 0X4FFF;

   }
   else if(sense_left >= black && sense_right <= white){
    writeLEDs(0b0001);
    RBACK = 0;
  RFOWARD = 0X4FFF;
  LBACK = 0;
  LFOWARD = 0X7FFF;
   }
   delayms(200);
 
 // if not, alter wheel speeds to try to correct
 // delay for some amount of time before repeating

 }`
 return (EXIT_SUCCESS);
}