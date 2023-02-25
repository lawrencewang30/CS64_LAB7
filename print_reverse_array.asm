# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array in reverse order are:\n"
	newline: .asciiz "\n"

.text
printA:
    # TODO: Write your function code here
	addi $t0, $a0, 0
	addi $a1, $a1, -1

printA_loop:
	li $t2, 0  
	li $t3, 0
	blt $a1, $zero, exit_loop
	sll $t2, $a1, 2               # go to address of last element of array
	add $t3, $t0, $t2             # put address of last element in $t3
	lw $t5, 0($t3)                # load last element in $t5

	li $v0, 1
	move $a0, $t5
	syscall

	li $v0, 4
	la $a0, newline
	syscall
	
	addi $a1, $a1, -1             # decrement to the next last element in array
	j printA_loop                 # repeat loop

exit_loop:
	jr $ra


main:  # DO NOT MODIFY THE MAIN SECTION
	li $v0, 4
	la $a0, cout
	syscall

	la $a0, array
	li $a1, 10

	jal printA

exit:
	# TODO: Write code to properly exit a SPIM simulation
	li $v0, 10
	syscall
