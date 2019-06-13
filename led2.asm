;---------------------------------------------------------------;
;	PROGRAMA: FONTE				 				 				;
;	AULA DE MICROCONTROLADOS I		 			 				;
;						 						 				;
;	DIGITADO POR: Marcelo e Matheus	EM: 25/04/2019				;
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

		__CONFIG _CP_OFF & _CPD_OFF & _DEBUG_OFF & _LVP_OFF & _WRT_OFF & _BODEN_OFF & _PWRTE_OFF & _WDT_OFF & _HS_OSC

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
		org 0x00 ;organize apartir do endereço 0
		goto INICIO

;---------------------------------------------------------------;
;			ROTINA DE INTERRUPÇÃO								;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			CONFIGURAÇÕES INICIAIS DO PIC						;
;---------------------------------------------------------------;
INICIO:	bcf STATUS, .7	; IRP = 0
		bcf STATUS, .6	; RP1 = 0
		bsf STATUS, .5	; RP0 = 1 (foi pro banco 1)
		bcf TRISD,  .0	; RD0 é saída
		bcf TRISD,  .1	; RD1 é saída
		bcf TRISD,  .2	; RD2 é saída
		bcf TRISD,  .3	; RD3 é saída
		bcf TRISD,  .4	; RD4 é saída
		bcf TRISD,  .5	; RD5 é saída
		bcf TRISD,  .6	; RD6 é saída
		bcf TRISD,  .7	; RD7 é saída
		bcf STATUS, .5	; Voltando pro banco 0

;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
MAIN:	
	call LED_COM_1_BIT
	call LIMPA_PORTD
	call ACENDE_8
	call LIMPA_PORTD
	call NUMEROS_0_A_8
	call LIMPA_PORTD
FIM:		goto MAIN

;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;
LIMPA_PORTD:
		clrf PORTD
		RETURN

LED_COM_1_BIT:
		bsf PORTD, .0
		call ATRASO
		bcf PORTD, .0
		bsf PORTD, .1
		call ATRASO
		bcf PORTD, .1
		bsf PORTD, .2
		call ATRASO
		bcf PORTD, .2
		bsf PORTD, .3
		call ATRASO
		bcf PORTD, .3
		bsf PORTD, .4
		call ATRASO
		bcf PORTD, .4
		bsf PORTD, .5
		call ATRASO
		bcf PORTD, .5
		bsf PORTD, .6
		call ATRASO
		bcf PORTD, .6
		bsf PORTD, .7
		call ATRASO
		bcf PORTD, .7
		bsf PORTD, .8
		call ATRASO
		bcf PORTD, .8
		RETURN

ACENDE_8:
		movlw	.8;	
		movwf 	PORTD;	joga 1 em todos os LEDS
		call ATRASO
		clrf	PORTD;	joga 0 em todos os LEDS
		call ATRASO
		RETURN

NUMEROS_0_A_8:
		clrf	PORTD	; PORTD -> 0
		movlw	.1		; W -> 1
		movwf	PORTD 	; F -> PORTD 
		addwf	PORTD, 1; 0 + 1
		call ATRASO
		addwf	PORTD, 1; 1 +1
		call ATRASO
		addwf	PORTD, 1;
		call ATRASO	
		addwf	PORTD, 1;
		call ATRASO	
		addwf	PORTD, 1;
		call ATRASO	
		addwf	PORTD, 1;
		call ATRASO	
		addwf	PORTD, 1;
		call ATRASO	
		RETURN

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