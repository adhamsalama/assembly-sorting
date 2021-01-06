; This program prompts user for array size, then sorts the array using bubble,insertion and selection sort algorithm and prints the sorted array.
; with ascending and descending feature.
section .data
    input_format: dq "%lld", 0
    output_format: dq "%lld ",0xA, 0
    input_number: dq 2
    counter: dq 0
    size_msg: dq "Enter array size : ", 0xA, 0
    msg: dq "Enter a number : ", 0xA, 0
    welcome_msg: dq "Hello There, ", 0xA, 0
    output_b_msg: dq "The sorted array using bubble sort is : ", 0xA, 0
    output_i_msg: dq "The sorted array using insertion sort is : ", 0xA, 0
    output_s_msg: dq "The sorted array usign selection sort is : ", 0xA, 0
    sorting_type_msg: dq "Enter [1] for Ascending sort or [2] for Decending : ", 0xA, 0 
    sorting_type1_msg: dq "Enter [1] for bubble, [2] for insertion or [3] for selection sort : ", 0xA, 0 ; NEW
    invalid_input_msg: dq "Unexpected input ", 0xA, 0
    new_line: db "", 0xA, 0