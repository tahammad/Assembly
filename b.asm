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
num: .word 5  # We can change this 
              # n x 4 <= 400 This is the constraint

.text
main:
    li $t0, 1            	# Our loop iterator
    lw $t3, num          	# Load the number of elements in the arrays into $t3
    addi $t3, $t3, 1     	# Increment 1 to account for our loop iterator starting from 1
    la $t4, pinA		#Load the address of the A array into $t4
    la $t5, pinB		#Load the adress of the B array into $t5

    loop:			#Loop
    beq $t0, $t3, swap_loop    	# End loop condition  
    li $v0, 4			#Indicates that we will be printing a string with syscall			
    la $a0, A			#Load the string A to print out
    syscall			#Prints A
    move $a0, $t0             	#Set the iteration number as the argument to print
    li $v0, 1			#Tells syscall we will be printing an integer
    syscall                  	# Insert in "A[_]="
    li $v0, 4			#Indicates that we will be printing a string with syscall
    la $a0, C			#Load the string c to print out
    syscall                   	# Prints C
    li $v0, 5			#Indicates that we will use syscall to get the user integer input
    syscall                   	# Get the user input for A[_]=
    move $t1, $v0             	# Store the value in $t1
    sw $t1, 0($t4)		#Store $t1 at the memory address of our A index

    li $v0, 4			#We will use the syscall to print a string
    la $a0, B			#Store B as the argument to print from the syscall
    syscall			#Print B
    move $a0, $t0             	# Set the integer to be printed
    li $v0, 1                 	# Syscall will print the integer stored in $a0
    syscall			#Prints the integer
    li $v0, 4			#We will use the syscall to print a string
    la $a0, C			#Store c as the argument to print from the syscall
    syscall                   	# Print C
    li $v0, 5			#Indicates that we will use syscall to get the user integer input
    syscall                   	# Get the user input for B[_]=
    move $t2, $v0             	# Store the value in $t2
    sw $t2, 0($t5)		#Store $t2 in the memory adress of $t5
    

    addi $t0, $t0, 1          	# Iterate through the loop
    addi $t4,$t4, 4		#Go to the next index of A by incrementing address by 4
    addi $t5, $t5, 4		#Go to the next index of A by incrementing address by 4
    j loop                    	# Loop
    
    
    swap_loop:			#Loop that swaps the values in the matrices
    addi $t0, $zero, 1		#Set $t0 to 1
    la $t4, pinA		#Load the address of pinA at $t4
    la $t5, pinB		#Load the address of pinB at $t5
    swap:			#Swap loop
    beq $t0,$t3, end_loop	#End loop condition
    lw $t6, 0($t4)		#Get the value in the A matrix index
    lw $t7, 0($t5)		#Get the value in the B matrix index
    sw $t7, 0($t4)		#Get the content that was in matrix B and put it in matrix A
    sw $t6, 0($t5)		#Get the content that was in matrix A and put it in matrix B
    addi $t4, $t4, 4		#Go to the next index in matrix A
    addi $t5, $t5, 4		#Go to the next index in matrix B
    addi $t0, $t0, 1		#Increment counter
    j swap			#Jump condition

    end_loop:			#End loop	
    addi $t0, $zero, 1		#Set $t0 to 1
    la $t4, pinA		#Load the address of matrix A
    la $t5, pinB		#Load the address of matrix B
    iterate:			#Iterate loop
    beq $t0, $t3, terminate	#Exit loop condiiton
    lw $t6, 0($t4)		#Get the value at the index of matrix A
    li $v0, 1			#Syscall will print an integer
    move $a0, $t6		#Puts the value at the index of matrix A as the argument for syscall to print
    syscall 			#Prints the matrix A value
    li $v0, 4			#Indicates that syscall will print a string
    la $a0, spacechar		#The string to be printed will be spacechar
    syscall			#Print spacechar
    lw $t6, 0($t5)		#Get the value at the index of matrix B
    li $v0, 1			#Syscall will print an integer
    move $a0, $t6		#Puts the value at the index of matrix B as the argument for syscall to print
    syscall 			#Prints the matrix B value
    li $v0, 4			#Indicates that syscall will print a string
    la $a0, bar			#The string to be printed will be bar
    syscall			#Prints bar
    addi $t4, $t4, 4		#Increment to the next address for matrix A
    addi $t5, $t5, 4		#Increment to the next address for matrix B
    addi $t0, $t0,1		#Increments our counter
    j iterate			#Jump
    
    
    terminate:			#Terminate call
    li $v0, 10			#Syscall will exit the program
    syscall			#Syscall exits the program
    
    
    
