DEF NACHLETZTE      0x28
DEF BYTEMASK        0x0f
DEF LD              0x80

DATA

SUM_LUT:
    DB 0x00, 0x01, 0x01, 0x02, 0x01, 0x02, 0x02, 0x03, 0x01, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04
    org 0x20
DIGIT_CODE:
    DB 0x29, 0x7B, 0x49, 0x56, 0x14, 0x39, 0x60

CODE
start:
    MOV r0, #DIGIT_CODE ;Einladung von der Anfangsadresse
    XOR r15, r15        ;Den Register, den wir als Zaehler benutzen werden, ausnullen
loop:
    MOV r1, (r0)        ;Dateneinladung
    AND r1, #BYTEMASK   ;untere 4 bits ausmasken
    MOV r14, (r1)       ;basisadresse ist 0, also die Offset allein koennte als Adresse benutzt werden
    ADD r15, r14
    MOV r1, (r0)        ;Dateneinladung noch einmal
    SWP r1              ;Untere und obene Bits austauschen
    AND r1, #BYTEMASK   ;untere 4 bits ausmasken
    MOV r14, (r1)       ;basisadresse ist 0, also die Offset allein koennte als Adresse benutzt werden
    ADD r15, r14
    ADD r0, #0x01       ;Adresse inkrementieren
    CMP r0, #NACHLETZTE ;Falls sie die gleiche Wert betragen, sind wir fertig
    JNZ loop
endloop:
    MOV LD, r15         ;Ergebnis auf der LEDs darstellen
    JMP endloop