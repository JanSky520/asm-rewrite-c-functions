section .data
    msg1 db "my name is %s", 10, 0
    msg2 db "my age is %d", 10, 0
    msg3 db "%c ascii is 97", 10, 0

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

        mov rdi, msg1
        mov rsi, test_str
        call print

        mov rdi, msg2
        mov rsi, [test_int]
        call print

        mov rdi, msg3
        mov rsi, test_char
        call print

        leave
        ret