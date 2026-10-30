
.data
number: .asciz "Enter a number: "
menu: .asciz "\n1 - Addition\n2 - Subtraction\n3 - Multiplication\n4 - Division\n5 - Square Root\n6 - Power\n7 - Factorial\nOption: "
result: .asciz "Result: "
invalid: .asciz "Invalid operation"

.text
.globl main

main:

    # Initial message
    li a7, 4
    la a0, number
    ecall

    li a7, 4
    la a0, menu
    ecall

    # Read operation choice
    li a7, 5
    ecall
    mv t0, a0

    # Compare operation choices
    li t1, 1
    beq t0, t1, addition

    li t1, 2
    beq t0, t1, subtraction

    li t1, 3
    beq t0, t1, multiplication

    li t1, 4
    beq t0, t1, division

    li t1, 5
    beq t0, t1, square_root

    li t1, 6
    beq t0, t1, power

    li t1, 7
    beq t0, t1, factorial

    j exit


# Arithmetic operations

addition:

    jal ra, read_two_numbers
    add t3, a0, a1
    j print_result


subtraction:

    jal ra, read_two_numbers
    sub t3, a0, a1
    j print_result


multiplication:

    jal ra, read_two_numbers
    mul t3, a0, a1
    j print_result


division:

    jal ra, read_two_numbers

    beq a1, zero, error

    div t3, a0, a1
    j print_result


# Input subroutines

read_two_numbers:

    # Read the first number
    li a7, 4
    la a0, number
    ecall

    li a7, 5
    ecall
    mv t0, a0

    # Read the second number
    li a7, 4
    la a0, number
    ecall

    li a7, 5
    ecall
    mv a1, a0

    # Restore the first number
    mv a0, t0

    ret


read_one_number:

    li a7, 4
    la a0, number
    ecall

    li a7, 5
    ecall

    ret


# Output subroutine

print_result:

    li a7, 4
    la a0, result
    ecall

    li a7, 1
    mv a0, t3
    ecall

    j exit


# Square root operation

square_root:

    jal ra, read_one_number

    mv t1, a0

    # Negative numbers do not have real square roots
    blt t1, zero, error

    # Handle the square root of zero
    beq t1, zero, square_root_zero

    # Initial estimate: the number itself
    mv t2, t1

square_root_loop:

    div t3, t1, t2
    add t3, t3, t2
    srli t3, t3, 1

    # If the estimate stops decreasing,
    # the integer square root has been found
    bge t3, t2, square_root_end

    mv t2, t3
    j square_root_loop

square_root_end:

    mv t3, t2
    j print_result

square_root_zero:

    li t3, 0
    j print_result


# Power operation

power:

    jal ra, read_two_numbers

    mv t1, a0      # Base
    mv t2, a1      # Exponent

    li t3, 1       # Initial result

power_loop:

    beq t2, zero, power_end

    mul t3, t3, t1
    addi t2, t2, -1

    j power_loop

power_end:

    j print_result


# Factorial operation

factorial:

    jal ra, read_one_number

    mv t1, a0
    li t3, 1

    blt t1, zero, error

factorial_loop:

    beq t1, zero, factorial_end

    mul t3, t3, t1
    addi t1, t1, -1

    j factorial_loop

factorial_end:

    j print_result


# Exit and error handling

exit:

    li a7, 10
    ecall


error:

    li a7, 4
    la a0, invalid
    ecall

    li a7, 10
    ecall
