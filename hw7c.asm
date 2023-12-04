.data
  M:      .space 400  		# int M[][] The matrix
  V:      .space 400  		# int V[]   The vector
  C:      .space 400  		# int C[] : The output vector
  m:      .word 10   		  # m is an int whose value is at most 10
                     		  # max value for rows and columns
  col_m: .word 5          # columns for matrix M: This should not be more than 10
  row_m: .word 3          # rows for matrix M:    This should not be more than 10
                          # (col_m * row_m) * 4 <= M
  col_v: .word 1          # colums for vector V. For a vector, the column is always one
  row_v: .word 5          # rows for vector V. This should not be more than 10
                          # (col_v * row_v) * 4 <= V
  error_prompt1:	  .asciiz " NOT WORKABLE BECAUSE OF THE DIMENSIONS"
  error_prompt2:  	.asciiz "NOT WORKABLE BECAUSE OF THE MEMORY"
  input_prompt1:  	.asciiz "Enter element "
  input_prompt2: 	  .asciiz " =" 
  vector_prompt1: 	.asciiz "Enter all the elements in the vector: \n"
  matrix_prompt1: 	.asciiz "Enter all the elements in the matrix: \n"
  newline:          .asciiz "\n"
  



.text
main:
lw $t0, col_m			                    #Sets $t0 to the column length of the matrix
lw $t1, row_v			                    #Sets $t1 to the row length of the vector
lw $t3, row_m		                    	#Sets $t3 to the row length of the matrix
lw $t4, col_v			                    #Sets $t4 to the column length of the vector
move $a2, $t3 	                  		#Sets the argument used in print_vector to the number of elements that will be in the result matrix
bne $t0, $t1, dimension_error	        #If the column length of the matrix is not equal to the row length of the vector, then throw an error
mul $t2, $t0, $t3		                  #Set $t2 to the number of elements of the matrix by multiplying its columns and rows
move $a1, $t2		                    	#Set the number of elements to the argument $a1 to be used later
sll $t2, $t2, 2	                  		#Set $t2 to the number of bytes that all the matrix would take up
bgt $t2, 400, space_error	            #If the byte size used by the matrix is greater than the limit of 400 bytes, throw an error
mul $t2, $t1, $t4                     #Set $t2 to the number of elements of the vector by multiplying the columns and rows of the vector
sll $t2, $t2,2                        #Multiplies the number of elements in the vector by 4 to see the amount of bytes 
bgt $t2, 400, space_error	            #If the byte size used by the vector is greater than the limit of 400 bytes, throw an error
move $a0, $t1		                    	#Set $a0 to the number of rows in the vector
jal read_matrix			
jal read_vector
jal MVM
jal print_vector
j exit



MVM:	
addi $sp, $sp, -4     		          # Adjust the stack pointer to make space for one word
sw $a2, 0($sp)	      		          # Store the value of $a2 onto the stack as we need it for print_vector
li $t0, 0		            	          #Outer loop counter, we want the outer loop to end after n times
la $t3, M			                      #Keeps track of the matrix address
la $t5, C			                      #Keeps track of the result vector address
outer_loop:
beq $t0, $a2,MVM_exit		            #If we have finished calculations through all of the matrix rows then exit
li $t1, 0			                      #Inner loop counter we want the inner loop to restart after each outer loop call and goes until n each time
li $t2, 0			                      #Our register to keep track of the intermediate value
li $s0, 0	                          #Our sum for each iteration
la $t4, V		                        #Our register that gives us the vector address, we need to restart after each row calculation
inner_loop:
beq $t1, $a0, inner_loop_exit	      #Loops through until we do calculations between the matrix and rows and set the sum into the result vector
lw $t6, 0($t3)			                #Load the address of the matrix in $t6
lw $t7, 0($t4)			                #Load the address of the vector in $t7
mul $t2, $t6, $t7		                #Set $t2 to the product which is an intermediate step 
add $s0, $s0, $t2		                #Add that intermediate value to $s0 which is our eventual sum value for that row
addi $t3, $t3, 4		                #Go to the next value in the matrix
addi $t4, $t4, 4		                #Go to the next value in the vector
addi $t1, $t1, 1		                #Increment the inner loop 
j inner_loop			                  #Loops until we do all calculations
inner_loop_exit:		                #Exits the inner loop, meaning that one row of matrix vector mutiplication is complete, the sum is in $s0
sw $s0, 0($t5)			                #Store the sum into the result vector
addi $t5, $t5, 4		                #Set the register to the next address to input the next sum into the result vector
addi $t0, $t0, 1		                #Increment the outer loop
j outer_loop			                  #Jumps to the outer loop meaning that one row in the result vector is done
MVM_exit:			                      #Exit loop
lw $a2, 0($sp)      		            # Load the saved value back into $a2
addi $sp, $sp, 4     		            # Adjust the stack pointer to release the space
jr $ra				                      #Return to the main function



