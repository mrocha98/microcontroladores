;---------------------------------------------------------------;
;	PROGRAMA: DISPLAY DE 7 SEGMENTOS				 			;
;	AULA DE MICROCONTROLADOS I		 			 				;
;	CLOCK: 10MHz			 						 			;
;	DIGITADO POR: Matheus e Elivelton EM: 16/05/2019			;
;						 						 				;
;	ESTE ARQUIVO FONTE MOSTRA NUMEROS NO DISPLAY			 	;
;---------------------------------------------------------------;



;---------------------------------------------------------------;
;			DEFINIÇÃO DO MICROCONTROLADOR USADO					;
;---------------------------------------------------------------;
		PROCESSOR 16F877A
		#include <p16f877A.inc>

;---------------------------------------------------------------;
;			CONFIGURAÇÕES DOS FUSÍVEIS							;
;---------------------------------------------------------------;

		__CONFIG _CP_OFF & _CPD_OFF & _DEBUG_OFF & _LVP_OFF & _WRT_OFF & _BODEN_OFF & _PWRTE_OFF & _WDT_OFF & _HS_OSC

;---------------------------------------------------------------;
;			DECLARAÇÃO DE VARIÁVEIS								;
;---------------------------------------------------------------;
		T1	equ	.2 ;.10	
		T2	equ .2 ;.25
		T3	equ	.2 ;.255
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

		;PORTD SERÁ SAÍDA (0)
		;PORTC SERÁ SAÍDA (0)
		call LIMPA_TRIS

		bcf STATUS, .5	; Voltando pro banco 0

;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
MAIN:
		call APAGA_TODOS
		call NUM_0
		call NUM_1
		call NUM_2
		call NUM_3
		call NUM_4
		call NUM_5
		call NUM_6
		call NUM_7
		call NUM_8
		call NUM_9
		goto MAIN		

;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;

APAGA_TODOS:
		movlw 0xFF
		movwf PORTC
		RETURN

NUM_0:
		movlw 0x80
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_1:
		movlw 0xf2
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_2:
		movlw 0x48
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_3:
		movlw 0x60
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_4:
		movlw 0x32
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_5:
		movlw 0x24
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_6:
		movlw 0x4
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_7:
		movlw 0xf0
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_8:
		movlw 0x0
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN

NUM_9:
		movlw 0x20
		movwf PORTD
		bcf PORTC, .2 ;RC2
		call ATRASO
		bsf PORTC, .2 
		RETURN


LIMPA_TRIS:
		clrf TRISC
		clrf TRISD
		RETURN

LIMPA_PORTC:
		clrf PORTC
		RETURN

LIMPA_PORTD:
		clrf PORTD
		RETURN


ACENDE_DE_2_EM_2:
		movlw 0x03; 11
		movwf PORTD
		call ATRASO 
		movlw .12; 1100
		movwf PORTD
		call ATRASO
		movlw .48; 110000
		movwf PORTD
		call ATRASO
		movlw .192; 11000000
		movwf PORTD
		call ATRASO
		movlw .48
		movwf PORTD
		call ATRASO 
		movlw .12
		movwf PORTD
		call ATRASO
		movlw 0x03
		movwf PORTD
		call ATRASO
		RETURN


ACENDE_8:
		movlw	.8;	
		movwf 	PORTD;	joga 1 em todos os LEDS
		call ATRASO
		clrf	PORTD;	joga 0 em todos os LEDS
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