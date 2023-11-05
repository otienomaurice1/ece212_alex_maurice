# Alex Villalba
.set noreorder     
.global main         # define main as a global label     
.text 

main:      
     addi  $a0, $0, 'A'       # put character in argument register $a0   
     addi  $a1, $0, 4       # put offset value address in argument register $a1    
     jal  encode_char      # call the function     
     add  $0, $0, $0      # branch delay slot nop 


encode_char:


     slti $t0, $a0, 'A'		# $t0 = ($a0 < 65) ? 1 : 0
     slti $t1, $a0, 'Z' + 1      #  z + 1 because we want to include z in the boundary
     addi $v0, $a0, 0 # save a0 in the return address $v0 
     bne $t0, $0, ret   # jump to ret if the inequality in $t0 is 1 (true)
     add $0, $0, $0  # branch delay slot ret: 

     beq $t1, $0, ret # jump to ret if the inequality in $t1 is 0 (false)  
     add $0, $0, $0  # branch delay slot ret: 

     addi $t3, $a0, -65 # c - 65 ('A') 
     sub $t4, $t3, $a1  # offset - k ( $a1 )
     addi $t5, $t4, 26 # offset - k ( $a1 ) + 26
     addi $t6, $0, 26 # save 26 in a temporal register
     div $t5, $t6 # modulus of $t5 % 26 
     mfhi $t7 # save the result of the modulus in $t7

     add $v1, $t7, 65 # return the value in the return variable $v1 and fix the offset('A')
     j ret # jump to ret 
     add $0, $0, $0  # branch delay slot ret: 
ret:       
     jr $ra               # jumpt to register adress    
     add $0, $0, $0       # branch delay slot 
