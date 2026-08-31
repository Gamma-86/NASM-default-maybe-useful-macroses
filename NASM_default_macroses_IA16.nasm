;It is 16 bit, so use MS DOS
		%define S_Char int8_t
		%define U_Char uint8_t

		%define S_Short int16_t
		%define S_Short_Int int16_t
		%define U_Short uint16_t
		%define U_Short_Int uint16_t

		%define S_int   int16_t
		%define U_int   uint16_t

		%define S_Long  int32_t
		%define S_Long_Int int32_t
		%define U_Long  uint32_t
		%define U_Long_Int uint32_t

;		I guess it will be fine if we still use these guys
		%define S_LongLong int64_t
		%define S_LongLong_Int int64_t
		%define U_LongLong uint64_t
		%define U_LongLong_Int uint64_t

		%define size_t uint16_t

		%define SizeOfInt 2
		%define BitnessOfInt SizeOfInt*8

%define FREE_REG1_INTSIZE FREE_REG1_16

%define FREE_REG2_INTSIZE FREE_REG2_16

%define FREE_REG3_INTSIZE FREE_REG3_16

%define VOLATILE_REG1_INTSIZE BOLATILE_REG1_16






;DEFINING FREE REGISTERS FOR CURRENT SIZE OF POINTER
;AND SOME OTHER POINTER SIZE SPECIFIC REGISTERS(like esp, ebp)
	%define FREE_REG1_PTRSIZE FREE_REG1_16
	%define FREE_REG2_PTRSIZE FREE_REG2_16
	%define FREE_REG3_PTRSIZE FREE_REG3_16
	%define VOLATILE_REG1_PTRSIZE VOLATIVE_REG1_16

	%define AX_PTRSIZE ax
	%define BX_PTRSIZE bx
	%define CX_PTRSIZE cx
	%define DX_PTRSIZE dx
	%define SI_PTRSIZE si
	%define DI_PTRSIZE di
	%define BP_PTRSIZE bp
	%define SP_PTRSIZE sp












;DEFINING ARGUMENTS LOCATION FOR CURRENT POINTER SIZE
		%assign i 1
		%rep 10
			%define STACK_ARG%[i]_SP        [STACK_ARGX_ESP(i)]
				%define STACK_ARG1_SP8  byte[STACK_ARGX_ESP(i)]
				%define STACK_ARG1_SP16 word[STACK_ARGX_ESP(i)]

			%define STACK_ARG%[i]_SP_FAR       [STACK_ARG_ESP_FAR(i)]
				%define STACK_ARG%[i]_SP_FAR8  byte[STACK_ARG_ESP_FAR(i)]
				%define STACK_ARG%[i]_SP_FAT16 word[STACK_ARG_ESP_FAR(i)]

			%define STACK_ARG%[i]_SP_INT           [STACK_ARG_ESP_INT(i)]
				%define STACK_ARG%[i]_SP_INT8  byte[STACK_ARG_ESP_INT(i)]
				%define STACK_ARG%[i]_SP_INT16 word[STACK_ARG_ESP_INT(i)]

			%define STACK_ARG%[i]_BP           [STACK_ARGX_EBP(i)]
				%define STACK_ARG%[i]_BP8  byte[STACK_ARGX_EBP(i)]
				%define STACK_ARG%[i]_BP16 word[STACK_ARGX_EBP(i)]

			%define STACK_ARG%[i]_BP_FAR           [STACK_ARG_EBP_FAR(i)]
				%define STACK_ARG%[i]_BP_FAR8  byte[STACK_ARG_EBP_FAR(i)]
				%define STACK_ARG%[i]_BP_FAR16 word[STACK_ARG_EBP_FAR(i)]

			%define STACK_ARG%[i]_BP_INT           [STACK_ARG_EBP_INT(i)]
				%define STACK_ARG%[i]_BP_INT8  byte[STACK_ARG_EBP_INT(i)]
				%define STACK_ARG%[i]_BP_INT16 word[STACK_ARG_EBP_INT(i)]
		%endrep
		%undef i
















	%define LODS_INT lodsw
	%define STOS_INT stosw
	%define CMPS_INT cmpsw
	%define MOVS_INT movsw








%define AX_INTSIZE ax
%define BX_INTSIZE bx
%define CX_INTSIZE cx
%define DX_INTSIZE dx
%define DI_INTSIZE di
%define SI_INTSIZE si
%define BP_INTSIZE bp
%define SP_INTSIZE sp
%undef R8_INTSIZE
%undef R9_INTSIZE
%undef R10_INTISZE
%undef R11_INTSIZE
%undef R12_INTSIZE
%undef R13_INTSIZE
%undef R14_INTSIZE
%undef R15_INTSIZE
