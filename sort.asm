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

;*******************START OF GETTING SORTING TYPE(B-S-I)*******************
SORT_TYPE: 
    mov RDI, sorting_type1_msg
    call printf
    mov RDI, input_format                   
    mov RSI, sortingType
    call scanf
    
    mov R15, [sortingType]                        ; R15 = sortingType
    
    cmp R15, 1                              
    je BS_ST_JUMP                                 ;jump to [bubble sort]    (if input is 1)
    cmp R15, 2                              
    je IS_ST_JUMP                                 ;jump to [insertion sort] (if input is 2)
    cmp R15, 3
    je SS_ST_JUMP                                 ;jump to [selection sort] (if input is 3)
    
 ; unexcpected input   
    mov RDI, invalid_input_msg              
    call printf
    mov RDI, new_line
    call printf
    jmp SORT_TYPE                                 ;reply the process of choosing a specific sorting type
    
    
 ;*******************END OF GETTING SORTING TYPE(B-S-I)*******************
 
  ; Scan sorting type for bubble sort
 
    BS_ST_JUMP:    ;FOR OVERALL FILE bubble sort, sort type jump (A/D)

  ; prompt user for sorting type
    mov RDI, sorting_type_msg
    call printf
    mov RDI, input_format                   
    mov RSI, sortingType
    call scanf
    
    mov R15, [sortingType]                        ; R15 = sortingType = input
    cmp R15, 1
    je B_ASCENDING_SORTING                        ; if R15 (sorting type) == 1 [ASCENDING_SORTING]
    cmp R15, 2
    je B_DESCENDING_SORTING                       ; if R15 (sorting Type) == 2 [DESCENDING_SORTING]
    
  ; unexpected input   
    mov RDI, invalid_input_msg
    call printf 
    mov RDI, new_line
    call printf  
    jmp BS_ST_JUMP                                ;reply the process of choosing bubbles sort type (A/D)
    
          ;***************** START ASCENDING BUBBLE SORT *********************
                                         
    B_ASCENDING_SORTING:         
         mov RSI,[size]                                ; RSI = size
         dec RSI                                       ; RSI = size -1

    B_ASCENDING_SORTING_L1: 

	     cmp RSI, 0
	     je B_ASCENDING_SORTING_L1_END        ; if RSI = 0 (reach the start of the array) end sorting
                                                  ; else sort
         xor RDI, RDI                            ; RSI = 0

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
        jmp PRINT_B_OUTPUT_MSG
    ;***************** END ASCENDING BUBBLE SORT *********************

    ;***************** START DESCENDING BUBBLE SORT *********************
   B_DESCENDING_SORTING: 
    mov RSI,[size]
    dec RSI

    B_DESCENDING_SORTING_L1: 
	     cmp RSI, 0                           ; RSI = out, RDI = in, in JAVA code                           
	     je B_DESCENDING_SORTING_L1_END       ; if RSI < 1 don't sort 
                                                  ; else sort them
         mov RDI, 0                              ; RDI = 0

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
    jmp PRINT_B_OUTPUT_MSG
    ;***************** END DESCENDING BUBBLE SORT *********************
      ;scan input sorting type for insertion sort

IS_ST_JUMP:        ;FOR OVERALL FILE insertion sort, sort type jump  (A/D)
   
   ; prompt user for sorting type
    mov RDI, sorting_type_msg
    call printf
    mov RDI,input_format
    mov RSI, sortingType
    call scanf
    mov R15, [sortingType]                    ; R15 = sortingType = input
    
    cmp R15, 1
    je AISORT_INIT                               ; if R15 (sorting type) == 1 ASCENDING_SORTING
    cmp R15, 2
    je DISORT_INIT                              ; if R15 (sorting Type) == 2 DESCENDING_SORTING
   
   ; unexpected input 
    mov RDI, invalid_input_msg
    call printf
    mov RDI, new_line
    call printf    
    jmp IS_ST_JUMP                      ;reply the process of choosing insertion sort type (A/D)
    
    ;***************** Ascending INSERTION SORT START ******************* 
 
  ;RSI = i, RDI = j, RAX = array[i], RBX = array[j] 
        
AISORT_INIT:    ;initialize variable
    mov RSI, 0    
    
AISORT_1:                                     ;outer loop
	cmp RSI, [size]                       ;check if RSI >= size
	jge AISORT1_END                       ;if it's true then jump to label AISORT1_END
	mov RDI, RSI                          ;else continue and ignore the previous line RDI = RSI
	inc RDI                               ;RDI++
	AISORT_2:                             ;Inner Loop
		cmp RDI, [size]               ;check if RDI >= size
		jge AISORT2_END               ;if it's true exit the inner loop
		mov RAX, [array+RSI*8]        ;RAX = array[RSI]
		mov RBX, [array+RDI*8]        ;RBX = array[RDI]
		cmp RAX, RBX                  ;check if RAX>RBX or array[i]>array[j]
		jg AISWAP                     ;if true then jump to AISWAP lable to swap them
		inc RDI                       ;else RDI++ and continue
		jmp AISORT_2                  ;jump to the start of the inner loop
	AISWAP:                               ;swap label
		mov [array+RDI*8], RAX        ;array[j] = RAX
		mov [array+RSI*8], RBX        ;array[i] = RBX
		inc RDI                       ;RDI++
		jmp AISORT_2                  ;return to the start of the inner loop
	AISORT2_END:                          
		inc RSI                       ;RSI++
		jmp AISORT_1                  ;return to the start of the outer loop
