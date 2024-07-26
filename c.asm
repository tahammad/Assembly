.data
  M:      .space 400  		# int M[][] The matrix
  V:      .space 400  		# int V[]   The vector
  C:      .space 400  		# int C[] : The output vector
  m:      .word 10   		  # m is an int whose value is at most 10
                     		  # max value for rows and columns
  col_m: .word 5          # columns for matrix M: This should not be more than 10
  row_m: .word 9          # rows for matrix M:    This should not be more than 10
                          # (col_m * row_m) * 4 <= M
  col_v: .word 1          # colums for vector V. For a vector, the column is always one
  row_v: .word 5          # rows for vector V. This should not be more than 10
                          # (col_v * row_v) * 4 <= V
  error_prompt1:	.asciiz " NOT WORKABLE BECAUSE OF THE DIMENSIONS"
  error_prompt2: 	.asciiz "NOT WORKABLE BECAUSE OF THE MEMORY"
  input_prompt1: 	.asciiz "Enter element "
  input_prompt2: 	.asciiz " =" 
  vector_prompt1: 	.asciiz "Enter all the elements in the vector: \n"
  matrix_prompt1: 	.asciiz "Enter all the elements in the matrix: \n"
  newline:		.asciiz "\n"
   



.text
main:
lw $t0, col_m			#Sets $t0 to the column length of the matrix
lw $t1, row_v			#Sets $t1 to the row length of the vector
lw $t3, row_m			#Sets $t3 to the row length of the matrix
lw $t4, col_v			#Sets $4 to the column length of the vector
bne $t0, $t1, dimension_error	#If the column length of the matrix is not equal to the row length of the vector, then throw an error
mul $t2, $t0, $t3		#Set $t2 to the number of elements of the matrix by multiplying its columns and rows
move $a1, $t3			#Set the number of matrix rows to the argument $a1 to be used later
sll $t2, $t2, 2			#Set $t2 to the number of bytes that all the matrix would take up
bgt $t2, 400, space_error	#If the byte size used by the matrix is greater than the limit of 400 bytes, throw an error
mul $t2, $t1, $t4		#Set $t2 to the number of elements in the vector
sll $t2, $t2,2			#Multiply the number of elements by 4 in order to set $t2 to the byte size
bgt $t2, 400, space_error	#If the byte size used by the vector is greater than the limit of 400 bytes, throw an error
mul $t2, $t0, $t1		#Set $t2 to the number of elements in the result vector
sll $t2, $t2,2			#Multiply the number of elements by 4 in order to set $t2 to the byte size
bgt $t2, 400, space_error	#If the byte size used by the result vector is greater than the limit of 400 bytes, throw an error
move $a0, $t0			#Set $a0 to the number of columns in the matrix
la $a2, M			#Set $a2 argument to the address of the matrix
la $a3, V			#Set the $a3 argument to the address of the matrix
jal read_matrix			#Read matrix inputs and add to matrix		
jal read_vector			#Read vector inputs and add to vector
jal MVM				#Do matrix vector multiplication and add to the result vector
jal print_vector		#Print the result vector
j exit				#Exit