read_vector:
addi $sp, $sp, -4                   # Adjust the stack pointer to make space for one word
sw $a0, 0($sp)	                    # Store the value of $a0 onto the stack
li $t0, 1
addi $t1, $a0,1
li $v0, 4
la $a0, vector_prompt1
syscall
la $t2, V
read_vector_loop:
beq $t0, $t1, end_read_vector
li $v0, 4
la $a0, input_prompt1
syscall
li $v0, 1
move $a0, $t0
syscall
li $v0, 4
la $a0, input_prompt2
syscall
li $v0, 5
syscall
sw $v0, 0($t2)
addi $t0,$t0,1
addi $t2, $t2,4
j read_vector_loop

end_read_vector:
lw $a0, 0($sp)                      # Load the saved value back into $a0
addi $sp, $sp, 4                    # Adjust the stack pointer to release the space
jr $ra 



read_matrix:
addi $sp, $sp, -8     	            # Adjust the stack pointer to make space for $a1, $a0
sw $a1, 0($sp)	       	            # Store the value of $a1 onto the stack
sw $a0, 4($sp)		                  # Store the value of $a0 onto the stack
li $t0, 1
addi $t1, $a1, 1
li $v0, 4
la $a0, matrix_prompt1
syscall
la $t2, M
read_matrix_loop:
beq $t0, $t1, end_read_matrix
li $v0, 4
la $a0, input_prompt1
syscall
li $v0, 1
move $a0, $t0
syscall
li $v0, 4
la $a0, input_prompt2
syscall
li $v0, 5
syscall
sw $v0, 0($t2)
addi $t0,$t0,1
addi $t2, $t2,4
j read_matrix_loop

end_read_matrix:
lw $a1, 0($sp)      	              # Load the saved value back into $a1
lw $a0, 4($sp)		                  # Load the saved value back into $a0
addi $sp, $sp, 8                    # Adjust the stack pointer to release the space
jr $ra 





print_vector:
li $t0, 0		                        #Counter 
la $t2, C		                        #Register that points to the resulting vector address
print_vector_loop:			            #Loop to print out the values in the resulting vector
beq $t0, $a2, exit_print_vector		  #Exit the loop after all of the values are printed
lw $t3, 0($t2)				              #Load the value in the resulting vector into $t3
li $v0, 1				                    #Used to set up the syscall to print the value in the result vector
move $a0, $t3				                #Used to set up the syscall to print the value in the result vector
syscall					                    #Prints the value in the result vector
li $v0, 4				                    #Used to set up the syscall to print a newline 
la $a0, newline				              #Used to set up the syscall to print a newline
syscall					                    #Prints a newline
addi $t0, $t0,1				              #Increments our counter
addi $t2, $t2, 4			              #Goes to the next value in our result matrix
j print_vector_loop			            #Loops back meaning that we have printed one value in the result vector
exit_print_vector:			            #Exits the subroutine
jr $ra 					                    #Returns to main



dimension_error:
li $v0, 4
la $a0, error_prompt1
syscall
j exit

space_error:
li $v0, 4
la $a0, error_prompt2
syscall
j exit

exit:                     # This is code to terminate the program -- don't mess with this!
  addi $v0, $0, 10      	# system call code 10 for exit
  syscall               	# exit the program



#------- If you decide to make other functions, place their code here -------
#
#  You do not have to use helper methods, but you may if you would like to.
#  If you do use them, be sure to do all the proper stack management. 
#
#------------ END CODE ---------------