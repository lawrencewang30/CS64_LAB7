# conversion.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
    li $a2, 0
    li $t0, 0
    li $t1, 2
    li $t2, 0
    add $t3, $a0, $zero
conv:
    # TODO: Write your function code here
    bgt $t0, 8, exit_loop
    addi $t0, $t0, 1
    sll $a0, $a0, 3
    sub $a2, $a2, $a0
    add $a2, $a2, $a1

    slt $t2, $a0, $t1
    beq $t2, $zero, if_statement

    addi $t3, $t3, 1
    add $v0, $a2, $zero

    j conv

exit_loop:
    jr $ra

if_statement:
    addi $a1, $a1, -1
    jal conv

main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 5
    li $a1, 7

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
    syscall
