section .bss
    buffer resb 20

section .text
    global print

    print:
        push rbp
        mov rbp, rsp
        push r12
        push r13
        push r14
        push rbx

        mov r12, rdi
        mov r13, rsi

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
            je printf_int
            cmp byte [r14], 'c'
            je printf_char
            cmp byte [r14], 's'
            je printf_str
            jmp printf

        printf_int:
            test r13, r13
            jns printf_int_postive
            neg r13
            mov rax, 1
            mov rdi, 1
            mov rdx, 1
            mov byte [rsi], '-'
            syscall
            printf_int_postive:
                mov rdi, buffer+19
                mov byte [rdi], 0
                mov rax, r13
                mov rbx, 10
                mov rcx, 0
            printf_int_switch:
                dec rdi
                xor rdx, rdx
                div rbx
                inc rcx
                add dl, '0'
                mov byte [rdi], dl
                test rax, rax
                jnz printf_int_switch
            mov rdx, rcx
            mov rsi, rdi
            mov rax, 1
            mov rdi, 1
            syscall
            add r12, 2
            jmp printf

        printf_char:
            xor rax, rax
            xor rdx, rdx
            mov rax, r13
            mov dl, al
            mov rsi, rax
            mov rax, 1
            mov rdi, 1
            mov rdx, 1
            syscall
            add r12, 2
            jmp printf

        printf_str:
            push rdi
            mov rdi, r13
            call print
            pop rdi
            add r12, 2
            jmp printf

        exit:
            pop rbx
            pop r14
            pop r13
            pop r12
            leave
            ret