AISORT1_END:
     mov RBX, 0                            ;RBX = 0
     jmp PRINT_I_OUTPUT_MSG                ; jump to PRINT_OUTPUT_MSG label
	
;***************** Ascending INSERTION SORT END *******************   

;***************** Decending INSERTION SORT START *******************

  ;RSI = i, RDI = j, RAX = array[i], RBX = array[j]
  
DISORT_INIT:    ;initialize variable
    mov RSI, 0                       
DISORT_1:                                     ;outer loop
	cmp RSI, [size]                       ;check if RSI >= size
	jge DISORT1_END                       ;if it's true then jump to label AISORT1_END
	mov RDI, RSI                          ;else continue and ignore the previous line RDI = RSI
	inc RDI                               ;RDI++
	DISORT_2:                             ;Inner Loop
		cmp RDI, [size]               ;check if RDI >= size
		jge DISORT2_END               ;if it's true exit the inner loop
		mov RAX, [array+RSI*8]        ;RAX = array[RSI]
		mov RBX, [array+RDI*8]        ;RBX = array[RDI]
		cmp RAX, RBX                  ;check if RAX<RBX or array[i]>array[j]
		jl DISWAP                     ;if true then jump to AISWAP lable to swap them
		inc RDI                       ;else RDI++ and continue
		jmp DISORT_2                  ;jump to the start of the inner loop
	DISWAP:                               ;swap label
		mov [array+RDI*8], RAX        ;array[j] = RAX
		mov [array+RSI*8], RBX        ;array[i] = RBX
		inc RDI                       ;RDI++
		jmp DISORT_2                  ;return to the start of the inner loop
	DISORT2_END:
		inc RSI                       ;RSI++
		jmp DISORT_1                  ;return to the start of the outer loop
DISORT1_END:
    mov RBX, 0                            ;RBX = 0
    jmp PRINT_I_OUTPUT_MSG                ; jump to PRINT_OUTPUT_MSG label
        
        
;***************** Decending INSERTION SORT END *******************
; Scan sorting type for Selection sort

SS_ST_JUMP:

       ; Prompt user for sorting type
        mov RDI, sorting_type_msg
        call printf

       ; Scan sorting type
        mov RDI, input_format
        mov RSI, sortingType                  ; R15 = sortingType = input
        call scanf
        mov R15, [sortingType]
        
        cmp R15, 1
        je S_ASCENDING_OUTTER_LOOP            ; if R15 (sorting type) == 1 ASCENDING_SORTING
        cmp R15, 2
        je S_DESCENDING_OUTTER_LOOP           ; if R15 (sorting type) == 1 DESCENDING_SORTING
        
      ; unexpected input     
        mov RDI, invalid_input_msg
        call printf 
        mov RDI, new_line
        call printf  
        jmp SS_ST_JUMP                     ;reply the process of choosing selection sort type (A/D)
	      
	      ;***************** START ASCENDING SELCTION SORT *********************

    S_ASCENDING_OUTTER_LOOP:							
	    cmp RCX, [size]
	    jge PRINT_S_OUTPUT_MSG
	    mov [counter], RCX
	    mov RAX, [array+RCX*8]
    

    S_ASCENDING_INNER_LOOP:				
	    inc RCX ; c++
	    cmp RCX, [size]                 
	    jz OK_ASCENDING                           
	    cmp RAX, [array+RCX*8]		     
	    jle S_ASCENDING_INNER_LOOP		
	    xchg RAX, [array+RCX*8]			
	    jmp S_ASCENDING_INNER_LOOP
        
    
    OK_ASCENDING:									
	    mov RCX, [counter]
	    mov [array+RCX*8], RAX
	    inc RCX
	    jmp S_ASCENDING_OUTTER_LOOP

        ;***************** END ASCENDING SELCTION SORT *********************

        ;***************** START DESCENDING SELCTION SORT *********************

    S_DESCENDING_OUTTER_LOOP:							
	    cmp RCX, [size]
	    jge PRINT_S_OUTPUT_MSG
	    mov [counter], RCX
	    mov RAX, [array+RCX*8]
    

    S_DESCENDING_INNER_LOOP:				
	    inc RCX ; c++
	    cmp RCX, [size]                 
	    jz OK_DESCENDING                           
	    cmp RAX, [array+RCX*8]		     
	    jge S_DESCENDING_INNER_LOOP		
	    xchg RAX, [array+RCX*8]			
	    jmp S_DESCENDING_INNER_LOOP
        
    
    OK_DESCENDING:									
	    mov RCX, [counter]
	    mov [array+RCX*8], RAX
	    inc RCX
	    jmp S_DESCENDING_OUTTER_LOOP

        ;***************** END DESCENDING SELCTION SORT *********************

PRINT_B_OUTPUT_MSG:

       ;Clear RAX, RCX and RBX
        xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0

       ; Print the output message "The sorted array using bubble sort is:"
        mov RDI, new_line
        call printf
        mov RDI, output_b_msg
        call printf

        
        xor RAX, RAX; RAX = 0
        xor RCX, RCX; RCX = 0
        xor RBX, RBX; RBX = 0
        jmp PRINT_ARRAY
