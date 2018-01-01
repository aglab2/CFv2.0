;overwrite klepto behav with gp bonk

;use behav 5310, model 38(regular door) in tt64
;bparam1 byte to check stars in (12 for c1, 12+X for c1+X)
;bparam2 ignored

.orga 0x21F110 ;behav 0x13005310
.dw  0x00090000
.dd  0x0C00000080310498
.dw  0x102A0800
.dd  0x0400000013000B14
.dw  0x102A0004
.dw  0x110100C9
.dd  0x27260000030156C0
.dw  0x28000000
.dd  0x2A0000000301CE78
.dw  0x2300000000500064
.dw  0x10050000
.dw  0x0E4303E8
.dw  0x2D000000
.dd  0x0C000000802ACC3C
.dw  0x08000000
.dd  0x0C000000802ACAC8
.dw  0x09000000

.orga 0xCB498
.area 0xB0
	LUI V1, 0x8036
	LW V1, 0x1160(V1)
	
;EEPROM offset loader start
	LUI T9, 0x8033
	LH T9, 0xDDF4(T9) ;current file
	LUI T8, 0x8020
	ADDIU T8, T8, 0x7700 ;current eep base
	
warp_fileselectloop:
	SUBI T9, T9, 0x1
	BEQ T9, R0, warp_fileselectend
	NOP
	ADDIU T8, T8, 0x70
	B warp_fileselectloop
	NOP
warp_fileselectend:
	LB T7, 0x0188(V1)
	ADDU T8, T8, T7
;EEPROM offset loader fini

;Make door go to warp 20 - init it is
	ADDIU T7, R0, 0x20
	
	LB T9, 0x0(T8)
	ANDI T9, T9, 0x7F
warp_repeat:
	BEQ T9, R0, warp_fini
	NOP
	ADDIU T7, T7, 1
	SRL T9, T9, 1
	BNE T9, R0, warp_repeat
	NOP	

warp_fini:
	JR RA
	SB T7, 0x0189(V1)
.endarea