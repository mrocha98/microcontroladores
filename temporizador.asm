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
	T1	equ	.10	; T1 vale 10
	T2	equ .10 ;
	T3	equ	.10	;

;---------------------------------------------------------------;
;			MACROS												;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			INICIO DAS INSTRU��ES				 				;
;---------------------------------------------------------------;
		org 0x00 ; organize apartir do endere�o 0
		goto INICIO

;---------------------------------------------------------------;
;			ROTINA DE INTERRUP��O								;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			CONFIGURA��ES INICIAIS DO PIC						;
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
		movlw X			;	Carrega X no W
		movwf 0x20		;	copia W (x) no endere�o 20

REPETE:
		movlw .1		;	Carrega 1 no W
		subwf 0x20, .1	;	Subtrai W no endere�o 20
		btfss STATUS, .2;	Se (encontrou 0){retorne} Senao {repete}
		goto REPETE
		return

end