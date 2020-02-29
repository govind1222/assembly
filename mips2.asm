############################
# author: Govind Pillai - gxp180015
# date: 02/07/2020
# homework3

.data

prompt:		.asciiz "Enter some text: "
word:		.asciiz " words "
spaceWord:	.asciiz " "
newline:	.asciiz "\n"
characters:	.asciiz	" characters\n"
goodbye:	.asciiz "Goodbye! "
numCharacters:	.word 0
numWords:	.word 0
save:		.word 50
input:		.space 50


.text

main:

	li	$v0, 54		# display dialog box and prompt the input
	la	$a0, prompt	
	la	$a1, input
	lw	$a2, save
	syscall
	
	beq	$a1, -2, exit	# exits program if no string entered
	beq	$a1, -3, exit
	beq	$a1, -4, exit	
	
	jal	countChars	# calls function to count characters in input
	
	sw	$v0, numCharacters
	add	$s1, $v0, $0
	
	addi	$v1, $v1, 1	# number of words = number of spaces + 1
	sw	$v1, numWords
	add	$s2, $v1, $0	# saved to s2 
	
	li	$v0, 4		# outputs the string user entered
	la	$a0, input
	syscall
	
	li	$v0, 1		# outputs the number of words
	la	$a0, ($s2)
	syscall
	
	li	$v0, 4		# outputs " words "
	la	$a0, word
	syscall
		
	li	$v0, 1		# outputs the number of characters
	la	$a0, ($s1)
	syscall
	
	li	$v0, 4		# outputs the word "characters\n"
	la	$a0, characters
	syscall
	
	#li	$v0, 4		# outputs a newline
	#la	$a0, newline
	#syscall
	
	j main			# jumps back to main so user can enter string again
	
	
countChars:
	
	la	$t0, input	# saves input as $t0
	li	$t1, 0		# counts number of chars
	li	$t2, 0		# counts number of spaces
	
loop:
	lb	$a0, ($t0)
	beq	$a0, '\0', final	# when we reach end of string, exit loop
	beq	$a0, '\n', final
	addi	$t0, $t0, 1		# add one to byte offset - move to next character
	addi	$t1, $t1, 1		# add one to number of characters
	
	beq	$a0, ' ', space		# if we reach a space
	j loop
	
space:
	addi	$t2, $t2, 1		# add one to number of spaces
	j loop
	
final:	
	add	$s1, $t1, $0	# moving t0 to s1 to push onto stack
	
	addi	$sp, $sp, -4	# push s0 onto the stack
	sw	$s1, ($sp)
	
	add	$v0, $s1, $0	# moves the contents of t1 (number of chars) to v0
	add	$v1, $t2, $0	# moves the contents of t2 (number of spaces) to v1

	
	lw	$s1, ($sp)	# pop s0 off the stack
	addi	$sp, $sp, 4
	
	jr $ra			# saves ra back into pc to resume program execution from original function call

exit: 

	li $v0, 59       	# says goodbye to user
	la $a0, goodbye
	syscall 
	
	li	$v0, 10		# exits the program
	syscall

	# sample runs
	
	# Govind Pillai
	# 2 words 13 characters
	# the lazy brown dog
	# 4 words 18 characters
	
	# -- program is finished running --
