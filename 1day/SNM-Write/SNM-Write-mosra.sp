*calculate SNM

.include "D:\uni\advanced vlsi\project\Project description and related files\32nm_MGK.pm"

.GLOBAL VDD
.PARAM VDD=0.9V 
.options list post 


.PARAM U=0
.PARAM UL='-VDD/sqrt(2)' 
.PARAM UH='VDD/sqrt(2)' 
.PARAM BITCAP=1E-12

MPL QD QB VDD VDD pmos W=32n L=32n 
MNL QD QB GND GND nmos W=72n L=32n 
MPR QBD Q VDD VDD pmos W=32n L=32n 
MNR QBD Q GND GND nmos W=72n L=32n
MAL BLB WL QBD GND nmos W=36n L=32n 
MAR BL WL QD GND nmos W=36n L=32n

VVDD VDD GND DC=VDD


*****Write***
VBL BL GND PULSE (0 1 0n 5n 5n 40n 100n)
VBLB BLB GND PULSE (1 0 0n 5n 5n 40n 100n)
VWL WL GND PULSE(0 1 0n 1n 1n 75n 200n)

CBLB BLB 0 BITCAP
CBL BL 0 BITCAP


EQ Q VDD VOL='1/sqrt(2)*U+1/sqrt(2)*V(V1)' 
EQB QB 0 VOL='-1/sqrt(2)*U+1/sqrt(2)*V(V2)'
EV1 V1 0 VOL=' U + sqrt(2)*V(QBD)'
EV2 V2 0 VOL='-U + sqrt(2)*V(QD)'
EVD VD 0 VOL='ABS(V(V1) - V(V2))'

.DC U UL UH 0.01

*.PRINT DC V(QD) V(QBD) V(QB) V(Q) V(V1) V(V2)
.PRINT DC V(QB) V(QBD)
***********************mosra model **************************************************

.model p1_ra mosra level=1 tit0=5e-7 titfd=7.5e-10 tittd=1.45e-20 tn=0.25
.appendmodel p1_ra mosra pmos pmos
.mosra reltotaltime='60*60*24'

*************************************************************************************
.tran 1ns 4us uic
.MEASURE DC MAXVD MAX V(VD)
.MEASURE DC SNM param='1/sqrt(2)*MAXVD'
.END