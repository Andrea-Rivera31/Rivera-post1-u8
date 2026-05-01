; post1d.asm - Comparación con REPE CMPSB
ORG 100h

section .data
    cad1   db "NASM x86", 0
    cad2   db "NASM x86", 0
    cad3   db "NASM ARM", 0
    msgIg  db "Iguales.$"
    msgDif db "Diferentes.$"
    crlf   db 0Dh, 0Ah, "$"

section .text
start:
    mov ax, ds
    mov es, ax

    ; --- Caso 1: Iguales (cad1 vs cad2) ---
    mov si, cad1
    mov di, cad2
    mov cx, 8           ; Comparar 8 caracteres
    cld
    repe cmpsb          ; Mientras sean iguales (ZF=1)
    je .esIgual1        ; Si al final ZF=1, son iguales
    
    mov dx, msgDif
    jmp .imp1
.esIgual1:
    mov dx, msgIg
.imp1:
    mov ah, 09h
    int 21h
    mov dx, crlf
    int 21h

    ; --- Caso 2: Diferentes (cad1 vs cad3) ---
    mov si, cad1
    mov di, cad3
    mov cx, 8
    cld
    repe cmpsb
    je .esIgual2
    
    mov dx, msgDif
    jmp .imp2
.esIgual2:
    mov dx, msgIg
.imp2:
    mov ah, 09h
    int 21h

    ; Salir
    mov dx, crlf
    int 21h
    mov ah, 4Ch
    int 21h