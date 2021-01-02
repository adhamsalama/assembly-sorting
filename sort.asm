; This program prompts user for array size, then sorts the array using selection sort algorithm and prints the sorted array.

section .data
    input_format: dq "%lld", 0
    size_msg: dq "Enter array size : ", 0xA, 0
    nl: db "", 0xA, 0

section .bss
    size resq 2
    array resq 21

section .text
global main
extern printf
extern scanf

main:
    push RBP
    ; Prompt user for input size
    mov RDI, size_msg
    call printf
    ; Scan input size
    mov RDI, input_format
    mov RSI, size
    call scanf
