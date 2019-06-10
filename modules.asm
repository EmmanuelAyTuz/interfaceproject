;[1] Operaciones matemáticas
;##########################################
;Peticion
QUERYNUM1 PROC NEAR
    LOCATION 0, 7, 28
    STRING TNUMBER1 
    READNUM
    SUB AL, 30H
    MOV TMP1, AL
    
    RET
QUERYNUM1 ENDP

QUERYNUM2 PROC NEAR
    LOCATION 0, 9, 28
    STRING TNUMBER2 
    READNUM
    SUB AL, 30H
    MOV TMP2, AL
        
    RET
QUERYNUM2 ENDP

REGISTER PROC NEAR
    MOV AH, 0                              
    MOV AL, TMP1
    MOV BL, TMP2
REGISTER ENDP

;Impresion
PRINTNUM PROC NEAR
    ADD AL, 30H
    ADD AH, 30H
    MOV TMP1, AH
    MOV TMP2, AL
    
    LOCATION 0, 11, 28;Macro
    STRING TRESULT;Macro
    NUMBER TMP1;Macro
    NUMBER TMP2;Macro 
    
    RET
PRINTNUM ENDP

;Suma
ADDITION PROC NEAR
     CALL QUERYNUM1
     CALL QUERYNUM2
     CALL REGISTER
     
     ADD AL, BL;Operacion
     AAA;Ajuste
     
     CALL PRINTNUM
     
     RET
ADDITION ENDP

;Resta
SUBTRACTION PROC NEAR
     CALL QUERYNUM1
     CALL QUERYNUM2
     CALL REGISTER
     
     SUB AL, BL;Operacion
     AAS;Ajuste
     
     CALL PRINTNUM
     
     RET
SUBTRACTION ENDP

;Multiplicacion
MULTIPLICATION PROC NEAR
     CALL QUERYNUM1
     CALL QUERYNUM2
     CALL REGISTER
     
     MUL BL;Operacion
     AAM;Ajuste
     
     CALL PRINTNUM
     
     RET
MULTIPLICATION ENDP

;Division
DIVISION PROC NEAR
    CALL QUERYNUM1
    CALL QUERYNUM2
    CALL REGISTER
    
    DIV BL;Operacion
    
    ;Especial
    ADD AL, 30H
    ADD AH, 30H
    MOV TMP1, AH
    MOV TMP2, AL
    
    LOCATION 0, 11, 28;Macro
    STRING TRESULT;Macro
    NUMBER TMP2;Macro
    
    LOCATION 0, 12, 28;Macro
    STRING TMOD;Macro
    NUMBER TMP1;Macro
    
    RET
DIVISION ENDP

;Factorial
FACTORIAL PROC NEAR
    ;Maximo 7
    CMP BX, 1
    JE L1
    PUSH BX
    DEC BX
    CALL FACTORIAL
    POP BX
    MUL BX
    
    L1:
        RET
FACTORIAL ENDP



;[2] Operaciones con cadenas
;##########################################
;Alfabeto
ALFA PROC NEAR
    MOV CX, 26;Cantidad
       ALFA1:
        STRING INITALFA;Macro
        INC INITALFA;Incremento de 1
        STRING SPACE;Espacio
       LOOP ALFA1
    MOV INITALFA, [65, "$"];Asignacion
 
    RET
ALFA ENDP

;Hexadecimal
HEXA PROC NEAR
    MOV CX, 10;Cantidad
       HEXA1:
        STRING INITNUM;Macro
        INC INITNUM;Incremento de 1
        STRING SPACE;Espacio 
       LOOP HEXA1
    MOV INITNUM, [48, "$"];Asignacion
    
    MOV CX, 6;Cantidad
       HEXA2:
        STRING INITALFA;Macro
        INC INITALFA;Incremento de 1
        STRING SPACE;Espacio
       LOOP HEXA2
    MOV INITALFA, [65, "$"];Asignacion
    
    RET
HEXA ENDP

;Cien numeros
HUND PROC NEAR
    MOV CX, 100;Cantidad
       
       HUND1:
        MOV AL, INITHUND; 0           
        AAM;Ajuste como MUL     
        MOV TMP3, AL
        
        MOV AL, AH        
        AAM;Ajuste como MUL        
        MOV TMP2, AL
        
        MOV AL, AH       
        AAM;Ajuste como MUL
        MOV TMP1, AL
        
        ;Impresion c/digito
        MOV DL, TMP1
        ADD DL, 48;Ajuste
        MOV AH, 02H
        INT 21H
      
        MOV DL, TMP2
        ADD DL, 48;Ajuste
        MOV AH, 02H
        INT 21H
   
        MOV DL, TMP3
        ADD DL, 48;Ajuste
        MOV AH, 02H
        INT 21H
        
        STRING SPACE;Espacio
        
        INC INITHUND;Incremento de 1 
         
       LOOP HUND1    
HUND ENDP

 
 
