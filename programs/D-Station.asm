#D-Station ; each station listens to a channel in the channle list
:start
clr
btr [virtual-signal=signal-grey] ;wait for polling signal
slp 8
xmov mem1 red ; get channel list
mov r1 mem1[1] ; get pos 1 of the list, change memory position for each channel
btr [virtual-signal=signal-green]
nop
fir r2 r1
fir r3 r1
fir r4 r1
fir r5 r1
beq r2 0 :start ;didnt get a bookign this turn
sst r3 [virtual-signal=signal-P]
:deliver_trains
mov out1 r3
btg [virtual-signal=signal-destination]
clr out
sub r2 1
bgt r2 0 :deliver_trains
jmp :start
