%IFNDEF NASM_ADVANCED_MACROSES32_NASM
%define NASM_ADVANCED_MACROSES32_NASM
struc VAR_TYPES_ENUM
    .U_Char  resb 0
    .uint8_t resb 0
    .uint8   resb 1
    
    .sint8   resb 0
    .sint8_t resb 0
    .S_Char  resb 1

    .uint16     resb 0    
    .U_ShortInt resb 0
    .uint16_t   resb 1

    .sint16     resb 0
    .sint16_t   resb 0
    .S_ShortInt resb 1

    .U_LongInt resb 0

    .U_int      resb 0
    .uint32     resb 0
    .uint32_t   resb 1


    .S_LongInt  resb 0

    .S_int      resb 0
    .sint32     resb 0
    .sint32_t   resb 1

    .U_LongLongInt resb 0
    .uint64        resb 0
    .uint64_t      resb 1

    .S_LongLongInt resb 0
    .sint64        resb 0
    .sint64_t      resb 1
endstruc

%assign DEBUG_VAR_TYPES_ENUM_TEST VAR_TYPES_ENUM.sint64
;%warning SHowing VAR_TYPES ENUM Index : DEBUG_VAR_TYPES_ENUM_TEST


;%include "NASM_default_macroses.nasm"






%macro IF_BOOL_START 1
    %push IF
    test  %1, -1
    jz    %$IF_NOT  
%endmacro


%macro ELSE 0
    %ifctx IF
        %repl ELSE
        jmp   %$IF_END
        %$IF_NOT:
    %else
        %error there is supposed to be if before else
    %endif
%endmacro


%macro IF_BOOL_END 0
    %ifctx IF
        %$IF_NOT:
        %pop
    %elifctx ELSE
        %$IF_END:
        %pop
    %else
        %error expected something like IF or ELSE before IF_BOOL_END
    %endif
%endmacro






%macro FOR_LOOP_START 3
%push FOR_START_CONTEXT
    %define Counter_VAR %1
    %define Start_NUM %2
    %define End_NUM %3

    %if   Start_NUM = 0
        xor   Counter_VAR, Counter_VAR
    %else
        mov   Counter_VAR, Start_NUM
    %endif
    %$FOR_START:
    cmp Counter_VAR, End_NUM
    je    %$FOR_END

    %if Start_NUM>End_NUM
        dec   Counter_VAR
    %else
        inc   Counter_VAR
    %endif
%endmacro

%macro FOR_LOOP_END 0
    %ifnctx FOR_START_CONTEXT
        %fatal Expected FOR_LOOP_START before FOR_LOOP_END
    %endif

    jmp   %$FOR_START
    %$FOR_END:
%pop
%endmacro

%macro FOR_LOOP_BREAK 0
    %ifnctx FOR_START_CONTEXT
        %error Cant break when no for loop
    %endif
    jmp   %$FOR_END
%endmacro

%macro FOR_LOOP_BREAK_COND_JMP 1
    %ifnctx FOR_START_CONTEXT
        %error Cant break when no for loop
    %endif
    j%+1 %$FOR_END
%endmacro





%macro CASE_MOD256_START 1
    %push CASE_MOD256_START_CONTEXT
    %assign CASE_MOD256_CASES_AMOUNT 0
    %define THE_ARGUMENT_TO_CHECK %1
%endmacro

%macro CASE_MOD256 1
    %ifnctx CASE_MOD256_START_CONTEXT
        %error cant make case when no case start
    %endif
    %if %1>255
        %error dont support cases above 255
    %endif


    %xdefine CASE_INDEX %1

    jmp   %$CASE_MOD256_LABEL_ABSOLUTE_END
    %define CASE_MOD256_INDEX_EXIST_%[CASE_INDEX]
    %$CASE_MOD256_LABEL_%+CASE_INDEX

    %assign CASE_MOD256_CASES_AMOUNT CASE_MOD256_CASES_AMOUNT+1
%endmacro

%macro CASE_MOD256_DEFAULT 0
    %ifnctx CASE_MOD256_START_CONTEXT
        %error cant make case when no case start
    %endif
    %define CASE_MOD256_DEFAULT_CASE_EXISTS
    jmp   CASE_MOD256_LABEL_ABSOLUTE_END
    %assign CASE_MOD256_CASES_AMOUNT CASE_MOD256_CASES_AMOUNT+1
    %$CASE_MOD256_LABEL_DEFAULT:
%endmacro

%macro CASE_MOD256_BREAK 0
    %ifnctx CASE_MOD256_START_CONTEXT
        %error cant break out of case when case didnt start
    %endif
    jmp   %$CASE_MOD256_LABEL_ABSOLUTE_END
%endmacro

%macro CASE_MOD256_END 0
    %ifnctx CASE_MOD256_START_CONTEXT
        %error cant end case when no case start 
    %endif
    jmp   %$CASE_MOD256_LABEL_ABSOLUTE_END

    %$CASE_MOD256_LABEL_MAIN_JUMP_CODE:
    %if CASE_MOD256_CASES_AMOUNT = 0
        jmp   %$CASE_MOD256_LABEL_ABSOLUTE_END
    %elif CASE_MOD256_CASES_AMOUNT = 1
        %ifdef CASE_MOD256_DEFAULT_CASE_EXISTS
            jmp   %$CASE_MOD256_LABEL_DEFAULT
        %else
            jmp   %$CASE_MOD256_LABEL_ABSOLUTE_END
        %endif
    %else
        push  AX_PTRSIZE
        mov   AX_PTRSIZE, 

        %assign JMP_TABLE_ITERATOR 0
        %$CASE_MOD256_LABEL_JUMP_TABLE
        %rep 256
            %ifdef CASE_MOD256_INDEX_EXIST_%[JMP_TABLE_ITERATOR]
                DEFINE_PTR %$CASE_MOD256_LABEL_%+JMP_TABLE_ITERATOR
            %elifdef CASE_MOD256_DEFAULT_CASE_EXISTS
                DEFINE_PTR %$CASE_MOD256_LABEL_DEFAULT
            %else
                DEFINE_PTR %$CASE_MOD256_LABEL_ABSOLUTE_END
            %endif

            %assign JMP_TABLE_ITERATOR JMP_TABLE_ITERATOR+1
        %endrep
    %endif
    %$CASE_MOD256_LABEL_ABSOLUTE_END:
    %pop
%endmacro





%endif




%if 0
%define i type

%define CASE_MOD256_INDEX_%[i]_EXIST 255

%warning CASE_MOD256_INDEX_type_EXIST
dd CASE_MOD256_INDEX_type_EXIST

JMP_TABLE:
    %assign JMP_TABLE_ITERATOR 0
    %rep 256
        %ifdef CASE_MOD256_INDEX_EXIST_%[JMP_TABLE_ITERATOR]
            dd CASE_MOD256_LABEL_%+JMP_TABLE_ITERATOR
        %endif
    %endrep
%endif