DATAS SEGMENT
	text DB 'Kamisato Ayaka'
	len DW 14
	key DW 1,1,4,5,1,4,1,9,1,9,8,1,0,0
	TEMP DW 514
	
    ;�˴��������ݶδ���
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
    DW 256 dup(?)
STACKS ENDS


CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���

;���ԭ��    
    MOV SI,OFFSET Text
    MOV CX,len
    MOV BX,0
PRIN:
	MOV AX,[SI+BX]
    MOV DL,AL
    MOV AH,02H
    INC BX
    INT 21H
    LOOP PRIN
    
    ;�������
    MOV  DL,0DH
    MOV  AH,02H
    INT  21H
    ;��ʾ�س�
    MOV  DL,0AH
    MOV  AH,02H
    INT  21H
    ;��ʾ���з�
    
    
;�������
	MOV CX,len
	MOV BX,0
	MOV SI,OFFSET TEXT
	MOV DI,OFFSET KEY
EN:
	MOV AX,[SI]
	MOV DX,[DI]
	ADD DI,2
	MOV TEMP,CX
	MOV CL,DL
	ROR AL,CL
	XCHG [SI],AX
	ADD SI,1
	ADD BX,1
	MOV CX,TEMP
	LOOP EN
	
;�������    
    MOV SI,OFFSET Text
    MOV CX,len
    MOV BX,0
PRIN1:
	MOV AX,[SI+BX]
    MOV DL,AL
    MOV AH,02H
    INC BX
    INT 21H
    LOOP PRIN1
    
    ;�������
    MOV  DL,0DH
    MOV  AH,02H
    INT  21H
    ;��ʾ�س�
    MOV  DL,0AH
    MOV  AH,02H
    INT  21H
    ;��ʾ���з�
    
;����
	MOV CX,len
	MOV BX,0
	MOV SI,OFFSET TEXT
	MOV DI,OFFSET KEY
EN2:
	MOV AX,[SI]
	MOV DX,[DI]
	ADD DI,2
	MOV TEMP,CX
	MOV CL,DL
	ROL AL,CL
	XCHG [SI],AX
	ADD SI,1
	ADD BX,1
	MOV CX,TEMP
	LOOP EN2
	
;�������    
    MOV SI,OFFSET Text
    MOV CX,len
    MOV BX,0
PRIN2:
	MOV AX,[SI+BX]
    MOV DL,AL
    MOV AH,02H
    INC BX
    INT 21H
    LOOP PRIN2
    
    ;�������
    MOV  DL,0DH
    MOV  AH,02H
    INT  21H
    ;��ʾ�س�
    MOV  DL,0AH
    MOV  AH,02H
    INT  21H
    ;��ʾ���з�
	
;������ֹ	
    MOV AH,4CH
    INT 21H

CODES ENDS
    END START
