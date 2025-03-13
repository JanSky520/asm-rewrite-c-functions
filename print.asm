section .bss
    buffer resb 20    ;Reserve 20 bytes of space to store arbitrary data in 64-bit mode.

section .text
    global print

    print:
        push rbp
        mov rbp, rsp    ;Function prologue, the beginning of a function.

        push r12
        push r13
        push r14
        push r15
        push rbx    ;Push the registers used in this function onto the stack to prevent data loss.

        push rcx
        push rdx

        mov r12, rdi    ;
        mov r13, rsi    ;
        mov r15, 1    ;

        print_start:
            cmp byte [r12], 0
            je exit
            cmp byte [r12], '%'
            je print_char

        printf:
            mov al, byte [r12]
            mov [buffer], al
            mov rsi, buffer
            mov rdx, 1
            mov rax, 1
            mov rdi, 1
            syscall
            inc r12
            jmp print_start

        print_char:
            mov r14, r12
            inc r14
            cmp byte [r14], 'd'
            je print_int
            cmp byte [r14], 'c'
            je print_str_char
            cmp byte [r14], 's'
            je print_str_char
            jmp printf

        print_int:
            inc r15
            test r13, r13
            jns print_int_postive
            neg r13
            mov rax, 1
            mov rdi, 1
            mov rdx, 1
            mov byte [rsi], '-'
            syscall
            print_int_postive:
                mov rdi, buffer+19
                mov byte [rdi], 0
                mov rax, r13
                mov rbx, 10
                mov rcx, 0
            print_int_switch:
                dec rdi
                xor rdx, rdx
                div rbx
                inc rcx
                add dl, '0'
                mov byte [rdi], dl
                test rax, rax
                jnz print_int_switch
            mov rdx, rcx
            mov rsi, rdi
            mov rax, 1
            mov rdi, 1
            syscall
            add r12, 2
            cmp r15, 2
            je printf_second
            cmp r15, 3
            je printf_third
            jmp print_start

        print_str_char:
            inc r15
            mov rdi, r13
            call print
            add r12, 2
            cmp r15, 2
            je printf_second
            cmp r15, 3
            je printf_third
            jmp print_start

        printf_second:
            pop r13
            jmp print_start
        printf_third:
            pop r13
            jmp print_start

        exit:
            cmp r15, 1
            je exit_first
            cmp r15, 2
            je exit_second
            cmp r15, 3
            je exit_third

            exit_first:
                pop rdx
            exit_second:
                pop rcx
            exit_third:
                pop rbx
                pop r15
                pop r14
                pop r13
                pop r12
            leave
            ret