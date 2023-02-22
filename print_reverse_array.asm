# print_array.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.data
	array: .word 1 2 3 4 5 6 7 8 9 10
	cout: .asciiz "The contents of the array in reverse order are:\n"

.text
	li $t0, 0
	srl $t1, $a1, 1
	li $t6, 0
printA:
    # TODO: Write your function code here
	beq $t0, $t1, exit_loop
	sll $t2, $t0, 2
	add $t2, $t2, $a0
	lw $t3, 0($t2)

	sll $t4, $t1, 2
	add $a0, $a0, $t4
	lw $t5, 0($a0)

	sw $t3, 0($a0)
	sw $t5, 0($t2)

	addi $t0, $t0, 1
	addi $t1, $t1, -1

	j printA

exit_loop:
	bgt $t6, $a1, exit_print
	addi $t6, $t6, 1
	lw $t3, 0($a0)
	li $v0, 1
	syscall

	addi $a0, $a0, 4
	j exit_loop

exit_print:
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
