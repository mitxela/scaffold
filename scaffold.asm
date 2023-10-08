.include "tn44def.inc"

; LEDs on pins A1, A2 and A4


  ldi ZL,  low(spike*2)
  ldi ZH, high(spike*2)

.def dir = r20


main:

  ldi r16, 0b0001_0100
  ldi r17, 0b0001_0000
  rcall pwm
  ldi r16, 0b0001_0100
  ldi r17, 0b0000_0100
  rcall pwm

  ldi r16, 0b0001_0010
  ldi r17, 0b0001_0000
  rcall pwm
  ldi r16, 0b0001_0010
  ldi r17, 0b0000_0010
  rcall pwm

  ldi r16, 0b0000_0110
  ldi r17, 0b0000_0010
  rcall pwm
  ldi r16, 0b0000_0110
  ldi r17, 0b0000_0100
  rcall pwm

  tst dir
  breq down
up:
  inc ZL
  cpi ZL, 72
  brne main
  clr dir
  rjmp main
down:
  subi ZL, -3
  cpi ZL, 32
  brne main
  ldi dir, 1

rjmp main



pwm:
  out DDRA, r16

  subi ZL, 43
  lpm r18, Z
  clr r19
  cpi r18,0
  breq pwm_1b

  out PORTA, r17
pwm_1:
  inc r19
  rcall wait
  cpse r18,r19
  rjmp pwm_1

pwm_1b:
  clr r18
  out PORTA,r18
pwm_2:
  inc r19
  rcall wait
  cpse r18,r19
  rjmp pwm_2

  ret

wait:
  rjmp PC+1
  rjmp PC+1
  rjmp PC+1
  ret

.org 384
sine:
; a="";for (i=0;i<256;i++) a+=","+Math.round(2+60*Math.pow((1+Math.sin(2*3.1415926535897*i/255)),2)); a
.db 62,65,68,71,74,78,81,84,88,91,95,98,102,106,109,113,117,121,125,128,132,136,140,144,148,151,155,159,163,166,170,174,177,181,184,188,191,194,198,201,204,207,210,212,215,217,220,222,224,227,229,230,232,234,235,236,238,239,240,240,241,241,242,242,242,242,242,241,241,240,239,238,237,236,234,233,231,229,228,226,223,221,219,216,214,211,208,205,202,199,196,193,189,186,183,179,176,172,168,165,161,157,153,149,146,142,138,134,130,126,123,119,115,111,108,104,100,97,93,90,86,83,79,76,73,70,67,63,61,58,55,52,49,47,44,42,40,37,35,33,31,29,27,26,24,22,21,19,18,17,15,14,13,12,11,10,10,9,8,7,7,6,6,5,5,4,4,4,4,3,3,3,3,3,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,3,3,3,3,3,3,4,4,4,5,5,5,6,6,7,8,8,9,10,11,12,13,14,15,16,17,19,20,22,23,25,26,28,30,32,34,36,39,41,43,46,48,51,53,56,59,62

; a="";for (i=0;i<256;i++) a+=","+Math.round(255-7.9*Math.pow((1+Math.sin(2*3.1415926535897*i/255)),5)); a.substr(1)
invpeak:
.db 247,246,245,244,242,241,239,238,236,234,231,229,227,224,221,218,215,211,208,204,200,196,192,187,183,178,173,168,162,157,151,146,140,134,128,122,116,110,103,97,91,85,79,73,68,62,56,51,46,41,36,32,27,23,20,16,13,11,8,6,5,4,3,2,2,2,3,4,6,7,10,12,15,18,22,25,30,34,38,43,48,54,59,65,70,76,82,88,94,100,107,113,119,125,131,137,143,148,154,160,165,170,175,180,185,190,194,198,202,206,210,213,216,220,223,225,228,230,233,235,237,238,240,242,243,244,246,247,248,248,249,250,251,251,252,252,253,253,253,253,254,254,254,254,254,254,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,254,254,254,254,254,254,253,253,253,252,252,251,251,250,250,249,248,247

; a="";for (i=0;i<256;i++) a+=","+Math.round(4*Math.pow((1+Math.sin(2*3.1415926535897*i/255)),6)); a.substr(1)
peak:
.db 4,5,5,6,7,8,9,10,12,13,15,17,19,21,23,25,28,31,34,37,41,45,49,53,57,62,67,72,77,82,88,94,100,106,112,119,125,132,139,145,152,159,166,172,179,185,192,198,204,210,215,221,226,230,235,239,242,246,248,251,253,254,255,256,256,256,255,254,252,250,247,244,241,237,233,228,223,218,213,207,201,195,189,182,176,169,162,155,149,142,135,128,122,115,109,103,97,91,85,80,74,69,64,59,55,51,47,43,39,36,33,30,27,24,22,20,18,16,14,12,11,10,9,8,7,6,5,4,4,3,3,2,2,2,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,2,2,2,3,3,3,4



; a="";for (i=0;i<256;i++) a+=","+Math.round(i<31?i*8 : (i<63? 8*(63-i):0)); a.replace(/256/g,'255').substr(1)
spike:
.db 0,8,16,24,32,40,48,56,64,72,80,88,96,104,112,120,128,136,144,152,160,168,176,184,192,200,208,216,224,232,240,255,248,240,232,224,216,208,200,192,184,176,168,160,152,144,136,128,120,112,104,96,88,80,72,64,56,48,40,32,24,16,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

