
section .data
msg1 db 10,"Welcome",10
msg1_len equ $-msg1
msg2 db 10,"Hello world using 64-bit programming!!!",10,10
msg2_len equ $-msg2

%macro print 2
MOV RAX,1
MOV RDI,1
MOV RSI,%1
mov RDX,%2
syscall
%endmacro

%macro exit 0
MOV RAX,60
MOV RDI,00
syscall
%endmacro

section .text
Global _start
_start:
print msg1,msg1_len
print msg2,msg2_len
exit

