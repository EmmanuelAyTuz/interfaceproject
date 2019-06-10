;MACROS
BACKGROUND MACRO BCOLOR, BPOINTA, BPOINTB
    MOV AH, 06H
    MOV AL, 0
    MOV BH, BCOLOR
    MOV CX, BPOINTA
    MOV DX, BPOINTB
    INT 10H
BACKGROUND ENDM

LOCATION MACRO LPAGE, LROW, LCOL
    MOV AH, 02H
    MOV BH, LPAGE
    MOV DH, LROW
    MOV DL, LCOL
    INT 10H
LOCATION ENDM

STRING MACRO SSTRING
    MOV AH, 09H
    LEA DX, SSTRING
    INT 21H
STRING ENDM

STRINGLOOP MACRO SLMANY, SLSTRING
    MOV CX, SLMANY
    LEA DX, SLSTRING
STRINGLOOP ENDM

NUMBER MACRO NSTRING
    MOV AH, 02H
    MOV DL, NSTRING
    INT 21H
NUMBER ENDM  

READKEY MACRO
    MOV AH, 00H
    INT 16H
READKEY ENDM

READNUM MACRO
    MOV AH, 01H
    INT 21H
READNUM ENDM

NEWPAGE MACRO NPPAGE
    MOV AH, 05H
    MOV AL, NPPAGE
    INT 10H
NEWPAGE ENDM

;##############################################################

;KIND MODEL 
.MODEL SMALL
 
;SEGMENT DATA
.DATA
    OPM0G DB "Ir a: $"
    OPM0E DB "Volver [S/N]: $"
    BLEFT DB "[$"
    BRIGHT DB "]$"         
    
    OPM0N6 DB "[6] Regresar al menu princial$"
    OPM0N5 DB "[5] Regresar al menu princial$"
    OPM0N4 DB "[4] Regresar al menu princial$"
    OPM0N3 DB "[3] Regresar al menu princial$"
     
    ;MENU 0 - MAIN
    OP1M0 DB "[1] Operaciones matemáticas$"
    OP2M0 DB "[2] Operaciones con cadenas$"
    OP3M0 DB "[3] Operaciones con numeros$"
    OP4M0 DB "[4] Presentacion de figuras$"
    OP5M0 DB "[5] Uso de puertos$"
    OP6M0 DB "[6] Acerca de$"
    OP7M0 DB "[7] Salir$"
    
    ;MENU 1 - OP1
    OP1M1 DB "[1] Suma de dos numeros$"
    OP2M1 DB "[2] Resta de dos numeros$"
    OP3M1 DB "[3] Multiplicacion de dos numeros$"
    OP4M1 DB "[4] Division de dos numeros$"
    OP5M1 DB "[6] Factorial de un numero$"
    
    ;MENU 2 - OP2
    OP1M2 DB "[1] Imprimir el alfabeto completo de la A a la Z$"
    OP2M2 DB "[2] Imprimir los numeros hexadecimales (0-F)$"
    OP3M2 DB "[3] Imprimir los primeros 100 numeros decimales$"
    
    ;MENU 3 - OP3
    OP1M3 DB "[1] Numero par, impar o neutro$"
    OP2M3 DB "[2] Numero positivo, negativo o cero$"
    
    
    ;MENU 4 - OP4
    OP1M4 DB "[1] Rectangulo$"
    OP2M4 DB "[2] Triangulo$"
    OP3M4 DB "[3] Rombo$"
    OP4M4 DB "[4] Trapecio$"
    
    ;MENU 5 - OP5
    OP1M5 DB "[1] Puerto serial$"
    OP2M5 DB "[2] Puerto paralelo$"
    OP3M5 DB "[3] Puerto USB$"
    
    ;OP6
    INSTITUTION DB "INSTITUTO TECNOLÓGICO SUPERIOR DE VALLADOLID$"
    TITLETEA DB "MAESTRO: "
    TEACHER DB "Antonio de Jesus Cab Balam$"
    TITLESUB DB "ASIGNATURA: $"
    SUBJECT DB "Lenguajes de Interfaz$"
    DEVS DB "DESARROLLADO POR: $"
    DEV1 DB "Emmanuel Ay Tuz$"
    DEV2 DB "Marcelino Canche Tun$"
    DEV3 DB "Luis M. Hau Cupul$"
    DEV4 DB "Hipolito Aban Noh$"
    DEV5 DB "Jose A. Cano Hau$"
    
    ;TMPS, NUMBERS & MORE
    INITALFA DB 65, "$"
    INITNUM DB 48, "$"
    INITHUND DB 1
    SPACE DB " $"
    TMP0 DW ?
    TMP1 DB ?
    TMP2 DB ?
    TMP3 DB ?
    TMP4 DB ?
    
    TNUMBER1 DB "Numero 1: $"
    TNUMBER2 DB "Numero 2: $"
    TRESULT  DB "Resultado: $"
    TMOD  DB "Residuo: $"
    
    HORIZ DB 149, "$"
    VERTI DB 149,010,08, "$"
    
    MSJ2 DB 149,032,'$'       
    MSJ3 DB 149,010,08,08,'$' 
    MSJ4 DB 149,010,'$'
    
    EVEN DB "Es par...$"
    ODD DB "Es impar...$"
    NEUTRO DB "Es neutro...$"
    
    ZERO DB "Es cero...$"
    POSITIVE DB "Es positivo...$"
    NEGATIVE DB "Es negativo...$"
    
    ERRFAC DB "Resultado grande...$"  
    
