;---------------------------------------------------------------;
;	PROGRAMA: FONTE				 				 				;
;	AULA DE MICROCONTROLADOS I		 			 				;
;						 						 				;
;	DIGITADO POR: Marcelo e Matheus	EM: 04/04/2019				;
;						 						 				;
;	Este arquivo implementa o exercício do carrinho (1) da		; 
; 	lista de Aplicação de Lógica			 		 		 	;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			DEFINIÇÃO DO MICROCONTROLADOR USADO					;
;---------------------------------------------------------------;
		#include <p16f877A.inc>

;---------------------------------------------------------------;
;			CONFIGURAÇÕES DOS FUSÍVEIS							;
;---------------------------------------------------------------;
		
;---------------------------------------------------------------;
;			DECLARAÇÃO DE VARIÁVEIS								;
;---------------------------------------------------------------;
	T1	equ	.2
	T2	equ .3
	T3	equ	.5

;---------------------------------------------------------------;
;			MACROS												;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			INICIO DAS INSTRUÇÕES				 				;
;---------------------------------------------------------------;
		org 0x00 ; organize apartir do endereço 0
		goto INICIO

;---------------------------------------------------------------;
;			ROTINA DE INTERRUPÇÃO								;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			CONFIGURAÇÕES INICIAIS DO PIC						;
;---------------------------------------------------------------;
INICIO:
		;indo pro banco 1
		bcf STATUS, .7	
		bcf STATUS, .6	
		bsf STATUS, .5	

		;configurando entradas (PORTB)
		bsf TRISB,	.0	; 	LM é entrada
		bsf TRISB,	.1	; 	TE é entrada
		bsf TRISB,	.2	; 	TD é entrada
		bsf	TRISB,	.3	; 	TDESLIGA é entrada

		;configurando saídas (PORTD)
		bcf TRISD,	.0	; 	M é saída
		bcf TRISD,	.1	; 	VE é saída
		bcf TRISD,	.2	; 	VD é saída

		;voltando pro banco 0
		bcf STATUS, .7	
		bcf STATUS, .6	
		bcf STATUS, .5	
;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
MAIN:
		bcf PORTD,	.0	;	desliga o motor (M = 0)
		bcf PORTD,	.1	;	desliga circuito VE (VE = 0)
		bcf PORTD,	.2	;	desliga circuito VD	(VD = 0)
TECLADO:
		btfsc PORTB, .0	;	LM = 0?
		goto LIGA_MOTOR ;	LM = 1
		btfsc PORTB, .1	;	LM = 0, TD = 0?
		goto VIRA_DIREITA;	TD = 1
		btfsc PORTB, .2	;	TD = 0, TE = 0?
		goto VIRA_ESQUERDA;	
		btfsc PORTB, .3	;	Tdesliga = 0?
		goto DESLIGA_MOTOR
		goto TECLADO		

LIGA_MOTOR:
		bsf PORTD, .0 ;
		goto TECLADO	

DESLIGA_MOTOR:
		bcf PORTD, .0 ;
		goto TECLADO

VIRA_DIREITA:
		btfss PORTD, .1	; esquerda esta acionada?
		goto DIREITA
		bcf PORTD, .1	; desliga a esquerda
		goto TECLADO
DIREITA:
		bsf PORTD, .2
		goto TECLADO

VIRA_ESQUERDA:
		btfss PORTD, .2	; direita esta acionada?
		goto ESQUERDA
		bcf PORTD, .2	; desliga a direita
		goto TECLADO
ESQUERDA
		bsf PORTD, .1
		goto TECLADO

FIM: 
		goto FIM	
;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;


ATRASO:
		movlw T1	
		movwf 0x20		
REPETE:
		movlw T2		
		movwf 0x21		
REPETE1:
		movlw T3
		movwf 0x22
REPETE2:
		movlw .1			
		subwf 0x22, .1		
		btfss STATUS, .2	
		goto REPETE2
		movlw .1
		subwf 0x21, .1
		btfss STATUS, .2
		goto REPETE1
		
		movlw .1
		subwf 0x20, .1
		btfss STATUS, .2
		goto REPETE
		RETURN
end