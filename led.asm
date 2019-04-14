;---------------------------------------------------------------;
;	PROGRAMA: FONTE				 				 				;
;	AULA DE MICROCONTROLADOS I		 			 				;
;						 						 				;
;	DIGITADO POR: Marcelo e Matheus	EM: 07/03/2019				;
;						 						 				;
;	Este arquivo manipula vários LEDs	 		 			    ;
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
INICIO:	bcf STATUS, .6	; RP1 = 0
		bsf STATUS, .5	; RP0 = 1 (foi pro banco 1)
		bcf TRISD,  .0	; RD0 é saída
		bcf TRISD,  .1	; RD1 é saída
		bcf TRISD,  .2	; RD2 é saída
		bcf TRISD,  .3	; RD3 é saída
		bcf STATUS, .5	; Voltando pro banco 0

;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
		;digite aqui seu programa
LED_COM_1_BIT:
		bsf PORTD, .0
		bcf PORTD, .0
		;PISCOU LED 0
		bsf PORTD, .1
		bcf PORTD, .1
		;PISCOU LED 1
		bsf PORTD, .2
		bcf PORTD, .2
		;PISCOU LED 2
		bsf PORTD, .3
		bcf PORTD, .3
		;PISCOU LED 3

LED_COM_MUDINHO:
		movlw	0x0F;	15, numero do mudinho (1111)
		movwf 	PORTD;	joga 1 em todos os LEDS
		clrf	PORTD;	joga 0 em todos os LEDS
		;PISCOU TODOS LEDS AO MESMO TEMPO

NUMEROS_0_A_9:
		clrf	PORTD	; PORTD -> 0
		movlw	.1		; W -> 1
		movwf	PORTD 	; F -> PORTD 
		addwf	PORTD, 1; 0 + 1
		addwf	PORTD, 1; 1 +1
		addwf	PORTD, 1;	
		addwf	PORTD, 1;
		addwf	PORTD, 1;
		addwf	PORTD, 1;
		addwf	PORTD, 1;
		addwf	PORTD, 1; 8 + 1

FIM:		goto NUMEROS_0_A_9

;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;
	end