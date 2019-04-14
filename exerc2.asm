;---------------------------------------------------------------;
;	PROGRAMA: FONTE				 				 				;
;	AULA DE MICROCONTROLADOS I		 			 				;
;						 						 				;
;	DIGITADO POR: Marcelo e Matheus	EM: 11/04/2019				;
;						 						 				;
;	Este arquivo implementa o exercício do portão(2) da			; 
; 	lista de Aplicação de Lógica			 		 		 	;
;---------------------------------------------------------------;

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
		org 0x00 ; organize apartir do endereço 0
		goto INICIO

;---------------------------------------------------------------;
;			ROTINA DE INTERRUPÇÃO								;
;---------------------------------------------------------------;

;---------------------------------------------------------------;
;			CONFIGURAÇÕES INICIAIS DO PIC						;
;---------------------------------------------------------------;
INICIO:
		;indo pro banco 1
		bcf STATUS, .7	
		bcf STATUS, .6	
		bsf STATUS, .5	

		;configurando entradas (PORTB)
		bsf TRISB,	.0	; SENSOR PORTAO ABERTO | PORTAO ESTA ABERTO
		bsf TRISB,	.1	; SENSOR PRESENSA VEICULO | TEM CARRO EMBAIXO DO PORTAO
		bsf TRISB,	.2	; SENSOR PORTAO FECHADO | PORTAO ESTA FECHADO 
		bsf TRISB,	.3	; SINAL CONTROLE REMOTO | CONTROLE ACIONADO

		;configurando saídas (PORTD)
		bcf TRISD,	.0	; MOTOR SINAL R | R = 1
		bcf TRISD,	.1	; MOTOR SINAL L | L = 1

		;voltando pro banco 0
		bcf STATUS, .7	
		bcf STATUS, .6	
		bcf STATUS, .5	
;---------------------------------------------------------------;
;			ROTINA PRINCIPAL									;
;---------------------------------------------------------------;
MAIN:
		bcf PORTD, .0	; R = 0
		bcf PORTD, .1	; L = 0
TESTA_RB3:
		btfss PORTB, .3 ; RB3 = 1 ?
		goto TESTA_RB3
TESTA_DENOVO
		btfsc PORTB, .3	; RB3 = 0 ?
		goto TESTA_DENOVO

TESTE_SENSORES:
		btfsc PORTB, .0
		goto PORTAO_NAO_ABERTO		
		btfsc PORTB, .1
		goto
		btfsc PORTB, .2
		goto
FECHA_PORTAO:
		bsf PORTD, .0
		bcf PORTD, .1
		btfsc PORTB, .3        ; verifica controle remoto
		goto desliga_motor
		btfsc PORTB, .1        ; verifica se tem carro
		goto desliga_motor_2
		
desliga_motor_2:
		bcf PORTD, .0
		bcf PORTD, .1

desliga_motor
		bcf PORTD, .0
		bcf PORTD, .1
		btfsc PORTB, .3
		goto desliga_motor
		
testa_RB3_2:
		btfss PORTB, .3 ; RB3 = 1 ?
		goto testa_RB3_2
testa_denovo_2:
		btfsc PORTB, .3	; RB3 = 0 ?
		goto testa_denovo_2
		goto abre_portao

FIM: 
		goto FIM	
;---------------------------------------------------------------;
;			SUBROTINAS USADAS									;
;---------------------------------------------------------------;

end