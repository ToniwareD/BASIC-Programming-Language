10 REM ESPCHAR By ZilogZ80, Antonio Diaz Alvarez
20 REM
30 MODE 2:BORDER 1:INK 0,1:PEN 1:PAPER 2
40 SYMBOL AFTER 240
50 SYMBOL 240,65,34,20,8,20,34,65,0
60 SYMBOL 241,255,1,1,1,1,1,1,1
70 SYMBOL 242,0,254,254,254,254,254,254,254
80 SYMBOL 243,255,0,0,0,0,0,0,0
90 pant=1:b=0
100 REM Dibuja casillas
110 posx=0:posy=0:posxa=0:posya=0
120 DIM bit(7,7)
130 FOR x=0 TO 7
140 FOR y=0 TO 7
150 bit(x,y)=b
160 NEXT :NEXT  
170 REM
180 REM bucle principal
190 REM
200 IF inicio=1 THEN GOSUB 370
210 IF pant=1 THEN GOSUB 240
220 GOTO 200
230 RETURN
240 LOCATE 2,12:PRINT"Vista previa:":LOCATE 3,1:PRINT"MODE 2":LOCATE 30,1:PRINT"MODE 1":LOCATE 63,1:PRINT"MODE 0":LOCATE 60,13:PRINT"Dec   Hex  Binario"
250 LOCATE 2,15:PRINT"(B) Borrar las cuadriculas":LOCATE 2,16:PRINT"(Cursor) Movimiento del puntero":LOCATE 2,17:PRINT"(ESPACIO) Rellena un cuadro"
260 LOCATE 6,24:PRINT"ESPCHAR 2006 Generador de caracteres, por Antonio Diaz Alvarez"
270 car1$=CHR$(243)+CHR$(241)+CHR$(243)+CHR$(241)+CHR$(243)+CHR$(241)+CHR$(243)+CHR$(241)+CHR$(243)+CHR$(241)+CHR$(243)+CHR$(241)+CHR$(243)+CHR$(241)+CHR$(243)+CHR$(241)
280 car2$=STRING$(2,243)+CHR$(241)+STRING$(2,243)+CHR$(241)+STRING$(2,243)+CHR$(241)+STRING$(2,243)+CHR$(241)+STRING$(2,243)+CHR$(241)+STRING$(2,243)+CHR$(241)+STRING$(2,243)+CHR$(241)+STRING$(2,243)+CHR$(241)
290 FOR hor=1 TO 8
300 LOCATE 2,hor+1:PRINT STRING$(8,241)
310 LOCATE 25,hor+1:PRINT car1$
320 LOCATE 54,hor+1:PRINT car2$
330 NEXT hor
340 MOVE 7,257:DRAW 7,383,1:MOVE 7,255:DRAW 71,255:MOVE 191,255:DRAW 191,383:MOVE 192,255:DRAW 318,255:MOVE 423,255:DRAW 423,383:MOVE 423,255:DRAW 615,255
350 pant=0:inicio=1
360 RETURN
370 REM Rutinas teclado
380 LOCATE 2,2:PRINT CHR$(143)
390 IF INKEY(1)=0 THEN GOSUB 470
400 IF INKEY(8)=0 THEN GOSUB 540
410 IF INKEY(0)=0 THEN GOSUB 620
420 IF INKEY(2)=0 THEN GOSUB 690
430 IF INKEY(47)=0 THEN GOSUB 760
440 IF INKEY(54)=0 THEN CLS:inicio=0:pant=1:reinicio=1:ERASE bit:GOTO 110
450 FOR retardo=1 TO 20:NEXT retardo
460 GOTO 390
470 REM derecha
480 IF posx=7 THEN RETURN
490 posx=posx+1: LOCATE posx+2,posy+2
500 IF bit(posx,posy)=0 THEN PRINT CHR$(&18);" "; CHR$(&18); ELSE PRINT CHR$(&18);CHR$(242); CHR$(&18)
510 LOCATE posxa+2,posya+2:IF bit(posxa,posya)=0 THEN PRINT CHR$(241); ELSE PRINT CHR$(242);
520 posxa=posx 
530 RETURN
540 REM izquierda
550 IF posx=0 THEN RETURN
560 posx=posx-1: LOCATE posx+2,posy+2
570 IF bit(posx,posy)=0 THEN PRINT CHR$(&18);" "; CHR$(&18); ELSE PRINT CHR$(&18);CHR$(242); CHR$(&18);
580 LOCATE posxa+2,posya+2:IF bit(posxa,posya)=0 THEN PRINT CHR$(241); ELSE PRINT CHR$(242);
590 posxa=posx
600 posya=posy
610 RETURN
620 REM arriba
630 IF posy=0 THEN RETURN
640 posy=posy-1: LOCATE posx+2,posy+2
650 IF bit(posx,posy)=0 THEN PRINT CHR$(&18);" "; CHR$(&18); ELSE PRINT CHR$(&18);CHR$(242); CHR$(&18); 
660 LOCATE posxa+2,posya+2:IF bit(posxa,posya)=0 THEN PRINT CHR$(241); ELSE PRINT CHR$(242);
670 posya=posy
680 RETURN
690 REM abajo
700 IF posy=7 THEN RETURN
710 posy=posy+1: LOCATE posx+2,posy+2
720 IF bit(posx,posy)=0 THEN PRINT CHR$(&18);" "; CHR$(&18) ELSE PRINT CHR$(&18);CHR$(242); CHR$(&18)  
730 LOCATE posxa+2,posya+2:IF bit(posxa,posya)=0 THEN PRINT CHR$(241); ELSE PRINT CHR$(242);
740 posya=posy
750 RETURN
760 REM cambiar bit
770 posxmod1=posx*2+25:posymod1=posy+2
780 posxmod0=posx*3+54:posymod0=posy+2
790 posply=posy*2
800 posplx=posx*2
810 posply=-posply
820 IF bit(posx,posy)=0 THEN LOCATE posxmod1,posymod1:PRINT STRING$(2,143);:LOCATE posxmod0,posymod0:PRINT STRING$(3,143) ELSE LOCATE posxmod1,posymod1:PRINT CHR$(243)+CHR$(241);:LOCATE posxmod0,posymod0:PRINT STRING$(2,243)+CHR$(241)
830 IF bit(posx,posy)=0 THEN LOCATE posxmod1,posymod1:PRINT STRING$(2,143):bit(posx,posy)=1:PLOT posplx+120,posply+223,1:PLOT posplx+121,posply+223,1 ELSE bit(posx,posy)=0:PLOT posplx+120,posply+223,0:PLOT posplx+121,posply+223,0
840 num%=0
850 FOR x=0 TO 7
860 num%=num%+bit(x,posy)*2^x
870 NEXT
880 num$=HEX$(num%):LOCATE 60,15+posy:PRINT USING "###"; num%;:PRINT "   ";:PRINT USING "\\  \\";num$;:PRINT " ";:PRINT USING "\\        \\";BIN$(num%);
890 RETURN