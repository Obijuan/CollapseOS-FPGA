;-- Serial module
;-- Serial comunications, without interruptions

; ** DEFINES
; SER_CTL: IO port for the UART's control registers
; SER_IO: IO port for the UART's data registers
; SER_RAMSTART: Address at which UART-related variables should be stored in
;                RAM.

; *** CONSTS ***

;*** VARIABLES
.equ	SER_RAMEND SER_RAMSTART


serInit:
  ret

; *** BLOCKDEV ***
; These function below follow the blockdev API.

serGetC:
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
