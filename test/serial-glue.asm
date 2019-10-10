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

serPutC:
  push AF
.stwait:
  ;-- Leer registro de estaus de la UART
  ;-- ¿Se puede enviar?
  in A, (SER_CTL)
  bit 0,a
  jr nz, .stwait ;-- No, esperar


  ;-- Listo para transmitir
  pop AF
  out (SER_IO), A
  ret
