
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
