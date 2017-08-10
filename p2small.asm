org 100h
section .text

start:
	mov cx,848
double:
	mov di, 0xff  ;lots digits
	xor ax,ax
dd:
	mov al,[0x200+di]	
	sahf
	adc al,al
	aaa
	lahf
	mov al,0x30 ; on first iteration, clears array.  on following interations, replaced with or
	mov [0x200+di], al
	dec di
	jnz dd	


	mov dword[0x2ff], 0x240a0d31  ; digit 1 cr lf and dollar sign
	mov dx,0x200
	mov ah, 9
	int 0x21
	mov byte [ 0x111], 0x0c  ;patch mov above to 'or' to not clear
	mov byte [0x11e], 0x09 ; cause the digit 1 and dollar sign to be moved somewhere else during next interation
	loop double
	ret