MVM:	
addi $sp, $sp, -8     		 # Adjust the stack pointer to make space for one word
sw $s0, 0($sp)	      		 # Store the value of $s0 onto the stack as we are changing the value in our loop
li $t0, 0			#Outer loop counter, we want the outer loop to end after n times
move $t3, $a2			#Keeps track of the matrix address
la $t5, C			#Keeps track of the result vector address
outer_loop:
beq $t0, $a1,MVM_exit		#If we have finished calculations through all of the matrix rows then exit
li $t1, 0			#Inner loop counter we want the inner loop to restart after each outer loop call and goes until n each time
li $t2, 0			#Our register to keep track of the intermediate value
li $s0, 0			#Our sum for each iteration
move $t4, $a3			#Our register that gives us the vector address, we need to restart after each row calculation
inner_loop:
beq $t1, $a0, inner_loop_exit	#Loops until we do calculations between the matrix and rows and set the sum into the result vector
lw $t6, 0($t3)			#Load the address of the matrix in $t6
lw $t7, 0($t4)			#Load the address of the vector in $t7
mul $t2, $t6, $t7		#Set $t2 to the product which is an intermediate step 
add $s0, $s0, $t2		#Add that intermediate value to $s0 which is our eventual sum value for that row
addi $t3, $t3, 4		#Go to the next value in the matrix
addi $t4, $t4, 4		#Go to the next value in the vector
addi $t1, $t1, 1		#Increment the inner loop 
j inner_loop			#Loops until we do all calculations
inner_loop_exit:		#Exits the inner loop, meaning that one row of matrix vector mutiplication is complete, the sum is in $s0
sw $s0, 0($t5)			#Store the sum into the result vector
addi $t5, $t5, 4		#Set the register to the next address to input the next sum into the result vector
addi $t0, $t0, 1		#Increment the outer loop
j outer_loop			#Jumps to the outer loop meaning that one row in the result vector is done
MVM_exit:			#Exit loop
lw $s0, 0($sp)      		# Load the saved value back into $s0
addi $sp, $sp, 4     		# Adjust the stack pointer to release the space
jr $ra				#Return to the main function



read_vector:
addi $sp, $sp, -4      			# Adjust the stack pointer to make space for one word
sw $s0, 0($sp)	       			# Store the value of $s0 onto the stack
move $s0, $a0				# Store $a0 into $s0 so it is preserved 
li $t0, 1				#Set our counter to 1
addi $t1, $a0,1				#Set $t1 to one more than the amount of vector elements we have as we start our loop at 1
li $v0, 4				#Used to print 
la $a0, vector_prompt1			#Load the vector_prompt1 into the argument
syscall					#Print the vector_prompt1
la $t2, V				#Set $t2 to the address of the vector
read_vector_loop:			#Our loop to read the user inputs and put it into the vector
beq $t0, $t1, end_read_vector		#Loop condition that jumps to the exit
li $v0, 4				#Used to print input_prompt1
la $a0, input_prompt1			#Loads input_prompt1 as the argument to print
syscall					#Prints input_prompt1
li $v0, 1				#Used to print an integer
move $a0, $t0				#Set out loop register as the integer to print
syscall					#Print the loop integer at the current loop iteration
li $v0, 4				#Used to print a string
la $a0, input_prompt2			#Loads input_prompt2 as the argument to print
syscall					#Prints input_prompt2
li $v0, 5				#Indicates a user integer input
syscall					#Gets the user integer input and stores in $v0
sw $v0, 0($t2)				#Input the user integer input into the vector
addi $t0,$t0,1				#Iterate loop	
addi $t2, $t2,4				#Iterate to the next available vector address
j read_vector_loop			#Jump condition

end_read_vector:
move $a0, $s0				# Load the saved value back into $a0
lw $s0, 0($sp)       			#Load the original $s0 value on the stack back into $s0
addi $sp, $sp, 4      			# Adjust the stack pointer to release the space
jr $ra 					#Return from the function



