DATAS SEGMENT
    as db 10H,20H,30H,40H,50H
    ad db 5 dup(?)
    avg db 0
    min db 127
    LEN DW 5
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
    
;����AS��AD��ͬʱ��AVG
    mov cx,LEN
    mov si,offset as
    mov di,offset ad
L1:
 	mov al,[si]
    mov [di],al
    inc si 
    inc di
    add dl,[si]
    loop L1
    mov al,dl
    mov ah,0
    mov BX,LEN
    div bl
    mov avg,al
    
    
     
;Ѱ����Сֵ
    mov cx,LEN
    MOV SI,0
L2:
	mov AL,as[si]
	CMP AL,MIN
	JL L3
	JMP L4
L3: ;�ҵ���Сֵ
	MOV AH,AS[SI]
	MOV MIN,AH
L4: ;û�ҵ���Сֵ
	INC SI
	LOOP L2
     
     
    
;�����ƶ���λ
	mov cx,LEN
	SUB CX,2
    MOV SI,0
    ADD SI,LEN
    DEC SI
    
    MOV AH,AS[SI]
    DEC SI
    MOV AL,AS[SI]
    DEC SI
L5:
	MOV BL,AS[SI]
	ADD SI,2
	MOV AS[SI],BL
	SUB SI,3
	LOOP L5
	MOV SI,OFFSET AS
	MOV AS[SI+1],AH
	MOV AS[SI],AL  	
	
	
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START









