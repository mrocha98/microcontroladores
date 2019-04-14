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
INICIO:	bcf STATUS, .7	; IRP = 0
		bcf STATUS, .6	; RP1 = 0
		bcf STATUS, .5	; RP0 = 0

;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
MAIN:
		call ATRASO		;	chame a subrotina ATRASO
		call ATRASO		;	mesma coisa
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