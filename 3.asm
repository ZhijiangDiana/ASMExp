DATAS SEGMENT
	text DB 'Kamisato Ayaka'
	len DW 14
	key DW 1,1,4,5,1,4,1,9,1,9,8,1,0,0
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
    ;显示换行符
    
    
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
	ROR AL,CL
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
	ROL AL,CL
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
    ;显示换行符
	
;程序终止	
    MOV AH,4CH
    INT 21H

CODES ENDS
    END START


