section .data
    msg db "S-block before transfer: ",10,10
    msg_len equ $-msg

    msg1 db "D-block before transfer: ",10,10
    msg_len1 equ $-msg1

    smsg db "S-block after transfer: ",10,10
    smsg_len equ $-smsg

    smsg1 db "D-block after transfer: ",10,10
    smsg_len1 equ $-smsg1

    space db "",10
    
    sblock db 10h,20h,30h,40h,50h
    dblock db 0h,0h,0h,0h,0h
        
section .bss
    char_ans resb 2
    
    %macro print 2 
        mov rax,1
        mov rdi,1
        mov rsi,%1
        mov rdx,%2
        syscall
    %endmacro

    %macro read 2 
        mov rax,0
        mov rdi,0
        mov rsi,%1
        mov rdx,%2
        syscall
    %endmacro

    %macro exit 0 
        mov rax,60
        mov rdi,0
        syscall
    %endmacro

section .text
    global _start

_start:
    print msg,msg_len
    mov rsi,sblock
    call displayBlock 

    print msg1,msg_len1
    mov rsi,dblock-2
    call displayBlock

    call blockTransfer

    print smsg,smsg_len
    mov rsi,sblock
    call displayBlock

    print smsg1,smsg_len1
    mov rsi,dblock-2
    call displayBlock

exit

blockTransfer:
    mov rsi,sblock+4
    mov rdi,dblock+2
    mov rcx,5

    nextBlock:
        mov al,[rsi]
        mov [rdi],al
        dec rsi
        dec rdi 
        dec rcx 
        jnz nextBlock
        ret 

displayBlock:
    mov rbp,5

next:   
    mov rax,[rsi]
    push rsi 
    call display
    print space,1
    pop rsi 
    inc rsi 
    dec rbp 
    jnz next 
ret

display:
mov rbx ,16
mov rcx,5
mov rsi ,char_ans+1

cnt:
mov rdx,0
div rbx
cmp dl,09h
jbe add30
add dl,07h

add30:
add dl,30h
mov [rsi],dl
dec rsi
dec rcx
jnz cnt
print char_ans,2
ret






