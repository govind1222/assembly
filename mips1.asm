.data
a:		.word 0
b:		.word 0
c:		.word 0
a2:		.word 0
b2:		.word 0
c2:		.word 0
name:		.space 20
namePrompt:	.asciiz "What is your name? "
integers:	.asciiz "Please enter an integer between 1-100: "
results:	.asciiz "your answers are: "
space:		.asciiz " "

.text
main:	
	
	# prompt user for name
	la	$a0, namePrompt
	li	$v0, 4
	syscall
	
	# get name from user and save
	li	$v0, 8
	la	$a0, name
	li	$a1, 20
	syscall
	
	# prompt user for integer 1
	la	$a0, integers
	li	$v0, 4
	syscall
	
	# get int from user
	li	$v0, 5
	syscall
	sw	$v0, a
	
	# prompt user for integer 2
	la	$a0, integers
	li	$v0, 4
	syscall
	
	# get int from user
	li	$v0, 5
	syscall
	sw	$v0, b

	# prompt user for integer 3
	la	$a0, integers
	li	$v0, 4
	syscall
	
	# get int from user
	li	$v0, 5
	syscall
	sw	$v0, c
	
	# loading integers into saved register
	lw	$s0, a
	lw	$s1, b
	lw	$s2, c
	
	# calculate ans1 = 2a - b + 9
	add	$t0, $s0, $s0	# performs 2a
	sub	$t0, $t0, $s1	# subtracts b from previous result
	add	$t0, $t0, 9	# adds nine to previous result
	sw	$t0, a2		# saves result into a2
	
	# calculate ans2 = c - b + (a - 5)
	sub	$t0, $s2, $s1	# performs c - b
	subi	$t1, $s0, 5	# performs a - 5
	add	$t0, $t0, $t1	# adds the results from previous operations
	sw	$t0, b2
	
	# calculate ans3 = (a - 3) + (b + 4) - (c + 7)
	subi	$t0, $s0, 3	# performs a - 3
	addi	$t1, $s1, 4	# performs b + 4
	addi	$t2, $s2, 7	# performs c + 7
	add	$t0, $t0, $t1	# adds (a - 3) + (b + 4)
	sub	$t0, $t0, $t2	# subtracts (c + 7) from previous result
	sw	$t0, c2
		
	# print name out
	li	$v0, 4
	la	$a0, name
	syscall
	
	# print out integer results
	li	$v0, 4
	la	$a0, results
	syscall
	
	# test print number out
	lw	$a0, a2
	li	$v0, 1
	syscall		# prints out first result
	
	li	$v0, 4
	la	$a0, space
	syscall		# prints out space

	lw	$a0, b2
	li	$v0, 1
	syscall		# prints out second result
	
	li	$v0, 4
	la	$a0, space
	syscall		# prints out space

	lw	$a0, c2
	li	$v0, 1
	syscall		# prints out third result

		
	# expected sample run 1
	# for a = 4, b = 7, c = 24
	# ans1 = 10, ans2 = 16, ans3 = -19
	
	# expected sample run 2
	# for a= 6, b = 12, c = 3
	# ans1 = 9, ans2 = -8, ans3 = 9
	
	# sample runs
	
	# What is your name? Govind
	# Please enter an integer between 1-100: 4
	# Please enter an integer between 1-100: 7
	# Please enter an integer between 1-100: 24
	# Govind
	# your answers are: 10 16 -19
	
	# What is your name? Govind
	# Please enter an integer between 1-100: 6
	# Please enter an integer between 1-100: 12
	# Please enter an integer between 1-100: 3
	# Govind
	# your answers are: 9 -8 9
		
		
exit:
	li	$v0, 10
	syscall
