; This program prompts user for array size, then sorts the array using selection sort algorithm and prints the sorted array.

section .data
section .data
    input_format: dq "%lld", 0
    output_format: dq "%lld ",0xA, 0
    input_number: dq 2
    counter: dq 0
    size_msg: dq "Enter array size : ", 0xA, 0
    msg: dq "Enter a number : ", 0xA, 0
    output_msg: dq "The sorted array using bubble sort is : ", 0xA, 0
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
    
INPUT_SIZE:
    ; Prompt user for input size
    mov RDI, size_msg
    call printf
    ; Scan input size
    mov RDI, input_format
    mov RSI, size
    call scanf
    
    mov R10, [size]
    cmp R10, 0
    jg ARRAY_NUMBERS
    mov RDI, invalid_input_msg
    call printf
    mov RDI, new_line
    call printf
    jmp INPUT_SIZE
    
ARRAY_NUMBERS:
    ; Print newline
    mov RDI, new_line
    call printf

    ; Prompt user to input array elements


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

    DONE:								; Reinitialize
	   xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0
        mov RDI, new_line
        call printf
    ; Prompt user for sorting type
    mov RDI, sorting_type_msg
    call printf

    ; Scan sorting type
    mov RDI, input_format                   
    mov RSI, sortingType
    call scanf
    
    mov R15, [sortingType]                  ; R15 = sortingType
    
    cmp R15, 2
    je B_DESCENDING_SORTING                 ; if R15 (sorting Type) == 2 DESCENDING_SORTING
                                            ; else ASCENDING SORT
    ;***************** START ASCENDING BUBBLE SORT *********************
        
    mov RSI,[size]                          ; RSI = size
    dec RSI                                 ; RSI = size -1

    B_ASCENDING_SORTING_L1: 

	     cmp RSI, 0
	     je B_ASCENDING_SORTING_L1_END               ; if RSI = 0 (reach the start of the array) end sorting
                                            ; else sort
          xor RDI, RDI                      ; RSI = 0

	B_ASCENDING_SORTING_L2:

		cmp RDI, RSI                    
		jge B_ASCENDING_SORTING_L2_END              ; if RDI >= RSI (RDI reached the loop limit) stop sorting and repeat for RSI -= 1
                                            ; else start comparing
		mov RAX, [array+RDI*8]            ; RAX = array[RDI]
          inc RDI
		mov RBX, [array+RDI*8]            ; RAX = array[RDI + 1]
          dec RDI
		cmp RAX, RBX                  
		jg B_ASCENDING_SWAP                         ; if RAX > RBX swap them 
                                            ; else icrease RDI and repeat
		inc RDI
		jmp B_ASCENDING_SORTING_L2

	B_ASCENDING_SWAP:

		mov [array+RDI*8], RBX            ; array[RDI] = RBX (array[RDI + 1])
          inc RDI
		mov [array+RDI*8], RAX            ; array[RDI + 1] = RAX (array[RDI])
		jmp B_ASCENDING_SORTING_L2                  ; repeat with RDI += 1

	B_ASCENDING_SORTING_L2_END:

		dec RSI                           ; RSI -= 1
		jmp B_ASCENDING_SORTING_L1                  ; start all over again

    B_ASCENDING_SORTING_L1_END:
        jmp PRINT_OUTPUT_MSG
    ;***************** END ASCENDING BUBBLE SORT *********************

    ;***************** START DESCENDING BUBBLE SORT *********************
   B_DESCENDING_SORTING: 
    mov RSI,[size]
    dec RSI

    B_DESCENDING_SORTING_L1: 
	     cmp RSI, 0                       ; RSI = out, RDI = in, in JAVA code                           
	     je B_DESCENDING_SORTING_L1_END   ; if RSI < 1 don't sort 
                                          ; else sort them
          mov RDI, 0                      ; RDI = 0

	B_DESCENDING_SORTING_L2:
		cmp RDI, RSI
		jge B_DESCENDING_SORTING_L2_END   ; if RDI >= RSI
		mov RAX, [array+RDI*8]            ; RAX = array[RDI]
        inc RDI
		mov RBX, [array+RDI*8]            ; RBX = array[RDI+1]
        dec RDI
		cmp RAX, RBX                  
		jl B_DESCENDING_SWAP              ; if RAX < RBX swap them 
		inc RDI                           ; else inc RDI and loop again
		jmp B_DESCENDING_SORTING_L2

	B_DESCENDING_SWAP:
		mov [array+RDI*8], RBX            ; array[RDI] = RBX
        inc RDI
		mov [array+RDI*8], RAX            ; array[RDI+1] = RAX
		jmp B_DESCENDING_SORTING_L2       ; sorting L2
	B_DESCENDING_SORTING_L2_END:
		dec RSI                           ; RSI -= 1
		jmp B_DESCENDING_SORTING_L1       ; sorting again on the next element

    B_DESCENDING_SORTING_L1_END:
	mov RBX, 0
    jmp PRINT_OUTPUT_MSG
    ;***************** END DESCENDING BUBBLE SORT *********************

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
        ; Print array
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
