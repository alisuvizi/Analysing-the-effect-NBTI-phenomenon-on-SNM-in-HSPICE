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

*****Read****
VWL WL GND PULSE(1 0 0n 1n 1n 30n 1200n) 
.IC V(BL)=VDD
.IC V(BLB)=VDD


CBLB BLB 0 BITCAP
CBL BL 0 BITCAP


EQ Q 0 VOL='1/sqrt(2)*U+1/sqrt(2)*V(V1)' 
EQB QB 0 VOL='-1/sqrt(2)*U+1/sqrt(2)*V(V2)'
EV1 V1 0 VOL=' U + sqrt(2)*V(QBD)'
EV2 V2 0 VOL='-U + sqrt(2)*V(QD)'
EVD VD 0 VOL='ABS(V(V1) - V(V2))'

.DC U UL UH 0.01

*.PRINT DC V(QD) V(QBD) V(QB) V(Q) V(V1) V(V2)
.PRINT DC V(QB) V(QBD)

.MEASURE DC MAXVD MAX V(VD)
.MEASURE DC SNM param='1/sqrt(2)*MAXVD'
.END