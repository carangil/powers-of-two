org 100h
section .text

%define power  0xff
%define digits 80

start:
    mov cl,digits-1
    mov al,'0'
    mov di,str+1
    rep stosb
    mov ax, '1$'
    stosw

	mov cl,power
double:
	push cx
	mov cl, digits
	xor ax,ax
	mov di, str+digits
	mov si, di
dd:
    std
	lodsb
	sahf
	adc al,al
	aaa
	lahf
	or al,0x30

	stosb
	loop dd

	mov dx,si
	mov ah, 9
	int 0x21
    pop cx
    loop double

	ret

section .data
str:

