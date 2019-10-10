;-- Vamos a dividir el soc FPGA en 8K ROM + 8K RAM
;-- ROM: 0000 - 1FFF
;-- RAM: 2000 - 3FFF
.equ	RAMSTART	0x0400
.equ	RAMEND		0x3FFF
.equ  LEDS      0x40   ;-- Puerto de salida: LEDs
.equ  SER_CTL   0x11   ;-- Uart: Registro de estado
.equ  SER_IO    0x10   ;-- Uart: Registro de datos

  ;-- Arranca en la direccion 0
  jp init

;-- Interrupciones aqui... si las hubiese


;-------- Carga de modulos
.inc "err.h"
.inc "core.asm"
.inc "parse.asm"

.equ	SER_RAMSTART	RAMSTART
.inc "ser.asm"

.equ	STDIO_RAMSTART	SER_RAMEND
.inc "stdio.asm"

.equ	SHELL_RAMSTART	STDIO_RAMEND
.equ	SHELL_EXTRA_CMD_COUNT 0
.inc "shell.asm"

  ;-- Inicializacion
init:

  ; Inicializar pila
  ld hl, RAMEND
  ld sp, hl

  ;-- Inicializacion de modulos
  call	serInit

  ld	hl, serGetC
	ld	de, serPutC
	call	stdioInit
  call	shellInit

  ;ld A, 0xF0
  ;call showleds

	jp	shellLoop


;-- Mostrar por los LEDs el registro A
showleds:
    out (LEDS), A
    ret
