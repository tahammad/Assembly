.data
prompt_str:    	.asciiz "Triangle(0) or Square(1) or Pyramid (2)?"
size_prompt:   	.asciiz "Required size? "
character: 	    .asciiz "*"
newline:	    .asciiz "\n"
space:		    .asciiz " " 
figure_error:	.asciiz "Please enter 0, 1, or 2."
size_error:	.asciiz "Please ensure that your size is greater than 0."
 

.text
main:
    li $v0, 4				#Indicates that we are going to print a string
    la $a0, prompt_str			#Load prompt_str as the argument
    syscall				#Prints prompt_str
    li $v0, 5				#Indicates that we will ask the user input an integer
    syscall				#Gets the user integer input
    move $t0, $v0  			# $t0 contains the choice of figure
    move $s0, $t0			# we save the choice for later use
    bltz $t0, figure_error_call		#If the figure number is less than zero then call an error and exit code
    bgt $t0, 2, figure_error_call	#Or if the figure number is more than 2 then call an error and exit code
    li $v0, 4				#Indicates that we are going to print a string
    la $a0, size_prompt			#Load size_prompt as the argument
    syscall				#Prints size_prompt
    li $v0, 5				#Indicates we will ask the user to input an integer
    syscall				#Gets the user integer input
    move $t1, $v0  			# Move the value we get from the user into $t1
    move $s1, $t1			# we save the size for later use
    blez $t1, size_error_call		#If they input the number as less than or equal to 0 then it will call an error and exit
    
    #Check the figure type and send to respective loop
    beq $s0, 0x00, Triangle		#if our saved value for the figure type is 0, then we send to the triangle subroutine
    beq $s0, 0x01, Square		#if our saved value for the figure type is 0, then we send to the square subroutine
    beq $s0, 0x02, Pyramid		#if our saved value for the figure type is 0, then we send to the pyramid subroutine
    
Triangle:				#Triangle subroutine
	jal triangle_function		#Calls the triangle function	
	j triangle_End			#after we print the triangle we jump to the exit subroutine
	triangle_End:			#end loop that ends the program
	li $v0, 10			#Indicates to the syscall that we will be exiting the program
	syscall				#Exits the program
Square:					#Square subroutine
	jal square_function		#Calls the square function
	j Square_End			#After we print the square, jump to the exit subroutine
	Square_End:			#terminates the program after it makes a square
	li $v0, 10			#Indicates that the program is finished
	syscall				#Exits the program 
Pyramid:				#Pyramid subroutine
	
	jal pyramid_function		#Calls the function that makes a pyramid	
	j Pyramid_End			#after the pyramid is printed we need to exit the program
	Pyramid_End:			#terminates the program after we have finished
	li $v0, 10			#Loads 10 into $v0 so when we syscall the code exits
	syscall				#Exit from the program as we are done
	
	
triangle_function:
	addi $sp, $sp,-16		#Make allocation to add our registers that need to be saved on the stack
	sw $ra, 0($sp)			#Saves the $ra register in the stack as we call a function within this function as to not have an infinite loop
	sw $s0, 4($sp)			#Save the contents of $s0 onto the stack so we can save $a1 onto it
	sw $s1, 8($sp)			#Since we are changing the save value in the function, we want to save the original $s1 onto the stack prior
	sw $s2, 12($sp)			#Save the content of $s2 onto the stack to retrieve at the end of the function
	move $s0, $a1			#Since the function changes our $a1 register, hold the orignal value in $s0
	move $s2, $a0			#Since theh function changes our $a0 register, hold the original value in $s2
	li $t2,0x01			#this is our counter variable for our loop
	addi $s1,$s1,1			#we add 1 to our saved size value as we use 1 as the beginning of our counter instead of 0
	triangle_loop:			#Loop subroutine
	beq $t2,$s1,triangle_exit	#our end loop condition, where it jumps to our terminate program loop after it loops 'size' times
	move $a1, $t2			#sets our argument value needed for print_star_line
	jal print_star_line		#call to print_star_line
	li $v0, 4			#Indicates that the syscall is going to print out a string
	la $a0, newline			#set the argument of syscall to newline
	syscall 			#prints newline
	addi $t2, $t2,1			#iterates $t2 to progress the loop
	j triangle_loop			#loop statement 
	triangle_exit:			#Exit loop
	move $a0, $s2			#Restore our original $a0 value 
	move $a1, $s0			#Restore our orignial $a1 value
	lw $s2, 12($sp)			#Restore our original $s2 value from the stack
	lw $s1 ,8($sp)			#Restore our original $s1 value from the stack
	lw $s0, 4($sp)			#Restore our original $s0 value from the stack
	lw $ra, 0($sp)			#Restore our original return address
	addi $sp, $sp, 16		#Reallocate stack memory
	jr $ra				#Return call
	

