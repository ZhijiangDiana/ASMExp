DATAS SEGMENT
	text DB 'Kamisato Ayaka'
	len DW 14
	key DW 1,1,4,5,1,4,1,9,1,9,8,1,0,0
	TEMP DW 514
	
    ;此处输入数据段代码
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
    DW 256 dup(?)
STACKS ENDS


CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;此处输入代码段代码

;输出原文    
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
    
    ;输出内容
    MOV  DL,0DH
    MOV  AH,02H
    INT  21H
    ;显示回车
    MOV  DL,0AH
    MOV  AH,02H
    INT  21H
    ;显示换行符
    
    
;输出密文
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
	
;输出加密    
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
    
    ;输出内容
    MOV  DL,0DH
    MOV  AH,02H
    INT  21H
    ;显示回车
    MOV  DL,0AH
    MOV  AH,02H
    INT  21H
    ;显示换行符
    
;解密
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
	
;输出译文    
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
    
    ;输出内容
    MOV  DL,0DH
    MOV  AH,02H
    INT  21H
    ;显示回车
    MOV  DL,0AH
    MOV  AH,02H
    INT  21H
    ;显示换行符
	
;程序终止	
    MOV AH,4CH
    INT 21H

CODES ENDS
    END START

