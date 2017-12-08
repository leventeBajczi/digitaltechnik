DEF SIZE 0x80
DEF HALF 0x40
DEF LD   0x80
DEF END  84
;A feladatunk tulajdonkeppen egy 100-as szamrendszerben levo kaszkadositott osszeado realizalasa

CODE
    XOR r0, r0      ;lenullazzuk a szamlalot
    XOR r1, r1      ;lenullazzuk a segedregisztert
    MOV r2, #SIZE   ;betoltjuk r2-be a kinullazando terulet meretet
null:               ;Memoriaterulet nullazasa, hogy ne legyen benne szemet
    MOV (r0), r1    ;az r0 altal jelzett helyre r1 erteket (0) kiirni
    ADD r0, #1      ;a mutatot noveljuk
    CMP r0, r2      ;teszteljuk, hogy elertuk-e a veget
    JNZ null        ;ha nem, akkor visszamegyunk a loop elejere
_start:             ;itt kezdodik a valos program
    MOV r1, #1      ;a segedregiszterbe 1-et toltunk, ami a kezdoertek
    MOV r0, #SIZE   ;
    SUB r0, #1      ;az utols byte-ra allitjuk a mutatot
    MOV (r0), r1    ;Kezdoertek, 0! = 1 (definicio alapjan)

    XOR r13, r13    ;lenullazzuk a carryt

    XOR r0, r0      ;lenullazzuk a mutatot
loop:
    jsr copy_second_half    ;a memoria masodik felet lemasoljuk az elso felebe
    XOR r1, r1      ;lenullazzuk a segedregisztert, ebben fogunk a szubrutinban szamolni felfele
    MOV r8, r0      ;elmentjuk r0 ertelet
    ADD r8, #1      ;noveljuk ezt az erteket (igy tudjuk hasznalni, ld. tizesek)
    jsr tizesek     ;a tizeseket eliminaljuk, hogy joval kevesebb szamitast kelljen veghezvinni
    jsr inner_loop  ;a belso loop, ami arra van, hogy az osszeadasokat elvegezze
    ADD r0, #1      ;noveljuk a szamlalo erteket
    jsr display_led ;kijelezzuk a LED-eken (BCD)
    CMP r0, #END    ;ha elertuk a definialt vegerteket (END<=83)
    JNZ loop        ;akkor mar nem terunk vissza a loop elejere, amugy igen
end:
    JMP end         ;megtartjuk ezt az allapotot, elertuk a vegerteket


display_led:
    MOV r8, r0      ;elmentjuk r0 erteket, hogy azt ne bantsuk
    XOR r9, r9      ;lenullazzuk a segedregisztert, amiben a BCD kod fog eloallni
display_loop:
    CMP r8, #10     ;ha mar az ertek kisebb, mint 10, akkor vegeztunk,
    JN display      ;akkor mehetunk a display label-re
    ADD r9, #1      ;noveljuk a tizesek szamat (majd SWP-zzük)
    SUB r8, #10     ;levonunk tizet a szambol
    JMP display_loop;vissza a loop elejere
display:
    SWP r9          ;felcsereljuk az also es a felso 4 bitet, ezzel egy helyiertekkel feljebb kerul az ertekes resz
    OR r8, r9       ;ossze VAGY-oljuk az also es a felso digitet
    MOV LD, r8      ;kiirjuk ezt a LED sorra
    rts

tizesek:
    CMP r8, #10     ;ha hozzaadunk tizet, es ez az ertek nagyobb, mint r0, akkor visszaterunk, nem csinalunk mar semmit
    JN ret_tizesek  ;
    jsr shift_left  ;ha van benne egesz tizes, balra shifteljuk fel byte-tal
    SUB r8, #10     ;levonunk tizet az ertekebol
    MOV r1, r0      ;betoltjuk r1-be r0 erteket,
    SUB r1, r8      ;makd kivonjuk belole a maradekot - ennyi osszeadast kell elvegezni a tizes szorzas utan
ret_tizesek:
    rts             ;

shift_left:
    XOR r13, r13    ;lenullazzuk a carry regisztert
    MOV r3, #SIZE   ;betoltjuk az utolso byte cimet (+1)
shift_left_loop:
    SUB r3, #1      ;a mutatot egyel visszaallitjuk
    CMP r3, #HALF   ;ha mar a felenel lejjebb tartunk, kilepunk a loopbol, vegeztunk
    JN ret_shift_left ;ha elerjuk az also felet a memorianak, akkor abbahagyjuk
    MOV r12, (r3)   ;betoltjuk az aktualis byte-ot
    SWP r12         ;megcsereljuk az also es felso 4 bitet
    MOV r14, r12    ;elmentjuk r14-ben ezt az erteket
    AND r12, #0xF0  ;also negy byte minket nem erdekel
    OR r12, r13     ;osszevagyoljuk a carryvel, amirol tudjuk, hogy negy bit van benne, raadasul alul
    MOV (r3), r12   ;visszairjuk a memoriaba
    AND r14, #0x0F  ;az elmentett beolvasott felso 4 bitjet tartjuk meg (swp utan vagyunk)
    MOV r13, r14    ;es ezt beleirjuk a carrybe
    JMP shift_left_loop
    