square_function:			#Our square function
	addi $sp, $sp,-12		#Allocate stack memory
	sw $ra, 0($sp)			#Save the original return address
	sw $s0, 4($sp)			#Saves original $s0 value to the stack
	sw $s2, 8($sp)			#Saves original $s2 value to the stack
	move $s0, $a1			#Saves the original $a1 value to $s0
	move $s2, $a0			#Saves the original $a0 value to $s2
	li $t2,0x00			#sets $t2 which we will use to iterate to 0
	square_loop:			#Loop 
	beq $t2,$s1,square_exit		#our loop condition when met, jumps to the exit loop 
	addi $t2, $t2,1		   	#increments our iterate register
	move $a1, $s1		    	#set our argument for print_star_line to the user size input
	jal print_star_line	    	#call to print_star_line
	li $v0, 4			#Indicates that our syscall will print a string
	la $a0, newline			#sets the argument of syscall as newline
	syscall 			#Prints newline
	j square_loop			#loop 
	square_exit:			#Exit subroutine
	move $a0, $s2			#Inserts our original $a0 value back into $a0
	move $a1,$s0			#Inserts our original $a1 value back into $a1
	lw $s2, 8($sp)			#Loads our original value of $s2 back into $s2 from the stack
	lw $s0, 4($sp)			#Loads our original value of $s0 back into $s0 from the stack
	lw $ra, 0($sp)			#Gives us the orginal return address
	addi $sp, $sp, 12		#Reallocates the stack memory
	jr $ra				#Return call

pyramid_function:			#Pyramid function
	addi $sp, $sp,-16		#Allocate stack memory
	sw $ra, 0($sp)			#Save our original return address into the stack
	sw $s0, 4($sp)			#Save the original value of $s0 onto the stack
	sw $s1, 8($sp)			#Save the original $s1 value onto the stack as the value is changed by the function
	sw $s2, 12($sp)			#Save our original $s2 value onto the stack
	move $s0,$a1			#Since the value of $a1 is changed in the function we need to save it in $s0
	move $s2, $a2			#Since the value of $a2 changes due to the function we need to save it in $s2
	li $t2,0x01			# setting our iterator register to 1
	li $t6, 0x01			# constant 1 used for decrement
	sub $t5,$s1,$t6			#$t5 register stores the amount of spaces needed in order to format the first star printed
	addi $s1,$s1,1			#increment the user inputted size by 1 as we start our loop with $t2 set to 1
	pyramid_loop:			#loop
	beq $t2, $s1, Pyramid_Exit	#end loop condition that jumps to Pyramid_Exit
	move $a2, $t5			#set our argument register for print_space_line to $t5 to print correct amount of formatting spaces
	jal print_space_line		#prints the amount of spaces
	sub $t5, $t5,$t6		#decrements the amount of spaces for each subsequent line
	li $t7, 0x00			#inner loop iterator register set to 0
	inner_print_loop:		#Inner loop
	beq $t7, $t2,leave	    	#end loop that jumps to the rest of the outer loop code
	move $a1, $t6		   	#set argument to print 1 star
	jal print_star_line 		#prints 1 star
	move $a2, $t6		    	#sets argument to print 1 space
	jal print_space_line		#prints 1 space
	addi $t7,$t7,1		   	#increment our inner loop iterator
	j inner_print_loop	   	#loop for inner loop
	
	leave:				#Rest of the outer loop code
	addi $t2,$t2,1			#after we have done one loop of the outer and inner loop we increment for our outer loop
	li $v0, 4			#Syscall will print a string
	la $a0, newline			#Sets the argument for the syscall to newline
	syscall				#adds a newline after we have printed one iteration of the pyramid
	j pyramid_loop			#loop for outer loop
	
	Pyramid_Exit:			#Exit subroutine
	move $a2, $s2			#Gives us the original $a2 value
	move $a1, $s0			#Gives us the original $a1 value
	lw $s2, 12($sp)			#Gets the original $s2 value from the stack
	lw $s1, 8($sp)			#Gets the orignal $s1 value from the stack
	lw $s0, 4($sp)			#Gets the original $s0 value from the stack
	lw $ra, 0($sp)			#Gets the original return address from the stack
	addi $sp, $sp, 16		#Reallocate stack memory
	jr $ra				#Return 
	
	