;SEGMENT CODE
.CODE
    MOV AX, @DATA
    MOV DS,AX
    
MAIN PROC FAR    
RELOAD:
    NEWPAGE 0     
    ;RED / WHITE - 0000 - 2479
    BACKGROUND 01001111B, 0000H, 184FH
    ;BLACK / WHITE 0309 - 1969
    BACKGROUND 00001111B, 0309H, 1345H
    ;TEXTS
    LOCATION 0, 5, 28
    STRING OP1M0
    LOCATION 0, 7, 28
    STRING OP2M0
    LOCATION 0, 9, 28
    STRING OP3M0
    LOCATION 0, 11, 28
    STRING OP4M0
    LOCATION 0, 13, 28
    STRING OP5M0
    LOCATION 0, 15, 28
    STRING OP6M0
    LOCATION 0, 17, 28
    STRING OP7M0
      
    LOCATION 0, 21, 28
    STRING OPM0G
    LOCATION 0, 21, 33
    STRING BLEFT
    LOCATION 0, 21, 35
    STRING BRIGHT
    
    ;MENU MAIN
    MENUMAIN:
        ;READ CHAR
        LOCATION 0, 21, 34
        READKEY
            CMP AL, "1"
                JE OP1MAIN
            CMP AL, "2"
                JE OP2MAIN
            CMP AL, "3"
                JE OP3MAIN
            CMP AL, "4"
                JE OP4MAIN
            CMP AL, "5"
                JE OP5MAIN    
            CMP AL, "6"
                JE OP6MAIN
            CMP AL, "7"
                JE ENDPROGRAM
            JMP MENUMAIN ;<-LOOP MENU
    
    OP1MAIN:
        NEWPAGE 0
        ;BLUE / WHITE - 0000 - 2479
        BACKGROUND 00011111B, 0000H, 184FH
        ;BLACK / WHITE 0309 - 1969
        BACKGROUND 00001111B, 0309H, 1345H
        ;TEXTS
        LOCATION 0, 5, 28
        STRING OP1M1
        LOCATION 0, 7, 28
        STRING OP2M1
        LOCATION 0, 9, 28
        STRING OP3M1
        LOCATION 0, 11, 28
        STRING OP4M1
        LOCATION 0, 13, 28
        STRING OP5M1
        LOCATION 0, 15, 28
        STRING OPM0N6
        
        LOCATION 0, 21, 28
        STRING OPM0G
        LOCATION 0, 21, 33
        STRING BLEFT
        LOCATION 0, 21, 35
        STRING BRIGHT
        
        ;MENU OPTION1
        MENUOPTION1:
            ;READ CHAR
            LOCATION 0, 21, 34
            READKEY
            CMP AL, "1"
                JE OP1SUB1
            CMP AL, "2"
                JE OP1SUB2
            CMP AL, "3"
                JE OP1SUB3
            CMP AL, "4"
                JE OP1SUB4
            CMP AL, "5"
                JE OP1SUB5     
            CMP AL, "6"
                JE RELOAD ;<-RELOAD MENU MAIN
            JMP MENUOPTION1 ;<-LOOP MENU OPTION 1
        
        OP1SUB1:
            NEWPAGE 0
            ;BLUE / WHITE - 0000 - 2479
            BACKGROUND 00011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 28
            STRING OP1M1
            
            ;##############  START MODULO    #############
                ;SUMA DE DOS NUMEROS
                CALL ADDITION
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP1MAIN
            
        OP1SUB2:
            NEWPAGE 0
            ;BLUE / WHITE - 0000 - 2479
            BACKGROUND 00011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 28
            STRING OP2M1
            
            ;##############  START MODULO    #############
                ;RESTA DE DOS NUMEROS
                CALL SUBTRACTION
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP1MAIN
            
        OP1SUB3:
            NEWPAGE 0
            ;BLUE / WHITE - 0000 - 2479
            BACKGROUND 00011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 28
            STRING OP3M1
            
            ;##############  START MODULO    #############
                ;MULTIPLICACION DE DOS NUMEROS
                CALL MULTIPLICATION
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP1MAIN
        OP1SUB4:
            NEWPAGE 0
            ;BLUE / WHITE - 0000 - 2479
            BACKGROUND 00011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 28
            STRING OP4M1
            
            ;##############  START MODULO    #############
                ;DIVISION DE DOS NUMEROS
                CALL DIVISION 
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP1MAIN
        OP1SUB5:
            NEWPAGE 0
            ;BLUE / WHITE - 0000 - 2479
            BACKGROUND 00011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 28
            STRING OP5M1
            
            ;##############  START MODULO    #############
                ;FACTORIAL DE UN NUMEROS
                CALL QUERYNUM1
                CMP TMP1, 7
                JG ERROR
                MOV AX, 1
                MOV BL, TMP1
                MOV BH, 0
                CALL FACTORIAL
                MOV AX, BX
                AAM
                
                ADD AL,30H

                ADD AH,30H
                
                MOV TMP1, AH
                    
                MOV TMP2, AL
                
                NUMBER TMP1
                NUMBER TMP2
                
                JMP PREXIT0
                
                ERROR:
                    LOCATION 0, 9, 28
                    STRING ERRFAC                    
            ;################  END MODULO  ################
            PREXIT0:
                LOCATION 0, 21, 34
                READKEY
                JMP OP1MAIN         
        
    OP2MAIN:
        NEWPAGE 0
        ;GREEN / WHITE - 0000 - 2479
        BACKGROUND 00101111B, 0000H, 184FH
        ;BLACK / WHITE 0309 - 1969
        BACKGROUND 00001111B, 0309H, 1345H
        ;TEXTS
        LOCATION 0, 5, 17
        STRING OP1M2
        LOCATION 0, 7, 17
        STRING OP2M2
        LOCATION 0, 9, 17
        STRING OP3M2
        LOCATION 0, 11, 17
        STRING OPM0N4
        
        LOCATION 0, 21, 28
        STRING OPM0G
        LOCATION 0, 21, 33
        STRING BLEFT
        LOCATION 0, 21, 35
        STRING BRIGHT
        
        ;MENU OPTION2
        MENUOPTION2:
            ;READ CHAR
            LOCATION 0, 21, 34
            READKEY
            CMP AL, "1"
                JE OP2SUB1
            CMP AL, "2"
                JE OP2SUB2
            CMP AL, "3"
                JE OP2SUB3     
            CMP AL, "4"
                JE RELOAD ;<-RELOAD MENU MAIN
            JMP MENUOPTION2 ;<-LOOP MENU OPTION 2
        
        OP2SUB1:
            NEWPAGE 0
            ;GREEN / WHITE - 0000 - 2479
            BACKGROUND 00101111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 17
            STRING OP1M2
            
            ;##############  START MODULO    #############
                ;IMPRIMIR DE A-Z
                LOCATION 0, 10, 17
                CALL ALFA
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP2MAIN
            
        OP2SUB2:
            NEWPAGE 0
            ;GREEN / WHITE - 0000 - 2479
            BACKGROUND 00101111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 17
            STRING OP2M2
            
            ;##############  START MODULO    #############
                ;IMPRIMIR HEXADECIMAL 0-F
                LOCATION 0, 10, 17
                CALL HEXA
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP2MAIN
            
        OP2SUB3:
            NEWPAGE 0
            ;GREEN / WHITE - 0000 - 2479
            BACKGROUND 00101111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 17
            STRING OP3M2
            
            ;##############  START MODULO    #############
                ;IMPRIMIR DE 1-100
                LOCATION 0, 10, 0
                CALL HUND
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP2MAIN;Fix bug end program
        
    OP3MAIN:
        NEWPAGE 0
        ;DARK GRAY / WHITE - 0000 - 2479
        BACKGROUND 10001111B, 0000H, 184FH
        ;BLACK / WHITE 0309 - 1969
        BACKGROUND 00001111B, 0309H, 1345H 
        ;TEXTS
        LOCATION 0, 5, 26
        STRING OP1M3
        LOCATION 0, 7, 26
        STRING OP2M3
        LOCATION 0, 9, 26
        STRING OPM0N3
        
        LOCATION 0, 21, 28
        STRING OPM0G
        LOCATION 0, 21, 33
        STRING BLEFT
        LOCATION 0, 21, 35
        STRING BRIGHT
        
        ;MENU OPTION2
        MENUOPTION3:
            ;READ CHAR
            LOCATION 0, 21, 34
            READKEY
            CMP AL, "1"
                JE OP3SUB1
            CMP AL, "2"
                JE OP3SUB2    
            CMP AL, "3"
                JE RELOAD ;<-RELOAD MENU MAIN
            JMP MENUOPTION3 ;<-LOOP MENU OPTION 3 
            
        OP3SUB1:
            NEWPAGE 0
            ;DARK GRAY / WHITE - 0000 - 2479
            BACKGROUND 10001111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP1M3
            
            ;##############  START MODULO    #############
                ;NUMERO PAR, IMPAR O NEUTRO
                CALL EVEODDNEU
            ;################  END MODULO  ################
            
            PREXIT1:
                LOCATION 0, 21, 34
                READKEY
                JMP OP3MAIN
            
        OP3SUB2:
            NEWPAGE 0
            ;DARK GRAY / WHITE - 0000 - 2479
            BACKGROUND 10001111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP2M3
            
            ;##############  START MODULO    #############
                ;NUMERO PASITIVO, NEGATIVO O CERO
                CALL POSNEGZE
            ;################  END MODULO  ################
            
            PREXIT2:
                LOCATION 0, 21, 34
                READKEY
                JMP OP3MAIN
        
    OP4MAIN:
        NEWPAGE 0
        ;LIGHT BLUE / WHITE - 0000 - 2479
        BACKGROUND 10011111B, 0000H, 184FH
        ;BLACK / WHITE 0309 - 1969
        BACKGROUND 00001111B, 0309H, 1345H
        ;TEXTS
        LOCATION 0, 5, 28
        STRING OP1M4
        LOCATION 0, 7, 28
        STRING OP2M4
        LOCATION 0, 9, 28
        STRING OP3M4
        LOCATION 0, 11, 28
        STRING OP4M4
        LOCATION 0, 13, 28
        STRING OPM0N5
        
        LOCATION 0, 21, 28
        STRING OPM0G
        LOCATION 0, 21, 33
        STRING BLEFT
        LOCATION 0, 21, 35
        STRING BRIGHT 
        
        ;MENU OPTION4
        MENUOPTION4:
            ;READ CHAR
            LOCATION 0, 21, 34
            READKEY
            CMP AL, "1"
                JE OP4SUB1
            CMP AL, "2"
                JE OP4SUB2
            CMP AL, "3"
                JE OP4SUB3
            CMP AL, "4"
                JE OP4SUB4     
            CMP AL, "5"
                JE RELOAD ;<-RELOAD MENU MAIN
            JMP MENUOPTION4 ;<-LOOP MENU OPTION 4
        
        OP4SUB1:
            NEWPAGE 0
            ;LIGHT BLUE / WHITE - 0000 - 2479
            BACKGROUND 10011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP1M4
            
            ;##############  START MODULO    #############
                ;RECTANGULO
                CALL RECTANGLE 
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP4MAIN 
        OP4SUB2:
            NEWPAGE 0
            ;LIGHT BLUE / WHITE - 0000 - 2479
            BACKGROUND 10011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP2M4
            
            ;##############  START MODULO    #############
                ;TRIANGULO
                CALL TRIANGLE
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP4MAIN
        OP4SUB3:
            NEWPAGE 0
            ;LIGHT BLUE / WHITE - 0000 - 2479
            BACKGROUND 10011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP3M4
            
            ;##############  START MODULO    #############
                ;ROMBO
                CALL RHOMBUS
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP4MAIN
        OP4SUB4:
            NEWPAGE 0
            ;LIGHT BLUE / WHITE - 0000 - 2479
            BACKGROUND 10011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP4M4
            
            ;##############  START MODULO    #############
                ;TRAPECIO
                CALL TRAPEZE
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP4MAIN
    OP5MAIN:
        NEWPAGE 0
        ;MAGENTA / WHITE - 0000 - 2479
        BACKGROUND 01011111B, 0000H, 184FH
        ;BLACK / WHITE 0309 - 1969
        BACKGROUND 00001111B, 0309H, 1345H
        ;TEXTS
        LOCATION 0, 5, 28
        STRING OP1M5
        LOCATION 0, 7, 28
        STRING OP2M5
        LOCATION 0, 9, 28
        STRING OP3M5
        LOCATION 0, 11, 28
        STRING OPM0N4
        
        LOCATION 0, 21, 28
        STRING OPM0G
        LOCATION 0, 21, 33
        STRING BLEFT
        LOCATION 0, 21, 35
        STRING BRIGHT
        
        ;MENU OPTION5
        MENUOPTION5:
            ;READ CHAR
            LOCATION 0, 21, 34
            READKEY
            CMP AL, "1"
                JE OP5SUB1
            CMP AL, "2"
                JE OP5SUB2
            CMP AL, "3"
                JE OP5SUB3
            CMP AL, "4"
                JE RELOAD ;<-RELOAD MENU MAIN
            JMP MENUOPTION5 ;<-LOOP MENU OPTION 5
        
        OP5SUB1:
            NEWPAGE 0
            ;MAGENTA / WHITE - 0000 - 2479
            BACKGROUND 01011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP1M5
            
            ;##############  START MODULO    #############
                ;PUERTO SERIAL 
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP5MAIN
        OP5SUB2:
            NEWPAGE 0
            ;MAGENTA / WHITE - 0000 - 2479
            BACKGROUND 01011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP2M5
            
            ;##############  START MODULO    #############
                ;PUERTO PARALELO
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP5MAIN
        OP5SUB3:
            NEWPAGE 0
            ;MAGENTA / WHITE - 0000 - 2479
            BACKGROUND 01011111B, 0000H, 184FH
            ;TEXTS
            LOCATION 0, 1, 26
            STRING OP3M5
            
            ;##############  START MODULO    #############
                ;PUERTO USB 
            ;################  END MODULO  ################
            
            LOCATION 0, 21, 34
            READKEY
            JMP OP5MAIN
            
    OP6MAIN:
        NEWPAGE 0
        ;LIGHT RED / WHITE - 0000 - 2479
        BACKGROUND 11001111B, 0000H, 184FH
        ;BLACK / WHITE 0309 - 1969
        BACKGROUND 00001111B, 0309H, 1345H
        ;TEXTS
        LOCATION 0, 1, 19
        STRING INSTITUTION
        
        LOCATION 0, 3, 23
        STRING TITLETEA
        LOCATION 0, 3, 32
        STRING TEACHER
        
        LOCATION 0, 4, 23
        STRING TITLESUB
        LOCATION 0, 4, 34
        STRING SUBJECT
        
        LOCATION 0, 7, 30
        STRING DEVS
        LOCATION 0, 9, 30
        STRING DEV1
        LOCATION 0, 11, 30
        STRING DEV2
        LOCATION 0, 13, 30
        STRING DEV3
        LOCATION 0, 15, 30
        STRING DEV4
        LOCATION 0, 17, 30
        STRING DEV5
        
        LOCATION 0, 21, 34
        READKEY
        JMP RELOAD
    ENDPROGRAM:     
        MOV AH, 4CH
        INT 21H
MAIN ENDP
INCLUDE modules.asm
END