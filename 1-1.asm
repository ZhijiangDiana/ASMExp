data segment
    X DW 0
    A DW 11
    B DW 45
    C1 DW 14
    D DW 191
data ends

stack segment
        ;input stack segment code here
stack ends

code segment
    assume cs:code,ds:data,ss:stack
start:
    mov ax,data
    mov ds,ax
    
    ;X=A*B+C1-D
    MOV AX,A
    MUL B
    ADD AX,C1
    SUB AX,D
    MOV X,AX
    
	
	
    mov ah,4ch
    int 21h
    
code ends
end start


