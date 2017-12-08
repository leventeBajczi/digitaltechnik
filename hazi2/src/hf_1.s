; Meine Digit-Kode: 2 7 4 5 1 3 6 -> 29 7B 49 56 14 39 60

DEF LD      0x80               ; LED adatregiszter          (írható/olvasható)
DEF ANZAHL  0x06               ; Hilfe fuer die laenge des Zahlenvektors
DEF MASK    0x01

DATA

DIGIT_CODE:
    DB 0x29, 0x7B, 0x49, 0x56, 0x14, 0x39, 0x60

CODE
init:

    MOV r0, #DIGIT_CODE ;die Anfangsadresse der Zahlenmuster in r0 speichern
    ADD r0, #ANZAHL     ;Die letzte byte ist unser anfangswert
    XOR r15, r15        ;Nullieren die r15 Register, darin zaehlen wir die eine
    MOV LD, r15
loop:
    MOV r1, (r0)        ;Einladung des Bytes
inner_loop:
    SR0 r1              ;Rechst verschieben, Carry in Carry Flag speichern
    JZ  endinner        ;Falls nur 0 Werte es gibt, sind wir mit diesem Byte fertig
    ADC r15, #0         ;Den carrywert zu r15 addieren
    JMP inner_loop      ;Zurücktreten zu der Anfang dieser Schleife
endinner:
    ADC r15, #0         ;Den carrywert zu r15 addieren
    SUB r0, #1          ;ein byte zurück
    JNN loop            ;Falls nicht, dann zurück zur außere Schleife
    JMP finished        ;Falls diese wert "negativ" ist, sind wir fertig
    
finished:
    MOV LD, r15         ;Die Ergebnis auf dem LEDs darstellen
    JMP finished        ;die LEDS halten