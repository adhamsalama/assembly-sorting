; This program prompts user for array size, then sorts the array using bubble,insertion and selection sort algorithm and prints the sorted array.
; with ascending and descending feature.

section .data
    input_format: dq "%lld", 0
    output_format: dq "%lld ",0xA, 0
    input_number: dq 2
    counter: dq 0
    size_msg: dq "Please enter the array size : ", 0xA, 0
    msg: dq "Enter a number : ", 0xA, 0
    welcome_msg: dq "ًWelcome, ", 0xA, 0
    output_b_msg: dq "The sorted array using bubble sort is : ", 0xA, 0
    output_i_msg: dq "The sorted array using insertion sort is : ", 0xA, 0
    output_s_msg: dq "The sorted array usign selection sort is : ", 0xA, 0
    sorting_type_msg: dq "Enter [1] for Ascending sort or [2] for Decending : ", 0xA, 0 
    sorting_type1_msg: dq "Enter [1] for bubble, [2] for insertion or [3] for selection sort : ", 0xA, 0 ; NEW
    invalid_input_msg: dq "Unexpected input ", 0xA, 0
    new_line: db "", 0xA, 0
    
section .bss
    size resq 2
    array resq 21
    sortingType resq 2

section .text
    global main
    extern printf
    extern scanf

main:
    push RBP
    
    mov RDI, welcome_msg
    call printf
    mov RDI, new_line
    call printf

INPUT_SIZE:
    ; Prompt user for input size
    mov RDI, size_msg
    call printf
    ; Scan input size
    mov RDI, input_format
    mov RSI, size
    call scanf
    
    mov RDI, new_line
    call printf
    
    mov R10, [size]
    cmp R10, 0
    jg ARRAY_NUMBERS
    
    mov RDI, invalid_input_msg
    call printf
    
    mov RDI, new_line
    call printf
    
    jmp INPUT_SIZE

ARRAY_NUMBERS:

    xor RAX, RAX; RAX = 0
    xor RCX, RCX; RCX = 0
    xor RBX, RBX; RBX = 0

   ; Get input and store it in an array
INPUT_ARRAY: 						
    cmp RCX, [size]					; Check the size
    mov RDI, new_line
    jz DONE				                ; Goto done after the input is complete
    mov [counter], RCX
    mov RAX, 0
    
   ; Prompt user to input array elements
    mov RDI, msg
    call printf
     
    mov RDI, input_format
    mov RSI, input_number
    call scanf
    
    mov RAX, [input_number]
    mov RCX, [counter]
    mov [array+RCX*8], RAX
    inc RCX	
    jmp INPUT_ARRAY
    
 DONE:					   ; Reinitialize   
    mov RDI, new_line
    call printf
    
	xor RAX, RAX; RAX = 0
    xor RCX, RCX; RCX = 0
    xor RBX, RBX; RBX = 0
;******************* END OF INPUT********************
