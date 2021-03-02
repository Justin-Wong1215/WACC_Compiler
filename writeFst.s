	.data


	msg_0:
		.word 50
		.ascii "NullReferenceError: dereference a null reference\n\0"
	msg_1:
		.word 5
		.ascii "%.*s\0"
	msg_2:
		.word 3
		.ascii "%d\0"
	msg_3:
		.word 1
		.ascii "\0"
	.text


	.global main
	main:
		PUSH {lr}
		SUB sp, sp, #8
		LDR r0, =8
		BL malloc
		MOV r4, r0
		LDR r5, =10
		LDR r0, =4
		BL malloc
		STR r5, [r0]
		STR r0, [r4, #0]
		MOV r5, #'a'
		LDR r0, =1
		BL malloc
		STRB r5, [r0]
		STR r0, [r4, #4]
		STR r4, [sp, #0]
		LDR r4, [sp, #0]
		MOV r0, r4
		BL p_check_null_pointer
		LDR r4, [r4]
		LDR r4, [r4]
		STR r4, [sp, #4]
		LDR r4, [sp, #4]
		MOV r0, r4
		BL p_print_int
		BL p_print_ln
		LDR r4, =42
		ADD r5, sp, #0
		MOV r0, r5
		BL p_check_null_pointer
		ADD r5, r5, #0
		LDR r5, [r5]
		STR r4, [r5]
		LDR r4, [sp, #0]
		BL p_check_null_pointer
		LDR r4, [r4]
		LDR r4, [r4]
		ADD r5, sp, #4
		STR r4, [r5]
		LDR r4, [sp, #4]
		MOV r0, r4
		BL p_print_int
		BL p_print_ln
		ADD sp, sp, #8
		LDR r0, =0
		POP {pc}
	p_check_null_pointer:
		PUSH {lr}
		CMP r0, #0
		LDREQ r0, =msg_0
		BLEQ p_throw_runtime_error
		POP {pc}
	p_throw_runtime_error:
		BL p_print_string
		MOV r0, #-1
		BL exit
	p_print_string:
		PUSH {lr}
		LDR r1, [r0]
		ADD r2, r0, #4
		LDR r0, =msg_1
		ADD r0, r0, #4
		BL printf
		MOV r0, #0
		BL fflush
		POP {pc}
	p_print_int:
		PUSH {lr}
		MOV r1, r0
		LDR r0, =msg_2
		ADD r0, r0, #4
		BL printf
		MOV r0, #0
		BL fflush
		POP {pc}
	p_print_ln:
		PUSH {lr}
		LDR r0, =msg_3
		ADD r0, r0, #4
		BL puts
		MOV r0, #0
		BL fflush
		POP {pc}
