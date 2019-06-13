;---------------------------------------------------------------;
;	PROGRAMA: FONTE				 				 				;
;	AULA DE MICROCONTROLADOS I		 			 				;
;						 						 				;
;	DIGITADO POR: Matheus EM: 13/06/2019						;
;						 						 				;
;	Este arquivo � respons�vel por acender 4 LEDS dispostos na	;
;	porta D conforme o sinal de um bot�o na porta B 	 		;
;---------------------------------------------------------------;


;---------------------------------------------------------------;
;			DEFINI��O DO MICROCONTROLADOR USADO					;
;---------------------------------------------------------------;
		#include <p16f877A.inc>

;---------------------------------------------------------------;
;			CONFIGURA��ES DOS FUS�VEIS							;
;---------------------------------------------------------------;

		__CONFIG _CP_OFF & _CPD_OFF & _DEBUG_OFF & _LVP_OFF & _WRT_OFF & _BODEN_OFF & _PWRTE_OFF & _WDT_OFF & _HS_OSC

;---------------------------------------------------------------;
;			DECLARA��O DE VARI�VEIS								;
;---------------------------------------------------------------;
		T1	equ	1;.20
		T2	equ 1;.30
		T3	equ	1;.225
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
INICIO:	bcf STATUS, .7	; IRP = 0
		bcf STATUS, .6	; RP1 = 0
		bsf STATUS, .5	; RP0 = 1 (foi pro banco 1)

		bsf TRISB,	.6	; RB6 � entrada

		bcf TRISD,  .2	; RD2 � sa�da
		bcf TRISD,  .3	; RD3 � sa�da
		bcf TRISD,  .4	; RD4 � sa�da
		bcf TRISD,  .5	; RD5 � sa�da
		
		bcf STATUS, .5	; Voltando pro banco 0

;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
MAIN:
		call CHECA_BOTAO
		goto MAIN		

;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;
APAGA_LEDS:
		clrf PORTD
		goto CHECA_BOTAO

CHECA_BOTAO:
		btfss PORTB, .6	; Botao esta pressionado?
		goto APAGA_LEDS; Caso nao esteja, volta a checar
		goto ACENDE_LEDS; Caso esteja, chama subrotinas que acendem os leds
		goto ACENDE_1_EM_1

ACENDE_LEDS:
		movlw .60;	00111100
		movwf PORTD
		call ATRASO
		RETURN

ACENDE_1_EM_1:
		movlw 0x04;	00000100
		movwf PORTD
		call ATRASO
		movlw 0x08;	00001000
		movwf PORTD
		call ATRASO
		movlw .16;	00010000
		movwf PORTD
		call ATRASO
		movlw .32;	00100000
		movwf PORTD
		call ATRASO
		movlw .16;	00010000
		movwf PORTD
		call ATRASO
		movlw 0x08;	00001000
		movwf PORTD
		call ATRASO
		movlw 0x04;	00000100
		movwf PORTD
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