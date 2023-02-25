# Data Area
.data
    buffer: .space 100
    input_prompt:   .asciiz "Enter string:\n"
    output_prompt:   .asciiz "Output:\n"
    convention: .asciiz "Convention Check\n"
    newline:    .asciiz "\n"

.text

# DO NOT MODIFY THE MAIN PROGRAM
main:
    la $a0, input_prompt    # prompt user for string input
    li $v0, 4
    syscall

    li $v0, 8       # take in input
    la $a0, buffer
    li $a1, 100
    syscall
    move $s0, $a0   # save string to s0

    ori $s1, $0, 0
    ori $s2, $0, 0
    ori $s3, $0, 0
    ori $s4, $0, 0
    ori $s5, $0, 0
    ori $s6, $0, 0
    ori $s7, $0, 0

    move $a0, $s0
    jal SwapCase

    add $s1, $s1, $s2
    add $s1, $s1, $s3
    add $s1, $s1, $s4
    add $s1, $s1, $s5
    add $s1, $s1, $s6
    add $s1, $s1, $s7
    add $s0, $s0, $s1

    la $a0, output_prompt    # give Output prompt
    li $v0, 4
    syscall

    move $a0, $s0
    jal DispString

    j Exit

DispString:
    addi $a0, $a0, 0
    li $v0, 4
    syscall
    jr $ra

ConventionCheck:
    addi    $t0, $0, -1
    addi    $t1, $0, -1
    addi    $t2, $0, -1
    addi    $t3, $0, -1
    addi    $t4, $0, -1
    addi    $t5, $0, -1
    addi    $t6, $0, -1
    addi    $t7, $0, -1
    ori     $v0, $0, 4
    la      $a0, convention
    syscall
    addi    $v0, $zero, -1
    addi    $v1, $zero, -1
    addi    $a0, $zero, -1
    addi    $a1, $zero, -1
    addi    $a2, $zero, -1
    addi    $a3, $zero, -1
    addi    $k0, $zero, -1
    addi    $k1, $zero, -1
    jr      $ra
    
Exit:
    ori     $v0, $0, 10
    syscall

# COPYFROMHERE - DO NOT REMOVE THIS LINE

# YOU CAN ONLY MODIFY THIS FILE FROM THIS POINT ONWARDS:
SwapCase:
    #TODO: write your code here, $a0 stores the address of the string
    move $a1, $a0
    addiu $sp, $sp, -4
    sw $ra, 0($sp)

SwapCase_loop:
    addiu $sp, $sp, -4
    sw $a1, 0($sp)
    li $t0, 65
    li $t1, 90
    li $t2, 97
    li $t3, 122

    lb $t4, 0($a1)
    beq $t4, $zero, exit

is_upper:
    blt $t4, $t0, jump_loop
    bgt $t4, $t1, is_lower
    j upperC_convert

is_lower:
    blt $t4, $t2, jump_loop
    bgt $t4, $t3, jump_loop
    j lowerC_convert

upperC_convert:
    li $v0, 11
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    addi $t4, $t4, 32
    
    li $v0, 11
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    sb $t4, 0($a1)
    jal ConventionCheck
    j jump_loop

lowerC_convert:
    li $v0, 11
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    addi $t4, $t4, -32

    li $v0, 11
    move $a0, $t4
    syscall

    li $v0, 4
    la $a0, newline
    syscall

    sb $t4, 0($a1)
    jal ConventionCheck
    j jump_loop

jump_loop:
    lw $a1, 0($sp)
    addiu $sp, $sp, 4
    addiu $a1, $a1, 1
    j SwapCase_loop

exit:
    lw $a1, 0($sp)
    addiu $sp, $sp, 4
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    # Do not remove this line - it should be the last line in your function code
    jr $ra