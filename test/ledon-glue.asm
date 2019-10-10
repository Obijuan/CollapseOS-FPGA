;-- Vamos a dividir el soc FPGA en 8K ROM + 8K RAM
;-- ROM: 0000 - 1FFF
;-- RAM: 2000 - 3FFF
.equ	RAMSTART	0x2000
.equ	RAMEND		0x3FFF

;-- Puerto de los LEDs
.equ LEDS 0x40

  ;-- Arranca en la direccion 0
  jr init

;-- Interrupciones aqui... si las hubiese

  ;-- Inicializacion
init:

  ; Inicializar pila
  ld hl, RAMEND
  ld sp, hl

  ;-- Inicializacion de modulos

  jp mainLoop

  ;-- Carga de modulos


  ;-- Bucle principal
mainLoop:

    ;-- Sacar un valor por A
    ;-- Prueba de que la pila va bien
    ld A, 0xAA
    call showleds

    halt

;-- Mostrar por los LEDs el registro A
showleds:
    out (LEDS), A
    ret
