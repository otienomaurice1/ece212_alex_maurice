###########################################################################
#
#    ECE 212 Lab 7 - Fall 2023
#    encode_char test file
#
########################################################################### 
 
    .set noreorder
    .global main             # define main as a global label
    .text
main: 
    addi $a0, $0, 'A'        # put character to encode in $a0
    addi $a1, $zero, 4       # put character shift amount in arg reg $a1
    jal  encode_char         # call the function
    add  $0, $0, $0          # branch delay slot nop
encode_another:
    addi $a0, $0, 'Z'        # put character to encode in $a0
    addi $a1, $zero, 4       # put character shift amount in arg reg $a1
    jal  encode_char         # call the function
    add  $0, $0, $0          # branch delay slot nop
done:  
    j done                   # infinite loop
    add $0, $0, $0           # branch delay slot

###########################################################################
 #  .asciz "Maurice otieno"
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
mfhi $t5          #offset = (offset -(k+26))%26
addi $v0,$t5,65   #return offset+A
jr $ra
add $0,$0,$0     #delay

