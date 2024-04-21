section .data
hmsg   db 10,"enter 4 digit hex number::"
hmsg_len equ $-hmsg
ebmsg db 10, "the equivalent BCD Number is::"
ebmsg_len equ $-ebmsg
ermsg db 10,"INVALID NUMBER INPUT",10
ermsg_len equ $-ermsg

section .bss
buf resb 5
char_ans resb 1
ans resw 1

%macro print 2
MOV RAX,1
MOV RDI,1
MOV RSI,%1
MOV RDX,%2
syscall
%endmacro

%macro Read 2
MOV RAX,0
MOV RDI,0
MOV RSI,%1
MOV RDX,%2
syscall
%endmacro

%macro Exit 0
MOV RAX,60
MOV RDI,0
syscall
%endmacro

section .text
global _start
_start:
call HEX_BCD
Exit

HEX_BCD:
print hmsg, hmsg_len
call Accept
mov ax,bx
mov bx,10
xor bp,bp

back: 
xor dx,dx
div bx
push dx
inc bp
cmp ax,0
jne back
print ebmsg,ebmsg_len

back1: 
pop dx
add dl,30h
mov [char_ans],dl
print char_ans,1
dec bp
jnz back1
ret


Accept:
Read buf ,5
mov RCX,4
mov RSI,buf
xor BX,BX

cnt:
SHL Bx,4
mov AL,[RSI]
cmp AL,'0'
JB error
cmp Al,'9'
JBE sub30
cmp Al,'F'
JBE sub37
cmp Al,'a'
JB error
cmp AL,'F'
JBE sub57

error:
print ermsg,ermsg_len
Exit

sub57:
  sub al ,20h

sub37:
   sub al,07h
sub30:
 sub al,30h

 ADD BX ,AX
 inc RSI
 dec RCX
 jnz cnt
 ret


















