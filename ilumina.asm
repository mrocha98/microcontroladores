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
;			DEFINIÇÃO DO MICROCONTROLADOR USADO					;
;---------------------------------------------------------------;
		#include <p16f877A.inc>

;---------------------------------------------------------------;
;			CONFIGURAÇÕES DOS FUSÍVEIS							;
;---------------------------------------------------------------;
		
;---------------------------------------------------------------;
;			DECLARAÇÃO DE VARIÁVEIS								;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			MACROS												;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			INICIO DAS INSTRUÇÕES				 				;
;---------------------------------------------------------------;
		org 0x00 ;organize apartir do endereço 0
		goto INICIO

;---------------------------------------------------------------;
;			ROTINA DE INTERRUPÇÃO								;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			CONFIGURAÇÕES INICIAIS DO PIC						;
;---------------------------------------------------------------;
INICIO:	
		bcf STATUS, .6	;	RP1 = 0
		bsf STATUS, .5	;	RP0 = 1 (indo pro banco 1)

		bsf TRISB,	.6	;	Botão é entrada
		bsf	TRISB,	.5	;	Sensor de Presença é entrada
		bsf	TRISB, 	.4	;	Sensor de Luz Solar é entrada
		bcf	TRISD,	.7	;	Lâmpada da Cozinha é saída
		bcf TRISD,	.6	;	Lâmpada da Garagem é saída

		bcf	STATUS,	.5	;	RP0 = 0 (indo pro banco 0)

;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
MAIN:	
LUZ:	bcf PORTD,	.7	;	limpando o que tem no PORTD (lampada cozinha)	
		bcf	PORTD,	.6	;	limpando o que tem no PORTD (lampada garagem)
		btfss PORTB,.6	;	sistema ativado? (botão)
			goto MAIN	;	volta caso desativado
		btfss PORTB,.5	;	tem gente? (presença)
			goto MAIN	;	volta caso não tenha
		btfsc PORTB,.4	;	não é dia? (luz solar)
			goto MAIN	;	volta caso seja dia
		bsf PORTD, .7	;	acende lâmpada cozinha
		bsf PORTD, .6	;	acende lâmpada garagem
		goto LUZ		;	volta pra verificação

FIM:		goto MAIN

;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;
	end