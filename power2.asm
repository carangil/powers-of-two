org 100h
section .text

start:
	
	mov bx, 10  ;10 digits
digitclr:
	mov byte[0x200+bx],'0'
	dec bx
	jnz digitclr
	mov dword[0x20a], 0x2431  ; digit 1 and dollar sign
	mov cx,10
double:
	mov bx, 10  ;10 digits
	xor ax,ax
dd:
	mov al,[0x200+bx]	
	sahf
	adc al,al
	aaa
	lahf
	or al,0x30
	mov [0x200+bx], al
	dec bx
	jnz dd	


	mov dx,0x200
	mov ah, 9
	int 0x21
dec cx
jnz double


	ret

section .data

