# conversion.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
    li $t0, 0
    li $t1, 3
    li $t2, 0
    li $t3, 8
conv:
    # TODO: Write your function code here
    bge $t2, $t3, exit_loop
    sll $t4, $a0, 3
    sub $t0, $t0, $t4
    add $t0, $t0, $a1

    blt $a0, $t1, if_statement
    addi $a1, $a1, -1

if_statement:
    addi $a0, $a0, 1
    addi $t2, $t2, 1
    j conv

exit_loop:
    move $v0, $t0
    jr $ra

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
