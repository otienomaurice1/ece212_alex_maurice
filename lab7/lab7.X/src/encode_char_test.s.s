###########################################################################
#
#    ECE 212 Lab 7 - Fall 2023
#    encode_string test file
#
########################################################################### 

  .set noreorder
    .global main         # define main as a global label
    .text
main: 
    la   $a0, msg1        # put string address in argument register $a0
    addi $a1, $zero, 4   # put character shift amount in arg reg $a1
    jal  encode_string   # call the function
    add  $0, $0, $0      # branch delay slot nop
      
now_decode:
    la   $a0, msg2        # put string address in argument register $a0
    addi $a1, $zero, -4  # put character shift amount in arg reg $a1
    jal  encode_string   # call the function
    add  $0, $0, $0      # branch delay slot nop
done:  
    j done               # infinite loop
    add $0, $0, $0       # branch delay slot

###########################################################################
#
#    Add assembly code for encode_char function here
#
###########################################################################
        
encode_char:

    slti $t2,$a0,65   #check if c is less than A.assign 1 to $t2 if true
addi $t9,$0,90    #load decimal value of Z
slt  $t3,$t9,$a0  #check that c is greater than Z
or   $t4,$t2,$t3  # or 

beq $t4,0,condition # check if $t4 == 0. jump to else condition if true
add $0,$0,$0  
addi $v0,$a0,0    #return c
    
jr $ra            #return to caller
add $0,$0,$0     #delay

condition:        #else label
addi $t8,$0,26    #load decimal 26
addi $t5, $a0,-65 #offset = c- A
sub $t6,$t5,$a1   #offset-k
add $t7,$t6,$t8   #(offset -k)+26
div $t7,$t8       #(offset -(k+26))%26
mfhi $t0          #offset = (offset -(k+26))%26
addi $v0,$t0,65   #return offset+A
jr $ra
add $0,$0,$0     #delay


    
###########################################################################
#
#    Add assembly code for encode_string function here
#
###########################################################################  

encode_string:    #function label

loop:
lbu $t0, 0($a0)   #load s
beq $t0,$0,exit #while *s != '\0'
add $0,$0,$0   #branch delay 
addi $t2,$t0,0  #c = s
addi $sp, $sp,-8 #make room on stack for three registers
sw $a0,0($sp)   #store a0
sw $ra,4($sp)   #store return address
add $a0,$t0,0   #pass the character as an argument to encode char
jal encode_char
add $0,$0,$0
lw  $ra, 4($sp) #load back return address
lw  $a0, 0($sp)  #load back c
sb   $v0,0($a0)  #store result in memory
addi $sp,$sp,8 #set the stak pointer back to previous value

addi  $a0,$a0,1 #point to the next character
j  loop         #go back to beginning of loop
add $0,$0,$0   #delay
j  exit         #return to caller
add $0,$0,$0   #delay

exit:
jr   $ra        #return to caller
add $0,$0,$0   #delay


###########################################################################
#
#    data segment assembler directives to allocate storage for string msg
#
########################################################################### 
    
 .data
msg1:
 .asciz "S1"
msg2:
 .asciz "WELCOME BACK MY FRIENDS 2 THE show THAT NEVER ENDS?"



    