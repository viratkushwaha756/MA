section .data
bmsg db 10,"Enter 5 digit BCD number :: "
bmsg_len equ $-bmsg
ehmsg db 10,"The Equivalent HEX number is :: "
ehmsg_len equ $-ehmsg

section .bss
buf resb 6
char_ans resb 4
ans resw 1

%macro Print 2
mov rax,1
mov rdi,1
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro Read 2
mov rax,0
mov rdi,0
mov rsi,%1
mov rdx,%2
syscall
%endmacro

%macro Exit  0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text
 Global _start
 _start:
 call BCD_HEX
 Exit

 BCD_HEX:
 Print bmsg,bmsg_len
 Read buf,6
 XOR ax,ax
 MOV RSI,buf
 MOV RBP,5
 MOV RBX,10

 next:
 XOR CX,CX
 mul BX
 MOV cl,[RSI]
 sub cl,30h
 add AX,CX

 inc RSI
 dec RBP
 jnz next
 MOV [ans],AX

 Print ehmsg,ehmsg_len
 MOV AX,[ans]
 call display
 ret

 display:
 MOV RSI,char_ans+3
 MOV RCX,4
 MOV RBX,16

 next_digit:
 XOR RDX,RDX
 div RBX
 cmp dl,09h
 jbe add30
 add dl,07h

add30:
add dl,30h
MOV [RSI],dl
dec RSI
dec RCX
jnz next_digit
Print char_ans,4
ret


 
 
 













































