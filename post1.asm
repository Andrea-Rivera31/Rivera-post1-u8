; post1.asm - Copia optimizada con MOVSW y MOVSB
ORG 100h

section .data
    origen  db "HOLA, MUNDO!", 0   ; 13 bytes en total
    destino db 13 dup(0)
    msgCop  db "Copiado: $"
    crlf    db 0Dh, 0Ah, "$"

section .text
start:
    ; Configurar ES = DS para operaciones de cadena
    mov ax, ds
    mov es, ax

    ; Preparar punteros y contador
    mov si, origen      ; Fuente (Source Index)
    mov di, destino     ; Destino (Destination Index)
    mov cx, 13          ; Longitud total
    
    cld                 ; DF=0: Procesar hacia adelante

    ; Lógica optimizada
    mov ax, cx          ; Guardar longitud original en AX
    shr cx, 1           ; CX / 2 (Número de words)
    rep movsw           ; Copia 6 words (12 bytes)

    and ax, 1           ; Verificar si quedó un byte impar
    jz .mostrar         ; Si es 0 (par), saltar
    movsb               ; Si es 1 (impar), copiar el byte 13

.mostrar:
    ; Imprimir mensaje de confirmacion
    mov ah, 09h
    mov dx, msgCop
    int 21h

    ; Imprimir la cadena copiada
    mov dx, destino
    int 21h

    mov dx, crlf
    int 21h

    ; Finalizar programa
    mov ah, 4Ch
    xor al, al
    int 21h