/* 
 * File:   lab5_p2.c
 * Author: Villalba
 *
 * Created on October 13, 2023, 1:15 PM
 */

#include "ece212.h"
/*
 * 
 */
int main(int argc, char** argv) {
    ece212_lafbot_setup	();
    int k = 0b0001; 
    int dir = 0; 
    while(1){
/*      to set up the A/D inputs and PWM outputs used by the LafBot.
 *      After setup, it repeatedly performs the following steps;
        Move the LafBot straight forward at half speed (i.e. using a 50% duty cycle)
        for 0.5 second. o Wait one second. o Move the LafBot straight backward at half speed
        i.e. using a 50% duty cycle) for 0.5 second. o Wait one second. 
        RBACK = 0x1FFF;
        RFORWARD = 0x1FFF;
        LBACK  = 0x1FFF;
        LFORWARD = 0x1FFF;
 * 
*/

        int half_speed = 0X7FFF; // declare direction
        int half_second = 500; 
        int one_second = 1000; 
        // Go straight half speed for 0.5 seconds
        RBACK = 0;
        RFORWARD = half_speed;
        LBACK = 0;
        LFORWARD = half_speed;
        delayms(half_second);
        // Stops for 1 s
        RBACK = 0;
        RFORWARD = 0;
        LBACK = 0;
        LFORWARD = 0;
        delayms(one_second);

        // Moves backwards half speed for 0.5 s
        RBACK = half_speed;
        RFORWARD = 0;
        LBACK = half_speed;
        LFORWARD = 0;
        delayms(half_second);
        // Stops for 1 s
        RBACK = 0;
        RFORWARD = 0;
        LBACK = 0;
        LFORWARD = 0;
        delayms(one_second);
        

    }
    return (EXIT_SUCCESS);
}