read_matrix:				#Function that reads the matrix
addi $sp, $sp, -8			#Allocate space onto the stack in order ot preserve $a0 anf $a1
sw $s0, 0($sp)				#Store the original $s0 value into the stack
sw $s1, 4($sp)				#Store the original $s1 value onto the stack 
move $s0, $a0 				# saving a backup of an $a register
move $s1, $a1 				# saving a backup of an $a register
li $t0, 1				#Our counter register is set to 1
mul $a1, $a0,$a1			#$a1 becomes the total number of elements in the matrix
addi $t1, $a1, 1			#Set our break number as 1 more than the number of elements as we start our loop from 1
li $v0, 4				#Used to print a string
la $a0, matrix_prompt1			#Used to print matrix_prompt1
syscall					#Prints matrix_prompt1
la $t2, M				#Set $t2 to the address of our matrix
read_matrix_loop:			#Loop used to read the user input and store value into the matrix
beq $t0, $t1, end_read_matrix		#Once we have store all the numbers we break from the loop
li $v0, 4				#Used to print a string
la $a0, input_prompt1			#Used to print input_prompt1
syscall					#Prints input_prompt1
li $v0, 1				#Used to print an integer
move $a0, $t0				#Used to print the nth element that we are at 
syscall					#Prints the nth element we are at
li $v0, 4				#Used to print a string
la $a0, input_prompt2			#Used to print input_prompt2
syscall					#Prints input_prompt2
li $v0, 5				#Used to get user input integer
syscall					#Gets the user input integer
sw $v0, 0($t2)				#Puts the user inputted integer into the memory address of our matrix
addi $t0,$t0,1				#Increments our counter
addi $t2, $t2,4				#Goes to the next available memory location in the matrix
j read_matrix_loop			#Jump condition

end_read_matrix:			#End call 
move $a0, $s0				#Restore the $a0 value back into $a0
move $a1, $s1				#Restore the $a1 value back into $a1
lw $s0, 0($sp)      			# Load the saved value back into $s0
lw $s1, 4($sp)				# Load the saved value back into $s0
addi $sp, $sp, 8   			#Deallocate memory on the stack
jr $ra 					#Return call





print_vector:				#Prints the result vector
addi $sp, $sp, -4      			# Adjust the stack pointer to make space for one word
sw $s0, 0($sp)	       			# Store the value of $s0 onto the stack
move $s0, $a0				#Preserve $a0 in $s0
li $t0, 0				#Counter 
la $t2, C				#Register that points to the resulting vector address
print_vector_loop:			#Loop to print out the values in the resulting vector
beq $t0, $a1, exit_print_vector		#Exit the loop after all of the values are printed
lw $t3, 0($t2)				#Load the value in the resulting vector into $t3
li $v0, 1				#Used to set up the syscall to print the value in the result vector
move $a0, $t3				#Used to set up the syscall to print the value in the result vector
syscall					#Prints the value in the result vector
li $v0, 4				#Used to set up the syscall to print a newline 
la $a0, newline				#Used to set up the syscall to print a newline
syscall					#Prints a newline
addi $t0, $t0,1				#Increments our counter
addi $t2, $t2, 4			#Goes to the next value in our result matrix
j print_vector_loop			#Loops back meaning that we have printed one value in the result vector
exit_print_vector:			#Exits the subroutine
move $a0, $s0				# Load the saved value back into $a0
lw $s0, 0($sp)       			#Load the original $s0 value back into $s0
addi $sp, $sp, 4      			# Adjust the stack pointer to release the space
jr $ra 					#Returns to main



dimension_error:			#Dimension error call
addi $sp, $sp, -4      			# Adjust the stack pointer to make space for one word
sw $s0, 0($sp)	       			# Store the value of $s0 onto the stack
move $s0, $a0				#Preserve $a0 in $s0
li $v0, 4				#Prints a string
la $a0, error_prompt1			#Loads error_prompt1 into the syscall argument
syscall					#Prints error_prompt1
move $a0, $s0				# Load the saved value back into $a0
lw $s0, 0($sp)       			#Load the orignal $s0 back into $s0 from the stack
addi $sp, $sp, 4      			# Adjust the stack pointer to release the space
j exit					#Exit

space_error:				#Space error call
addi $sp, $sp, -4      			# Adjust the stack pointer to make space for one word
sw $s0, 0($sp)	       			# Store the value of $s0 onto the stack
move $s0, $a0				#Preserve $a0 into $s0
li $v0, 4				#Used to print a string
la $a0, error_prompt2			#Loads error_prompt2 into $a0
syscall					#Print error_prompt2
move $a0, $s0				# Load the saved value back into $a0
lw $s0, 0($sp)       			
addi $sp, $sp, 4      			# Adjust the stack pointer to release the space
j exit

exit:                     	# This is code to terminate the program -- don't mess with this!
  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program
