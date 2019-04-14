;----------------------------------------------------------------;
;	PROGRAMA: PROGRAMA LE CHAVE				 				 	 ;
;	AULA DE MICROCONTROLADOS I		 			 				 ;
;																 ;
;	MICROCONTROLADOR: PIC16F877A								 ;
;	VERSÃO: 1.0													 ;
;	CLOCK: 10MHz					 						 	 ;
;																 ;
;	DIGITADO POR: Marcelo e Matheus	EM: 14/03/2019				 ;
;						 						 				 ;
;	Faz a leitura da chave em RB0, se 1 acende os leds que estão ;
; 	em RD3, RD2, RD1 e RD0										 ;
;----------------------------------------------------------------;

;---------------------------------------------------------------;
;			DEFINIÇÃO DO MICROCONTROLADOR USADO					;
;---------------------------------------------------------------;
			PROCESSOR	16F877A
			#include 	<p16f877A.inc>

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
		bcf STATUS, .7	;
		bcf STATUS, .6	; RP1 = 0
		bsf STATUS, .5	; RP0 = 1 (foi pro banco 1)

		bsf TRISB,  .0	; RB0 é saída

		bcf TRISD,  .0	; RD0 é saída
		bcf TRISD,  .1	; RD1 é saída
		bcf TRISD,  .2	; RD2 é saída
		bcf TRISD,  .3	; RD3 é saída

		bcf STATUS, .5	; Voltando pro banco 0
		;sequência de inicialização no Banco 0
;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
		;digite aqui seu programa
MAIN:
		movlw	0x0F		;
		movwf	PORTD		; 
		
DENOVO:	btfss	PORTB,	.0	;	Se não for 1 ele deve executar APAGA
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