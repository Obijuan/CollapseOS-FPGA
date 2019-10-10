;-- Vamos a dividir el soc FPGA en 8K ROM + 8K RAM
;-- ROM: 0000 - 1FFF
;-- RAM: 2000 - 3FFF
.equ	RAMSTART	0x2000
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

.equ	SER_RAMSTART	RAMSTART
.inc "ser.asm"

.equ	STDIO_RAMSTART	SER_RAMEND
.inc "stdio.asm"

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

  ;-- Bucle principal
mainLoop:

    ld hl, .caca
    call printstr

    ;-- Sacar un valor por A
    ;-- Prueba de que la pila va bien
    ld A, 0xAA
    call showleds

    halt

.caca:
  	.db	"Hola", ASCII_CR, ASCII_LF, 0

;-- Mostrar por los LEDs el registro A
showleds:
    out (LEDS), A
    ret
