; This program prompts user for array size, then sorts the array using selection sort algorithm and prints the sorted array.

section .data
    input_format: dq "%lld", 0
    output_format: dq "%lld ",0xA, 0
    input_number: dq 2
    counter: dq 0
    size_msg: dq "Enter array size : ", 0xA, 0
    msg: dq "Enter numbers : ", 0xA, 0
    output_msg: dq "The sorted array is : ", 0xA, 0
    new_line: db "", 0xA, 0

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
    mov RDI, new_line
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
    	mov RDI, new_line
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

    OUTTER_LOOP:							
	    cmp RCX, [size]
	    jge PRINT_OUTPUT_MSG
	    mov [counter], RCX
	    mov RAX, [array+RCX*8]
    
    INNER_LOOP:				
	    inc RCX ; c++
	    cmp RCX, [size]                 
	    jz OK                           
	    cmp RAX, [array+RCX*8]		     
	    jle INNER_LOOP		
	    xchg RAX, [array+RCX*8]			
	    jmp INNER_LOOP
    

    PRINT_OUTPUT_MSG:

        ;Clear RAX, RCX and RBX
        xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0

        ; Print the output message "The sorted array is:"
        mov RDI, output_msg
        call printf

        xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0


    PRINT_ARRAY:						
        ;Print array
        ; Iterate through the array and print each element and then goto END when reaching size

	    cmp RCX, [size]
	    jz END

        ;Get the next element at the array and put it in RAX then increment the counter
	    mov RAX, [array+RCX*8]			
	    inc RCX	
	    mov [counter], RCX

        ;Print the current element
	    mov RDI, output_format
	    mov RSI, RAX
	    call printf

	    mov RCX, [counter]
	    jmp PRINT_ARRAY


    END:	
        ; Print newline and clear registers
	    mov RDI, new_line
	    call printf

	    xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0
	
	    pop RBP
	    ret