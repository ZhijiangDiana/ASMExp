DATAS SEGMENT
	X DW ?
	Y DW 1
	Z DW 256
	CON DW 64
	CNT DW 0
	
    ;�˴��������ݶδ���  
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV BL,2
    ;�˴��������δ���
    
;����log2(CON)������CNT��
LOG2:
	CMP CON,1
	JE EXIT
	MOV AX,CON
	DIV BL
	MOV AH,0
	MOV CON,AX
	INC CNT
	JMP LOG2	
EXIT:


	MOV CX,CNT
	SHL Y,CL
	SHR Z,CL
	MOV AX,Y
	ADD AX,Z
	MOV X,AX
	
    
    
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START