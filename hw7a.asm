.data
prompt_str:    	.asciiz "Triangle(0) or Square(1) or Pyramid (2)?"
size_prompt:   	.asciiz "Required size? "
character: 	    .asciiz "*"
newline:	    .asciiz "\n"
space:		    .asciiz " "


.text
main:
    # Ask for the type of figure
    li $v0, 4
    la $a0, prompt_str
    syscall

    # Read user input
    li $v0, 5
    syscall
    move $t0, $v0  	# $t0 contains the choice of figure
    move $s0, $t0	# we save the choice for later use	

    # Ask for the size of the figure
    li $v0, 4
    la $a0, size_prompt
    syscall

    # Read user input
    li $v0, 5
    syscall
    move $t1, $v0  	# $t1 contains the size of the figure
    move $s1, $t1	# we save the size for later use
    
    #Check the figure type and send to respective loop
    beq $s0, 0x00, Triangle	#if our saved value for the figure type is 0, then we send to the triangle subroutine
    beq $s0, 0x01, Square	#if our saved value for the figure type is 0, then we send to the square subroutine
    beq $s0, 0x02, Pyramid	#if our saved value for the figure type is 0, then we send to the pyramid subroutine
    
Triangle:
	li $t2,0x01		#this is our counter variable for our loop
	addi $s1,$s1,1		#we add 1 to our saved size value as we use 1 as the beginning of our counter instead of 0
	triangle_loop:
	beq $t2,$s1,triangle_End	#our end loop condition, where it jumps to our terminate program loop after it loops 'size' times
	move $a1, $t2			#sets our argument value needed for print_star_line
	jal print_star_line		#call to print_star_line
	li $v0, 4
	la $a0, newline
	syscall 			#previous three lines add a new line after we have printed the stars
	addi $t2, $t2,1			#iterates $t2 to progress the loop
	j triangle_loop			#loop statement 
	
	triangle_End:			#end loop that ends the program
	li $v0, 10
	syscall

Square:
	li $t2,0x00		#sets $t2 which we will use to iterate to 0
	square_loop:
	beq $t2,$s1,Square_End	#our loop condition when met, jumps to the end loop 
	addi $t2, $t2,1		    #increments our iterate register
	move $a1, $s1		    #set our argument for print_star_line to the user size input
	jal print_star_line	    #call to print_star_line
	li $v0, 4
	la $a0, newline
	syscall 		#previous three lines used to add a newline character after the star printing is done
	j square_loop		#loop 
	
	Square_End:		#terminates the program after it makes a square
	li $v0, 10
	syscall
	
	


Pyramid:
	li $t2,0x01		# setting our iterator register to 1
	li $t6, 0x01		# constant 1 used for decrement
	sub $t5,$s1,$t6		#$t5 register stores the original amount of spaces needed in order to format the first star printed
	addi $s1,$s1,1		#increment the user inputted size by 1 as we start our loop with $t2 set to 1
	pyramid_loop:
	beq $t2, $s1, Pyramid_End	#end loop condition that jumps to Pyramid_End
	move $a2, $t5			#set our argument register for print_space_line to $t5 to print correct amount of formatting spaces
	jal print_space_line		#prints the amount of spaces
	sub $t5, $t5,$t6		#decrements the amount of spaces for each subsequent line
	li $t7, 0x00		#inner loop iterator register set to 0
	inner_print_loop:
	beq $t7, $t2,leave	    #end loop that jumps to the rest of the outer loop code
	move $a1, $t6		    #set argument to print 1 star
	jal print_star_line 	#prints 1 star
	move $a2, $t6		    #sets argument to print 1 space
	jal print_space_line	#prints 1 space
	addi $t7,$t7,1		    #increment our innter loop iterator
	j inner_print_loop	    #loop for inner loop
	
	leave:			
	addi $t2,$t2,1		#after we have done one loop of the outer and inner loop we increment for our outer loop
	li $v0, 4
	la $a0, newline		
	syscall			#adds a newline after we have printed one iteration of the pyramid
	j pyramid_loop		#loop for outer loop
	
	Pyramid_End:		#terminates the program after we have finished
	li $v0, 10
	syscall
	
	
print_star_line:
	li $t3, 0x00	        #Set temp variable to 0
	print_star_line_loop:
		beq $t3, $a1, print_star_line_fin	#Leaves loop after it loops n times
		addi $t3,$t3,1				        #increments the iterator register $t3
		li $v0, 4
		la $a0, character
		syscall					        #prints the star character 
		j print_star_line_loop			#loop
	print_star_line_fin:				#return loop to go back to previous code
		jr $ra
		
print_space_line:
	li $t4, 0x00	        #Set temp variable to 0
	print_space_line_loop:
		beq $t4, $a2, print_space_line_fin	    #Leaves loop after it loops n times
		addi $t4,$t4,1			            	#increments the iterator register $t4
		li $v0, 4
		la $a0, space
		syscall					        #prints the space character
		j print_space_line_loop			#loop statement
	print_space_line_fin:				#return loop to go back to previous code
		jr $ra
	
	