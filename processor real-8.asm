
section .data
nline db 10,10
nline_len equ $-nline
colon db ":"
rmsg db 10,"Processor is in real mode: "
rmsg_len equ $-rmsg
pmsg db 10,"Processor is in protected mode: "
pmsg_len equ $-pmsg
gmsg db 10,"GDTR : "
gmsg_len equ $-gmsg
imsg db 10,"IDTR : "
imsg_len equ $-imsg
lmsg db 10,"LDTR : "
lmsg_len equ $-lmsg
tmsg db 10,"TR : "
tmsg_len equ $-tmsg
mmsg db 10,"MSW : "
mmsg_len equ $-mmsg

section .bss
GDTR resw 3
IDTR resw 3
LDTR resw 1
TR resw 1
MSW resw 1
char_ans resb 4

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

%macro Exit 0
mov rax,60
mov rdi,0
syscall
%endmacro

section .text
global _start
_start:
SMSW [MSW]
mov rax,[MSW]
ror rax,1
jc p_mode
Print rmsg,rmsg_len
jmp next

p_mode:
Print pmsg,pmsg_len

next:
SGDT [GDTR]
SIDT [IDTR]
SLDT [LDTR]
STR [TR]
SMSW [MSW]

Print gmsg,gmsg_len
mov ax,[GDTR+4]
call display
mov ax,[GDTR+2]
call display
Print colon,1
mov ax,[GDTR+0]
call display

Print imsg,imsg_len
mov ax,[IDTR+4]
call display
mov ax,[IDTR+2]
call display
Print colon,1
mov ax,[IDTR+0]
call display

Print lmsg,lmsg_len
mov ax,[LDTR]
call display

Print tmsg,tmsg_len
mov ax,[TR]
call display

Print mmsg,mmsg_len
mov ax,[MSW]
call display
Print nline,nline_len
Exit

display:
mov rbx,16
mov rcx,2
mov rsi,char_ans+1

cnt:
xor rdx,rdx
div rbx
cmp dl,09h
jbe add30
add dl,07h

add30:
add dl,30h
mov[rsi],dl
dec rsi
dec rcx
jnz cnt
Print char_ans,4
ret











