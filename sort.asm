; This program prompts user for array size, then sorts the array using selection sort algorithm and prints the sorted array.

section .data
    input_format: dq "%lld", 0
    output_format: dq "%lld ",0xA, 0
    input_number: dq 2
    counter: dq 0
    size_msg: dq "Enter array size : ", 0xA, 0
    msg: dq "Enter numbers : ", 0xA, 0
    output_msg: dq "The sorted array is : ", 0xA, 0
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
    ; Print newline
    mov RDI, nl
    call printf
    ; Prompt user to input array elements
    mov RDI, msg
    call printf

    xor RAX, RAX; RAX = 0
    xor RCX, RCX; RCX = 0
    xor RBX, RBX; RBX = 0

    ; Get input and store it in an array
    INPUT_ARRAY: 						
    	cmp RCX, [size]					; Check the size
    	mov RDI, nl
    	jz DONE							; Goto done after the input is complete
    	mov [counter], RCX
    	mov RAX, 0
    	mov RDI, input_format
    	mov RSI, input_number
    	call scanf
    	mov RAX, [input_number]
    	mov RCX, [counter]
    	mov [array+RCX*8], RAX
    	inc RCX	
    	jmp INPUT_ARRAY 

    DONE:								; Reinitialize
	    xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0
    

    PRINT_OUTPUT_MSG:

        ;Clear RAX, RCX and RBX
        xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0

        ; Print the output message The sorted array is:
        mov RDI, output_msg
        call printf

        xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0

    PRINT_ARRAY:						
        ;Print array

	    cmp RCX, [size]
	    jz END
	    mov RAX, [array+RCX*8]			
	    inc RCX	
	    mov [counter], RCX
	    mov RDI, output_format
	    mov RSI, RAX
	    call printf
	    mov RCX, [counter]
	    jmp PRINT_ARRAY


    END:	
        ; Print newline and clear registers
	    mov RDI, nl
	    call printf

	    xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0
	
	    pop RBP
	    ret