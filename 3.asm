DATAS SEGMENT
	BUFFER DB 50, ?, 50 dup('$')
	text DB 50 DUP(?)
	len DW 114
	key DW -1,-1,4,5,1,4,1,9,1,9,8,1,0,1,1,1,1,1,1,1
	TEMP DW 514
	COL DB 0AH ;刷子颜色，0AH是原谅色
	
    ;此处输入数据段代码
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
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
    ;此处输入代码段代码


    lea dx, BUFFER          ;输入字符串
    mov ah, 0ah
    int 21h
;将字符串从缓冲区复制出来，因为BUFFER的开头两个字节是不使用的
	MOV SI,0
	MOV CX,LEN
COPY:
	MOV AH,BUFFER[SI+2]
;字符串在BUFFER中以$结尾，所以检测到$就跳出循环
	CMP AH,'$'
	JE BREAK
	MOV TEXT[SI],AH
	INC SI
	LOOP COPY
BREAK:
;将循环次数写入LEN变量，表示字符串长度
	MOV LEN,SI
	


;直接写显存法定义颜色信息
    MOV AX, 0B800H
	MOV ES, AX
	MOV DI,0
	MOV CX,3
ROW:
	MOV TEMP,CX
	MOV CX,LEN
	COLOR:
		MOV DH,COL
		MOV DIS[DI+1],DH ;存入颜色信息
		ADD DI,2
		LOOP COLOR
	ADD DI,160
	SUB DI,LEN
	SUB DI,LEN ;使DI回到下一行初始位置
	ADD COL,01H ;改变刷子颜色
	MOV CX,TEMP
	LOOP ROW


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
    
    
;计算密文
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
;输出密文    
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
    
    
;由密文计算出明文
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
	
;输出明文    
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
	
;程序终止	
    MOV AH,4CH
    INT 21H

CODES ENDS
    END START




