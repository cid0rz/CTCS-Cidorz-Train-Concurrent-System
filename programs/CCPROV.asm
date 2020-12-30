##CCPROV
hlt
:start
clr
fig r8 [item=wood]
fig r4 [virtual-signal=signal-L] ;number of locomotives
fig r5 [virtual-signal=signal-W] ;number of wagons
mul r4 1000
mul r5 1000000
:load_dict
btr [virtual-signal=signal-grey] ;wait for polling signal
slp 4
xmov mem1 red
idx r3 m1 r8
:wait_comm
btr [virtual-signal=signal-yellow]
slp 9
xmov mem2 red
xmov mem3 mem2
xmod mem3 1000
xceq mem4 mem3 r3 ;select the ones that match material
xflt mem2 mem2 mem4 ;whitelist only matching ones
xsub mem2 r3
xmov mem3 mem2
xmod mem3 1000000
xceq mem3 mem3 r4
xflt mem2 mem2 mem3
xsub mem2 r4
xmov mem3 mem2
xmod mem3 1000000000
xceq mem3 mem3 r5
xflt mem2 mem2 mem3
btr [virtual-signal=signal-yellow] ;?????
nop
xmov mem4 red
xflt mem2 mem4 mem2
xmov mem3 mem2
xmod mem3 1000
xmul mem3 1000
xclt mem3 mem3 r8 ;keep the ones we can fully deliver
xflt mem2 mem2 mem3 ;filter the list

:bid_for_reply
beq cnm2 0 :start ;list empty, restart
rnd r7 1 cnm2
floor r7
mov r1 mem2@7
btr [virtual-signal=signal-cyan]
div r1 r1
mov out1 r1
xmov mem4 red
clr out
fid r2 mem4 r1
beq r2 1 :confirm_order
rnd r7 1 100
bge r7 80 :clean ;20% of the time we cancel the entry in the list
nop
blt red1 0 :start ;no more retries
jmp :bid_for_reply

:clean
mov mem2@7 0
blt red1 0 :start ;no more retries
jmp :bid_for_reply

:confirm_order
:calculate number of trains
fig r4 [virtual-signal=signal-L] ;number of locomotives
fig r5 [virtual-signal=signal-W] ;number of wagons
fig r6 [virtual-signal=signal-station-number]  ;station number
fid r1 mem3 r1 ; items to deliver
div r1 r3 ;number of stacks
div r1 40 ;number of wagons
floor r1
div r1 r5 ;number of trains
ceil r1 ;we always round up for safety
sst r6 r2
fid r7 mem2 r1
btr [virtual-signal=signal-green]
mov out1 r1
mov out1 r6
mov out1 r7
clr out
:wait_for_trains
mov out1 1[virtual-signal=signal-white]
mov out1 r1
mov out1 r7
mov out1 r8
mov out1 0
jmp 1
