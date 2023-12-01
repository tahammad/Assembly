.data
# You can use the following for the pretty printing the 
# input and output as described in the homework document
A:		.asciiz "A["
B:		.asciiz "B["
C:		.asciiz "]="
spacechar:	.asciiz " "
bar:		.asciiz "|"
newline:	.asciiz "\n"


.align 2
pinA: .space	400 # We will not change this
pinB: .space	400 # We will not change this
num: .word 11  # We can change this 
              # n x 4 <= 400 This is the constraint

.text
main:
    li $t0, 1            # Our loop iterator
    lw $t3, num          # Load the number of elements in the arrays into $t3
    addi $t3, $t3, 1     # Increment 1 to account for our loop iterator starting from 1
    la $t4, pinA	#Load the address of the A array into $t4
    la $t5, pinB	#Load the adress of the B array into $t5

    loop:
    beq $t0, $t3, swap_loop    # End loop condition
    
    li $v0, 4
    la $a0, A
    syscall
    move $a0, $t0             # Set the iteration number as the argument to print
    li $v0, 1
    syscall                   # Insert in "A[_]="
    li $v0, 4
    la $a0, C
    syscall                   # Previous 9 lines used to print "A[array position]=" to the console
    li $v0, 5
    syscall                   # Get the user input for A[_]=
    move $t1, $v0             # Store the value in $t1
    sw $t1, 0($t4)		#Store $t1 at the memory address of our A index

    li $v0, 4
    la $a0, B
    syscall
    move $a0, $t0             # Set the integer to be printed
    li $v0, 1                 # Insert in "B[_]="
    syscall
    li $v0, 4
    la $a0, C
    syscall                   # Previous 9 lines used to print "B[array position]=" to the console
    li $v0, 5
    syscall                   # Get the user input for B[_]=
    move $t2, $v0             # Store the value in $t2
    sw $t2, 0($t5)		#Store $t2 in the memory adress of $t5
    

    addi $t0, $t0, 1          # Iterate through the loop
    addi $t4,$t4, 4		#Go to the next index of A by incrementing address by 4
    addi $t5, $t5, 4		#Go to the next index of A by incrementing address by 4
    j loop                    # Loop
    
    
    swap_loop:
    addi $t0, $zero, 1
    la $t4, pinA
    la $t5, pinB
    swap:
    beq $t0,$t3, end_loop
    lw $t6, 0($t4)
    lw $t7, 0($t5)
    sw $t7, 0($t4)
    sw $t6, 0($t5)
    addi $t4, $t4, 4
    addi $t5, $t5, 4
    addi $t0, $t0, 1
    j swap

    end_loop:
    addi $t0, $zero, 1
    la $t4, pinA
    la $t5, pinB
    iterate:
    beq $t0, $t3, terminate
    lw $t6, 0($t4)
    li $v0, 1
    move $a0, $t6
    syscall 
    li $v0, 4
    la $a0, spacechar
    syscall
    lw $t6, 0($t5)
    li $v0, 1
    move $a0, $t6
    syscall 
    li $v0, 4
    la $a0, bar
    syscall
    addi $t4, $t4, 4
    addi $t5, $t5, 4
    addi $t0, $t0,1
    j iterate
    
    
    terminate:
    li $v0, 10
    syscall
    
    
    
