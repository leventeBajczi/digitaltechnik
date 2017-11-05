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
read:
    MOV r1, (r0)        ;Die aktuelle Byte in r1 speichern durch indirekte Addressierung
    JSR schleife
    SUB r0, #0x01       ;Letzte Addresse
    JN  finished        ;Falls wir eine nicht erlaubte Addresse erreichen, gehen wir zur finished
    JMP read
schleife:
    CMP r1, #0x00       ;Falls es null ist, zurueck zur read
    JNZ  schleife_body
    RTS
schleife_body:
    MOV r2, r1          ;Hilfsregister benutzen
    AND r2, #MASK       ;letzte bit ausmasken
    ADD r15, r2         ;entweder 0 oder 1 addieren
    SR0 r1              ;Rechts schiften
    JMP schleife
    
    
finished:
    MOV LD, r15
    JMP finished        ;die LEDS halten