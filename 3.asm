DATAS SEGMENT
	BUFFER DB 50, ?, 50 dup('$')
	text DB 50 DUP(?)
	len DW 114
	key DW -1,-1,4,5,1,4,1,9,1,9,8,1,0,1,1,1,1,1,1,1
	TEMP DW 514
	COL DB 0AH ;ˢ����ɫ��0AH��ԭ��ɫ
	
    ;�˴��������ݶδ���
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
    DW 256 dup(?)
STACKS ENDS

display segment
	DIS db 14 dup(?)
display ends

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS,es:display
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���


    lea dx, BUFFER          ;�����ַ���
    mov ah, 0ah
    int 21h
;���ַ����ӻ��������Ƴ�������ΪBUFFER�Ŀ�ͷ�����ֽ��ǲ�ʹ�õ�
	MOV SI,0
	MOV CX,LEN
COPY:
	MOV AH,BUFFER[SI+2]
;�ַ�����BUFFER����$��β�����Լ�⵽$������ѭ��
	CMP AH,'$'
	JE BREAK
	MOV TEXT[SI],AH
	INC SI
	LOOP COPY
BREAK:
;��ѭ������д��LEN��������ʾ�ַ�������
	MOV LEN,SI
	


;ֱ��д�Դ淨������ɫ��Ϣ
    MOV AX, 0B800H
	MOV ES, AX
	MOV DI,0
	MOV CX,3
ROW:
	MOV TEMP,CX
	MOV CX,LEN
	COLOR:
		MOV DH,COL
		MOV DIS[DI+1],DH ;������ɫ��Ϣ
		ADD DI,2
		LOOP COLOR
	ADD DI,160
	SUB DI,LEN
	SUB DI,LEN ;ʹDI�ص���һ�г�ʼλ��
	ADD COL,01H ;�ı�ˢ����ɫ
	MOV CX,TEMP
	LOOP ROW


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
    
    
;��������
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
	
	CMP CL,0
	JL L
	JMP R
	L:
		NEG CL
		ROL AL,CL
		JMP CONTINUE
	R:
		ROR AL,CL
	CONTINUE:
		
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
    
    
;�����ļ��������
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
	
	CMP CL,0
	JL L1
	JMP R1
	L1:
		NEG CL
		ROR AL,CL
		JMP CONTINUE1
	R1:
		ROL AL,CL
	CONTINUE1:
	
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
	
;������ֹ	
    MOV AH,4CH
    INT 21H

CODES ENDS
    END START




