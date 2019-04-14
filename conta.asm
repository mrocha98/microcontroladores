;---------------------------------------------------------------;
;	PROGRAMA: CONTA				 				 				;
;	AULA DE MICROCONTROLADOS I		 			 				;
;						 						 				;
;	DIGITADO POR: Marcelo e Matheus	EM: 21/02/2019				;
;						 						 				;
;	Este arquivo fonte REALIZA A OPERACAO X - 2Y + 4T			;
;	SENDO X = 10, Y = 3 E T = 6									;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;				inicio das instuções			 				;
;---------------------------------------------------------------;
		org 0x00 		;organize apartir do endereço 0

INICIO:	movlw .10		; carrega 10
		movwf 0x20		; move 10 pro 0x20 (x)
		movlw .3		; carrega 3
		movwf 0x21		; move 3 pro 0x21 (y)
		movlw .6		; carrega 6
		movwf 0x22		; move 6 pro 0x22 (t)
		clrf 0x23		; limpa o endereco 0x23 (res)
		movf 0x20, 0	; jogando x no W
		addwf 0x23, 1	; adicionando x no res
		movf 0x23, 0	; jogando res no W
		subwf 0x21, 1	; subtraindo Y do res
		subwf 0x21, 1	; subtraindo Y do res
		addwf 0x22, 1	; adicionando T no res
		addwf 0x22, 1	; adicionando T no res
		addwf 0x22, 1	; adicionando T no res
		addwf 0x22, 1	; adicionando T no res

FIM:		goto FIM	; finaliza

	end
