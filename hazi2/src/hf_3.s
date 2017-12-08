DEF LD          0x80                ; LED adatregiszter (írható/olvasható)
DEF GERADE1     0b01010101          ;MASKE
DEF GERADE2     0b00110011          ;
DEF GERADE4     0b00001111          ;
DEF NACHLETZTE  0x08                ;Erste adresse, die wir nicht benutzen

DATA
DIGIT_CODE:
    DB 0x29, 0x7B, 0x49, 0x56, 0x14, 0x39, 0x60


CODE
start:
    MOV r0, #DIGIT_CODE     ;Addresse einlesen
    XOR r15, r15            ;Ergebnisregister ausnullen
    
loop:
    MOV r1, (r0)            ;Erste Byte einlesen
    MOV r2, r1              ;Kopieren
    AND r1, #GERADE1        ;Gerade Bits ausmasken (0-te, 2-te, 4-te, 6-te)
    SR0 r2                  ;Rechts verschieben, um gleiche Maske benutzen zu koennen
    AND r2, #GERADE1        ;jetzt gerade Bits ausmasken (vorherig 1-te, 3-te, 5-te, 7-te)
    ADD r1, r2              ;Zusammensummieren
    MOV r2, r1              ;Kopieren
    AND r1, #GERADE2        ;Gerade Zweibits ausmasken (0-1, 4-5)
    SR0 r2
    SR0 r2                  ;Zwei Stellen nach rechts verschieben
    AND r2, #GERADE2        ;jetzt gerade Zweibits ausmasken (vorherig 2-3, 6-7)
    ADD r1, r2              ;Summieren
    MOV r2, r1              ;Kopieren
    AND r1, #GERADE4        ;Untere 4 bits ausmasken
    SWP r2                  ;Obene und untere Bits austauschen
    AND r2, #GERADE4        ;jetzt untere 4 bits ausmasken (vorherig obene 4)
    ADD r1, r2              ;Zusammensummieren
    ADD r15, r1             ;Ergebnis speichern
    ADD r0, #1              ;Addressenzeiger erhöhen
    CMP r0, #NACHLETZTE     ;Falls wir fertig sind, sind sie gleich
    JNZ loop
    
endloop:
    MOV LD, r15             ;Ergebnis auf die LEDs darstellen
    JMP endloop