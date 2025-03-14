section .bss
    buffer resb 1

section .text
    global scan

    scan:
        push rbp
        mov rbp, rsp

        push r12
        push r13
        push r14
        push r15

        mov r12, rdi
        mov r13, rsi
        xor r15, r15

        scan_start:
            cmp byte [r12], 0
            je exit
            cmp byte [r12], 'd'
            je scan_int
            cmp byte [r12], 'c'
            je scan_char
            inc r12
            jmp scan_start

        scan_int:
            inc r12
            mov r15, r13
            scan_int_start:       
                mov rax, 0
                mov rdi, 1
                mov rsi, buffer
                mov rdx, 1
                syscall
                mov al, [buffer]
                cmp al, 10
                je scan_int_exit
                mov byte [r15], al
                sub byte [r15], '0'
                inc r15
                jmp scan_int_start
            scan_int_exit:
                inc r15
                mov byte [r15], 0
                jmp scan_start

        scan_char:
            inc r12
            mov rax, 0
            mov rdi, 1
            mov rsi, r13
            mov rdx, 2
            syscall
            mov byte [r13+1], 0
            jmp scan_start

        exit:
            pop r15
            pop r14
            pop r13
            pop r12

            leave
            ret