ret_shift_left:
    rts

copy_second_half:
    XOR r3, r3      ;lenullazzuk a mutatot
copy:               ;Memoriaterulet lemasolasa
    MOV r4, r3      ;lemasoljuk az eppen aktualis cimet
    ADD r4, #HALF   ;hozzaadjuk a forras cimehez a memoria felenek nagysagat
    MOV r1, (r4)    ;betoltjuk a forras erteket
    MOV (r3), r1    ;kiirjuk a celba
    ADD r3, #1      ;noveljuk a mutatot
    CMP r3, #HALF   ;ha a felenel tartanank, vegeztunk
    JNZ copy
    rts
    
inner_loop:         ;tudjuk, hogy r0: vegertek, r1: szamoloregiszter
    CMP r0, r1      ;amig nem lesz r0=r1, addig osszeadjuk az eredeti szamot (amit lemasoltunk) onmagahoz
    JZ return
    ADD r1, #1      ;noveljuk a szamoloregisztert
    MOV r7, #1      ;ezt elmentjuk az r7-ben
    jsr inner_inner_loop    ;a belso-belso fgv meghivasa
    JMP inner_loop  ;elejerol ismet
    
return:
    rts             ;visszaterunk a szubrutinbol
    
inner_inner_loop:   ;az osszeadas megvalositasa - a teljes felso felehez hozzaadjuk a teljes also felet egyszer - hasonlit a lemasolashoz
    MOV r2, #SIZE   
    SUB r2, r7
    MOV r14, (r2)
    MOV r5, r2
    SUB r5, #HALF
    MOV r15, (r5)
    jsr addbcd      ;segedfgv, ami r14-ben es r15-ban levo ertekeket az r13 segedregiszter segitsegevel osszeadja
    MOV (r2), r14
    CMP r7, #HALF   ;ha a memoria felenel vagyunk, vegeztunk
    JNN inner_return
    ADD r7, #1      ;noveljuk a szamlalot
    JMP inner_inner_loop
inner_return:
    rts

addbcd:             ;Tudjuk, hogy r14: elso operandus, r15: masodik, r13: carry
    MOV r10, r14    ;elmentjuk 1x
    XOR r11, r11    ;lenullazzuk a statuszregisztert
    MOV r9, r15     ;eltaroljuk r15 erteket
second:
    AND r15, #0x0F
    AND r14, #0x0F  ;also negy bit
    ADD r14, r13    ;hozzaadjuk az elozo carryt az elso operandushoz
    MOV r13, #0     ;nem tudjuk xorolni, mert a carry flag jo, ha megmarad, de nullaznunk kell
    ADC r13, #0     ;az esetleges carryt megorizzuk
    ADD r14, r15    ;osszeadjuk a ket operandust
    ADC r13, #0     ;az esetleges carryt megorizzuk ismet
too_big:
    CMP r14, #10    ;ennel nagyobbegyenlo szam nem lehet BCD
    JV  skip
    ADD r13, #1     ;egyet biztosan kell adni a carryhez
    SUB r14, #10    ;levonunk belole tizet, hogy az egyeseket kapjuk
    JMP too_big
skip:               ;itt mar r14-ben biztosan egy valid, 10 alatti BCD szam van
    CMP r11, #0     ;ha mar egyszer lefutott, akkor vegeztunk, ha ez az elso, akkor megyunk tovabb
    JNZ ret         ;
    ADD r11, #1     ;jelezzuk, hogy egyszer mar eljutottunk ide
    MOV r12, r14    ;az also negy bitet elmentjuk r12-ben, ez mar megvan
    SWP r10         ;r10 bitjeit felcsereljuk
    MOV r14, r10    ;ezt beletoltjuk r14-be
    MOV r15, r9     ;az elmentett r15-ot visszatoltjuk bele (r9-ben volt eddig)
    SWP r15         ;es ennek is megcsereljuk a bitjeit
    JMP second      ;ujrakezdjuk
ret:
    SWP r14         ;felcsereljuk r14 bitjeit, ezzel egy helyiertekkel magasabbra kerul
    OR r14, r12     ;osszeeselve az egyesekkel megkapjuk a szamot magat, ezt r14-ben fogjuk ujra hasznalni
    rts