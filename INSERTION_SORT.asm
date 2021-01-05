; This program prompts user for array size, then sorts the array using INSERTION SORT algorithm and prints the sorted array.
; with ascending and descending feature added
section .data
    input_format: dq "%lld", 0
    output_format: dq "%lld ",0xA, 0
    input_number: dq 2
    counter: dq 0
    size_msg: dq "Enter array size : ", 0xA, 0
    msg: dq "Enter numbers : ", 0xA, 0
    output_msg: dq "The sorted array is : ", 0xA, 0
    sorting_type_msg: dq "Choose 1 for Ascending sort or 2 for Decending : ", 0xA, 0 ; new
    new_line: db "", 0xA, 0
    
section .bss
    size resq 2
    array resq 21
    sortingType resq 2          ;new
    
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

    ; Print newline
    mov RDI, new_line
    call printf

    ; Prompt user to input array elements
    mov RDI, msg
    call printf

    xor RAX, RAX; RAX = 0
    xor RCX, RCX; RCX = 0
    xor RBX, RBX; RBX = 0
