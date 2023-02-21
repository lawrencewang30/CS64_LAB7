# conversion.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
    li $a2, 0
    li $t0, 0
    li $t1, 2
    li $t2, 0
    addu $t3, $a0, $zero
conv:
    # TODO: Write your function code here
    bgt $t0, 8, exit_loop
    addiu $t0, $t0, 1
    sll $a0, $a0, 3
    subu $a2, $a2, $a0
    addu $a2, $a2, $a1

    slt $t2, $t3, $t1
    beq $t2, $zero, if_statement

    addiu $t3, $t3, 1
    addu $v0, $a2, $zero

    j conv

exit_loop:
    jr $ra

if_statement:
    addiu $a1, $a1, -1
    jal conv

main:  # DO NOT MODIFY THE MAIN SECTION
    li $a0, 21047284
    li $a1, 124921

    jal conv

    move $a0, $v0
    li $v0, 1
    syscall

exit:
	# TODO: Write code to properly exit a SPIM simulation
    li $v0, 10
    syscall
