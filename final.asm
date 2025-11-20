.model small
.stack 100h

.data
password db 'password' ; 8-character predefined password
len equ 8 ; Length of the password
msg1 db 10,13,'Enter your 8-character password: $' ; Prompt message
msg2 db 10,13,'Correct Password!$' ; Success message
msg3 db 10,13,'Incorrect Password, Please try again! $' ; Failure message
msg4 db 10,13,'You have been locked out! $' ; Lockout message
correct_msg db 10,13,'Correct characters: $' ; Message for correct characters count
inst db 8 dup(0) ; Buffer to store user input
correct_chars db 0 ; Counter for correct characters
attempts db 3 ; Number of attempts allowed
menu db 10,13,'1. Attempt Password Validation$',10,13,'$' ; Menu option 1
menu2 db 10,13,'2. Exit$',10,13,'$' ; Menu option 2
choice db 10,13,'Choose an option (1 or 2): $' ; Prompt for menu choice
invalid_choice db 10,13,'Invalid choice, please try again. $' ; Invalid menu choice message
welcome_msg db 10,13,'Welcome to Simple Password Validation$',10,13,'$' ; Welcome message

.code
start:
    mov ax, @data
    mov ds, ax ; Initialize data segment

main_menu:
    ; Display the welcome message
    lea dx, welcome_msg
    mov ah, 09h
    int 21h

    ; Display the menu
    lea dx, menu
    mov ah, 09h
    int 21h
    lea dx, menu2
    mov ah, 09h
    int 21h
    lea dx, choice
    mov ah, 09h
    int 21h

    ; Read user choice
    mov ah, 01h
    int 21h
    sub al, '0' ; Convert ASCII to number
    cmp al, 1
    je retry
    cmp al, 2
    je finish
    jmp invalid_selection

invalid_selection:
    lea dx, invalid_choice
    mov ah, 09h
    int 21h
    jmp main_menu

retry:
    ; Display the password prompt
    lea dx, msg1
    mov ah, 09h
    int 21h

    ; Clear previous input
    lea di, inst
    mov cx, len
    mov al, 0
    rep stosb

    mov si, 0
    ; Read password input
read_input:
    mov ah, 01h  ; Use AH=01h to read character without echo
    int 21h
    cmp al, 0dh  ; Check for Enter key
    je process_input
    cmp al, 08h  ; Check for Backspace key
    je backspace
    cmp al, 20h  ; Check for printable character
    jb invalid_char
    cmp al, 7Eh
    ja invalid_char
    mov [inst + si], al
    inc si
    cmp si, len  ; Ensure 8 characters are entered
    jne read_input

process_input:
    ; If Enter key is hit before entering 8 characters, wait for more input
    cmp si, len
    jne retry

    mov bx, 0
    mov cx, len
    mov correct_chars, 0

check:
    mov al, [inst + bx]
    mov dl, [password + bx]
    cmp al, dl
    jne next_char
    inc correct_chars

next_char:
    inc bx
    cmp bx, len
    jl check

    ; Check if the password is correct
    cmp correct_chars, len
    je correct

    ; Display number of correct characters
    lea dx, correct_msg
    mov ah, 09h
    int 21h
    mov dl, '0'
    add dl, correct_chars
    mov ah, 02h
    int 21h

    ; Display failure message
    lea dx, msg3
    mov ah, 09h
    int 21h

    ; Newline for formatting
    mov ah, 02h
    mov dl, 10
    int 21h
    mov dl, 13
    int 21h

    ; Retry if attempts are left
    dec attempts
    cmp attempts, 0
    je lockout
    jmp retry

correct:
    lea dx, msg2
    mov ah, 09h
    int 21h
    jmp finish

lockout:
    lea dx, msg4
    mov ah, 09h
    int 21h

finish:
    mov ah, 4ch
    int 21h ; Terminate the program

invalid_char:
    ; Handle invalid character
    lea dx, invalid_choice
    mov ah, 09h
    int 21h
    jmp retry

backspace:
    ; Handle backspace
    dec si
    cmp si, 0
    jl retry
    lea dx, invalid_choice
    mov ah, 09h
    int 21h
    jmp read_input

end start