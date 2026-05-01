; post1c.asm - Búsqueda con REPNE SCASB
ORG 100h

section .data
    cadena  db "Arquitectura de Computadores", 0
    longCad equ 29      ; Longitud sin el nulo
    msgHall db "Hallado en posicion: $"
    msgNoH  db "No encontrado.$"
    crlf    db 0Dh, 0Ah, "$"

section .text
start:
    mov ax, ds
    mov es, ax

    mov di, cadena      ; Apuntar al inicio de la cadena
    mov al, "d"         ; Carácter a buscar
    mov cx, longCad     ; Límite de búsqueda
    
    cld
    repne scasb         ; Repetir mientras NO sea igual (ZF=0)
    jne .noHallado      ; Si termina y ZF=0, no hubo coincidencia

    ; Calcular posición (DI actual - inicio - 1)
    mov bx, di
    sub bx, cadena
    dec bx              ; Ajustar índice base-0

    ; Mostrar mensaje de éxito
    mov ah, 09h
    mov dx, msgHall
    int 21h

    ; Imprimir el dígito de la posición (simplificado para 0-9)
    mov dl, bl
    add dl, 30h         ; Convertir a ASCII
    mov ah, 02h
    int 21h
    jmp .fin

.noHallado:
    mov ah, 09h
    mov dx, msgNoH
    int 21h

.fin:
    mov dx, crlf
    int 21h
    mov ah, 4Ch
    int 21h