figure_error_call:			#Error call subroutine
    li $v0, 4				#Syscall will print a string
    la $a0, figure_error		#Set the syscall argument to figure_error
    syscall				#Print figure_error
    li $v0, 10 				#Set syscall to exit code
    syscall				#Exit program
    
size_error_call:			#Error call subroutine
	li $v0, 4			#Set syscall to print a string
    	la $a0, size_error		#Set the argument to syscall as size_error
    	syscall				#Print size_error
    	li $v0, 10 			#Set syscall to exit the program
   	syscall				#Exit the program			
print_star_line:
	li $t3, 0x00	       		 			#Set temp variable to 0
	addi $sp,$sp,-4						#Allocate stack memory to preserve $a0
	sw $s3, 0($sp)						#Store original value of $s3 onto stack
	move $s3, $a0						#Save our original $a0 value in $s3
	print_star_line_loop:					#Loop
		beq $t3, $a1, print_star_line_fin		#Leaves loop after it loops n times
		addi $t3,$t3,1				        #increments the iterator register $t3
		li $v0, 4					#Set syscall to print a string
		la $a0, character				#Set the argument to syscall as character
		syscall					        #prints the star character 
		j print_star_line_loop				#loop
	print_star_line_fin:					#return loop to go back to previous code
		move $a0, $a3					#Restore our original $a0 value
		lw $s3, 0($sp)					#Restore our original $s3 value from the stack
		addi $sp,$sp,4					#Reallocate stack memory
		jr $ra						#Return function
		
print_space_line:
	li $t4, 0x00	       				 	#Set temp variable to 0
	li $t3, 0x00	       		 			#Set temp variable to 0
	addi $sp,$sp,-4						#Allocate stack memory to preserve $a0
	sw $s3, 0($sp)						#Store original value of $s3 onto stack
	move $s3, $a0						#Save our original $a0 value in $s3
	print_space_line_loop:					#Loop
		beq $t4, $a2, print_space_line_fin	   	#Leaves loop after it loops n times
		addi $t4,$t4,1			            	#increments the iterator register $t4
		li $v0, 4					#Set syscall to print a string
		la $a0, space					#Set the argument to syscall as space
		syscall					        #prints the space character
		j print_space_line_loop				#loop statement
	print_space_line_fin:					#return loop to go back to previous code
		move $a0, $a3					#Restore our original $a0 value
		lw $s3, 0($sp)					#Restore our original $s3 value from the stack
		addi $sp,$sp,4					#Reallocate stack memory
		jr $ra						#Return
		
	
