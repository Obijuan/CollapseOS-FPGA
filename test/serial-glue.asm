;-- Vamos a dividir el soc FPGA en 8K ROM + 8K RAM
;-- ROM: 0000 - 1FFF
;-- RAM: 2000 - 3FFF
.equ	RAMSTART	0x2000
.equ	RAMEND		0x3FFF
.equ  LEDS      0x40   ;-- Puerto de salida: LEDs
.equ  SER_CTL   0x11   ;-- Uart: Registro de estado
.equ  SER_IO    0x10   ;-- Uart: Registro de datos

  ;-- Arranca en la direccion 0
  jr init

;-- Interrupciones aqui... si las hubiese


;-- Carga de modulos
.inc "err.h"

.equ	SER_RAMSTART	RAMSTART
.inc "ser.asm"

  ;-- Inicializacion
init:

  ; Inicializar pila
  ld hl, RAMEND
  ld sp, hl

  ;-- Inicializacion de modulos
  call	serInit

  jp mainLoop


  ;-- Bucle principal
mainLoop:

    ld A, 0x42
    call serPutC

    ;-- Sacar un valor por A
    ;-- Prueba de que la pila va bien
    ld A, 0xAA
    call showleds

    halt

;-- Mostrar por los LEDs el registro A
showleds:
    out (LEDS), A
    ret
