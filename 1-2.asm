DATAS SEGMENT
    A DW 114 
    B DW 514
    D DW 1919
    E DW 810
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    MOV AX,A
    ADD AX,A
    ;��ʱAXû�����
    ;��ʱAXû�н�λ
    MUL D
    ;��ʱAX���
    ;��ʱAX��λ
    
    MOV AX,A
    ADD AX,A
    ;��ʱAX����
    SUB AX,B
    ;��ʱAX�Ǹ�
    
    MOV AX,0
    ADD AX,A
    ;��ʱAX��0
    SUB AX,A
    ;��ʱAXΪ0

    
    
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
