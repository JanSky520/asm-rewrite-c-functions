section .data
    msg db "my name is %s. my age is %d. '%c' ascii is 97.", 10, 0

    test_str db "JanSky", 0
    test_int dq 27
    test_char db 'a'

section .bss

section .text
    extern print
    global main

    main:
        push rbp
        mov rbp, rsp

        mov rdi, msg
        mov rsi, test_str
        mov rdx, [test_int]
        mov rcx, test_char
        call print

        leave
        ret