;---------------------------------------------------------------;
;	PROGRAMA: FONTE				 				 				;
;	AULA DE MICROCONTROLADOS I		 			 				;
;						 						 				;
;	DIGITADO POR: Marcelo e Matheus	EM: 21/02/2019				;
;						 						 				;
;	Este arquivo fonte CRIA UM PADRAO A SER  	 				;
;	SEGUIDO PARA UM ARQUIVO FONTE		 		 			    ;
;---------------------------------------------------------------;

;O programa escrito deve seguir a seguinte ordem...

;---------------------------------------------------------------;
;			DEFINI��O DO MICROCONTROLADOR USADO					;
;---------------------------------------------------------------;
		#include <p16f877A.inc>

;---------------------------------------------------------------;
;			CONFIGURA��ES DOS FUS�VEIS							;
;---------------------------------------------------------------;
		
;---------------------------------------------------------------;
;			DECLARA��O DE VARI�VEIS								;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			MACROS												;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			INICIO DAS INSTRU��ES				 				;
;---------------------------------------------------------------;
		org 0x00 ;organize apartir do endere�o 0
		goto INICIO

;---------------------------------------------------------------;
;			ROTINA DE INTERRUP��O								;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			CONFIGURA��ES INICIAIS DO PIC						;
;---------------------------------------------------------------;
INICIO:	
		bcf STATUS, .6	;	RP1 = 0
		bsf STATUS, .5	;	RP0 = 1 (indo pro banco 1)

		bsf TRISB,	.6	;	Bot�o � entrada
		bsf	TRISB,	.5	;	Sensor de Presen�a � entrada
		bsf	TRISB, 	.4	;	Sensor de Luz Solar � entrada
		bcf	TRISD,	.7	;	L�mpada da Cozinha � sa�da
		bcf TRISD,	.6	;	L�mpada da Garagem � sa�da

		bcf	STATUS,	.5	;	RP0 = 0 (indo pro banco 0)

;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
MAIN:	
LUZ:	bcf PORTD,	.7	;	limpando o que tem no PORTD (lampada cozinha)	
		bcf	PORTD,	.6	;	limpando o que tem no PORTD (lampada garagem)
		btfss PORTB,.6	;	sistema ativado? (bot�o)
			goto MAIN	;	volta caso desativado
		btfss PORTB,.5	;	tem gente? (presen�a)
			goto MAIN	;	volta caso n�o tenha
		btfsc PORTB,.4	;	n�o � dia? (luz solar)
			goto MAIN	;	volta caso seja dia
		bsf PORTD, .7	;	acende l�mpada cozinha
		bsf PORTD, .6	;	acende l�mpada garagem
		goto LUZ		;	volta pra verifica��o

FIM:		goto MAIN

;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;
	end