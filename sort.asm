; This program prompts user for array size, then sorts the array using selection sort algorithm and prints the sorted array.

section .data
    input_format: dq "%lld", 0
    size_msg: dq "Enter array size : ", 0xA, 0
    nl: db "", 0xA, 0
