/* 
 * File:   la5_p1.c
 * Author: otienom
 *
 * Created on October 12, 2023, 2:12 PM
 */

#include "ece212.h"

/*
 * 
 */
int main(int argc, char** argv) {
    int k = 0b0001;
//    int lastbtn = 0;
    int dir = 0;
    ece212_setup();
    while(1){
        writeLEDs(k);
       
        
        if(BTN11==1 /*&& lastbtn == 0*/) {
            //change direction
            dir = !dir;
            
        }
        if (dir) {
            k = k >> 1;
            if(k == 0b0000)
                k = 0b1000;
            
        } else {
             k = k << 1;
             if(k == 0b10000)
                k = 0b0001;
        }
        delayms(200);
    }
    
    
    
        
    return (EXIT_SUCCESS);
}

