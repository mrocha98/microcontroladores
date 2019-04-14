;----------------------------------------------------------------;
;	PROGRAMA: PROGRAMA LE CHAVE				 				 	 ;
;	AULA DE MICROCONTROLADOS I		 			 				 ;
;																 ;
;	MICROCONTROLADOR: PIC16F877A								 ;
;	VERS�O: 1.0													 ;
;	CLOCK: 10MHz					 						 	 ;
;																 ;
;	DIGITADO POR: Marcelo e Matheus	EM: 14/03/2019				 ;
;						 						 				 ;
;	Faz a leitura da chave em RB0, se 1 acende os leds que est�o ;
; 	em RD3, RD2, RD1 e RD0										 ;
;----------------------------------------------------------------;

;---------------------------------------------------------------;
;			DEFINI��O DO MICROCONTROLADOR USADO					;
;---------------------------------------------------------------;
			PROCESSOR	16F877A
			#include 	<p16f877A.inc>

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
		bcf STATUS, .7	;
		bcf STATUS, .6	; RP1 = 0
		bsf STATUS, .5	; RP0 = 1 (foi pro banco 1)

		bsf TRISB,  .0	; RB0 � sa�da

		bcf TRISD,  .0	; RD0 � sa�da
		bcf TRISD,  .1	; RD1 � sa�da
		bcf TRISD,  .2	; RD2 � sa�da
		bcf TRISD,  .3	; RD3 � sa�da

		bcf STATUS, .5	; Voltando pro banco 0
		;sequ�ncia de inicializa��o no Banco 0
;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
		;digite aqui seu programa
MAIN:
		movlw	0x0F		;
		movwf	PORTD		; 
		
DENOVO:	btfss	PORTB,	.0	;	Se n�o for 1 ele deve executar APAGA
		goto 	APAGA		;	Executa APAGA
		goto	ACENDE		;	Executa ACENDE

ACENDE:	movlw	0x0F		;	
		movwf	PORTD		;
		goto 	DENOVO

APAGA:	clrf	PORTD		;
		goto	DENOVO		;

FIM:	goto FIM

;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;
	end