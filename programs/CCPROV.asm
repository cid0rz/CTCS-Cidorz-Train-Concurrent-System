##CCPROV
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
mov out1 1[virtual-signal=signal-yellow]
mov out1 0
xmov mem4 red
xflt mem2 mem4 mem2
xmov mem3 mem2
xmod mem3 1000
xmul mem3 1000
xclt mem3 mem3 r8 ;keep the ones we can fully deliver
xflt mem2 mem2 mem3 ;filter the list
beq cnm2 0 :start ;list empty, restart
xdiv mem4 mem2 mem2
:bid_for_reply
rnd r7 1 cnm2
floor r7
btr [virtual-signal=signal-cyan]
blt red1 0 :start ;no more retries
mov out1 mem4@7
fir r2 mem4@7


:bid_for_channel
btr [virtual-signal=signal-pink]
mov out1 r1
fir r2 r1
clr out
beq r2 1 :got
rnd r7 1 100
blt r7 50 :start ;we skip this turn
jmp :bid_for_channel

:got
btr [virtual-signal=signal-yellow]