;[3] Operaciones con numeros
;##########################################
;Numero par, impar o neutro
EVEODDNEU PROC NEAR
    CALL QUERYNUM1
    INT 21H
    
    MOV AL, 30H
    MOV AH, TMP1
    MOV BL, TMP1
    
    CMP BL, "1"
    
    JP JEVEN
    JNP JODD
    JZ JNEUTRO
    
    JEVEN:
        LOCATION 0, 13, 28;Macro
        STRING EVEN;Macro
        JMP PREXIT2
    JODD:
        LOCATION 0, 13, 28;Macro
        STRING ODD;Macro
        JMP PREXIT2
    JNEUTRO:
    LOCATION 0, 13, 28;Macro
        STRING NEUTRO;Macro
        JMP PREXIT2
    
    RET
EVEODDNEU ENDP

;Numero positivo, negativo o cero
POSNEGZE PROC NEAR
    CALL QUERYNUM1
    INT 21H
    
    MOV AL, 30H
    MOV AH, TMP1
    MOV BL, TMP1
    
    CMP BL, "0"
    JE JZERO  
    JG JPOSITIVE
    JL JNEGATIVE
    
    JPOSITIVE:
        LOCATION 0, 13, 28;Macro
        STRING POSITIVE;Macro
        JMP PREXIT2
    
    JNEGATIVE:  
        LOCATION 0, 13, 28;Macro
        STRING NEGATIVE;Macro
        JMP PREXIT2 
        
    JZERO:
        LOCATION 0, 13, 28;Macro
        STRING ZERO;Macro
        JMP PREXIT2
            
    RET
POSNEGZE ENDP



;[4] Presentacion de figuras
;##########################################
;Rectangulo
RECTANGLE PROC NEAR
    LOCATION 0, 5, 21;Macro
    STRINGLOOP 36, HORIZ;Macro  
    RLP1: 
        MOV AH,09H
        INT 21H
    LOOP RLP1 
    
   
    LOCATION 0, 15, 21;Macro 
    STRINGLOOP 36, HORIZ;Macro    
    RLP2: 
        MOV AH,09H
        INT 21H
    LOOP RLP2
    
    
    LOCATION 0, 6, 21;Macro    
    STRINGLOOP 9, VERTI;Macro   
    RLP3: 
        MOV AH,09H
        INT 21H
    LOOP RLP3
    
    
    LOCATION 0, 6, 56;Macro    
    STRINGLOOP 9, VERTI;Macro  
    RLP4: 
        MOV AH,09H
        INT 21H
    LOOP RLP4
    
    RET
RECTANGLE ENDP

;Triangulo
TRIANGLE PROC NEAR
    LOCATION 0, 06H, 18H;Macro    
    STRINGLOOP 16, MSJ2;Macro
      
    TLP1: 
        MOV AH,09H
        INT 21H
    LOOP TLP1  
        

    LOCATION 0, 07H, 35H;Macro
    STRINGLOOP 15, MSJ3;Macro 
    TLP2: 
        MOV AH,09H
        INT 21H
    LOOP TLP2  
   

    LOCATION 0, 07H, 19H;Macro     
    STRINGLOOP 15, MSJ4;Macro    
    TLP3: 
        MOV AH,09H
        INT 21H
    LOOP TLP3
    
    RET
TRIANGLE ENDP

;Rombo
RHOMBUS PROC NEAR
    LOCATION 0, 0EH, 2EH;Macro
    STRINGLOOP 8, MSJ3;Macro  
    RHLP1: 
        MOV AH,09H
        INT 21H
    LOOP RHLP1 
    
   
    LOCATION 0, 0EH, 20H;Macro 
    STRINGLOOP 7, MSJ4;Macro    
    RHLP2: 
        MOV AH,09H
        INT 21H
    LOOP RHLP2
    
    
    LOCATION 0, 07H, 27H;Macro  
    STRINGLOOP 7, MSJ3;Macro   
    RHLP3: 
        MOV AH,09H
        INT 21H
    LOOP RHLP3
    
    
    LOCATION 0, 07H, 27H;Macro   
    STRINGLOOP 7, MSJ4;Macro  
    RHLP4: 
        MOV AH,09H
        INT 21H
    LOOP RHLP4
    
    RET
RHOMBUS ENDP

;Trapecio
TRAPEZE PROC NEAR
    LOCATION 0, 07H, 21H;Macro
    STRINGLOOP 8, MSJ3;Macro  
    TPLP1: 
        MOV AH,09H
        INT 21H
    LOOP TPLP1 
    
   
    LOCATION 0, 07H, 31H;Macro
    STRINGLOOP 8, MSJ4;Macro    
    TPLP2: 
        MOV AH,09H
        INT 21H
    LOOP TPLP2
    
    
    LOCATION 0, 07H, 23H;Macro 
    STRINGLOOP 8, MSJ2;Macro   
    TPLP3: 
        MOV AH,09H
        INT 21H
    LOOP TPLP3
    
    
    LOCATION 0, 0EH, 1CH;Macro  
    STRINGLOOP 15, MSJ2;Macro  
    TPLP4: 
        MOV AH,09H
        INT 21H
    LOOP TPLP4
    
    RET
TRAPEZE ENDP

;[5] Uso de puertos
;##########################################
;P. serial
;P. paralelo
;P. usb