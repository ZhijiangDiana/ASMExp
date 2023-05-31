DATAS SEGMENT
    A DW 114 
    B DW 514
    D DW 1919
    E DW 810
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    MOV AX,A
    ADD AX,A
    ;此时AX没有溢出
    ;此时AX没有进位
    MUL D
    ;此时AX溢出
    ;此时AX进位
    
    MOV AX,A
    ADD AX,A
    ;此时AX是正
    SUB AX,B
    ;此时AX是负
    
    MOV AX,0
    ADD AX,A
    ;此时AX非0
    SUB AX,A
    ;此时AX为0

    
    
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
