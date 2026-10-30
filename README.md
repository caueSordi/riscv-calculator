# RISC-V Integer Calculator

A simple integer calculator implemented in **RISC-V Assembly**, using the RARS (RISC-V Assembler and Runtime Simulator) environment.

This project was developed to practice low-level programming concepts, including arithmetic instructions, registers, branching, loops, subroutines, and system calls.

## Features

The calculator supports the following operations:

| Option | Operation | Description |
|:---:|---|---|
| 1 | Addition | Adds two integers |
| 2 | Subtraction | Subtracts the second integer from the first |
| 3 | Multiplication | Multiplies two integers |
| 4 | Division | Divides the first integer by the second |
| 5 | Square Root | Calculates the integer square root |
| 6 | Power | Raises a base to a non-negative integer exponent |
| 7 | Factorial | Calculates the factorial of a non-negative integer |

## Requirements

- [RARS (RISC-V Assembler and Runtime Simulator)](https://github.com/TheThirdOne/rars)
- RISC-V **RV32IM** instruction set support

## How to Run

1. Open RARS.
2. Load the calculator assembly file (`.asm`).
3. Assemble the program.
4. Run the program.
5. Enter the desired operation from the menu.
6. Provide the required integer input(s).

## Implementation Details

### Arithmetic Operations

Basic arithmetic operations use native RISC-V instructions:

- `add` — Addition
- `sub` — Subtraction
- `mul` — Multiplication
- `div` — Integer division

### Square Root

Since the RV32IM instruction set does not provide a native integer square root instruction, the calculator implements the **Newton-Raphson method**.

The algorithm iteratively improves an initial estimate until it converges to the integer square root.

The result is truncated to an integer. For example:

```text
Input:  50
Output: 7
```

### Power

Exponentiation is implemented using repeated multiplication.

For a base \(b\) and a non-negative integer exponent \(n\):

\[
b^n = \underbrace{b \times b \times \cdots \times b}_{n\text{ times}}
\]

### Factorial

Factorial is implemented using an iterative loop.

\[
n! = n \times (n-1) \times \cdots \times 1
\]

The implementation follows the convention:

\[
0! = 1
\]

## Subroutines

The program uses subroutines to organize input and output operations:

| Subroutine | Purpose |
|---|---|
| `read_one_number` | Reads a single integer |
| `read_two_numbers` | Reads two integers |
| `print_result` | Displays the calculated result |

This structure reduces code duplication and makes the program easier to maintain.

## Error Handling

The calculator currently handles the following invalid cases:

- Division by zero.
- Square root of a negative number.
- Factorial of a negative number.

Invalid menu selections terminate the program.

## Limitations

- All calculations use 32-bit integer registers.
- Division uses integer arithmetic, discarding the fractional part.
- Square root returns only the integer portion of the result.
- Power currently supports non-negative integer exponents.
- Large calculations may overflow the 32-bit integer range. For signed integers, the maximum value is 2,147,483,647.
- The program executes one operation per run; menu repetition is not currently implemented.

## Learning Objectives

This project explores fundamental RISC-V Assembly concepts:

- Register-based arithmetic.
- System calls through `ecall`.
- Conditional branching and program flow.
- Iterative algorithms and loops.
- Subroutine calls using `jal` and `ret`.
- Parameter passing through argument registers (`a0`, `a1`).
- Integer algorithms implemented at the assembly level.

## License

This project is intended for educational purposes.
