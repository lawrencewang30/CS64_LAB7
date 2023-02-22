# conversion.asm program
# Don't forget to:
#   make all arguments to any function go in $a0 and/or $a1
#   make all returned values from functions go in $v0

.text
conv:
    # TODO: Write your function code here
    li $a2, 0
    li $t1, 0
    li $t2, 8
    li $t4, 2

conv_loop:
    bge $t1, $t2, exit_loop
    sll $t3, $a0, 3
    sub $a2, $a2, $t3
    add $a2, $a2, $a1

    ble $a0, $t4, if_statement
    addi $a1, $a1, -1

if_statement:
    addi $a0, $a0, 1
    addi $t1, $t1, 1
    j conv_loop

exit_loop:
    move $v0, $a2
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
