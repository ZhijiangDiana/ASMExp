DATAS SEGMENT
    as db 10H,20H,30H,40H,50H
    ad db 5 dup(?)
    avg db 0
    min db 127
    LEN DW 5
    ;此处输入数据段代码  
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
;复制AS到AD，同时求AVG
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
    
    
     
;寻找最小值
    mov cx,LEN
    MOV SI,0
L2:
	mov AL,as[si]
	CMP AL,MIN
	JL L3
	JMP L4
L3: ;找到更小值
	MOV AH,AS[SI]
	MOV MIN,AH
L4: ;没找到更小值
	INC SI
	LOOP L2
     
     
    
;向右移动两位
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









