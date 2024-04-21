section .data
msg db 10,"enter the string:"
msg_len equ $-msg
smsg db 10,10,"length of string :"
smsg_len equ $-smsg

section .bss
string resb 50
stringl equ $-string
count resb 1
char_ans resb 2

%macro Print 2
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
  Print msg,msg_len
  Read string , stringl
  MOV[count], RAX

  Print smsg,smsg_len
  MOV RAX,[count]
  call display
  Exit

  display:
  MOV RBX,10
  MOV RCX,2
  MOV RSI,char_ans+1

  cnt:
  MOV RDX,0
  div RBX
  cmp dl,09h
  jbe add30
  add dl,07h

  add30:
  add dl ,30h
  MOV [RSI],dl
  dec RSI
  dec RCX
  jnz cnt
  Print char_ans,2
  ret
  














