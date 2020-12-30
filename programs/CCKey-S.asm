##CCKEY SERVER
:start
clr
btr [virtual-signal=signal-grey]
slp 5
xmov out green
clr out
slp 5
:assign_ch
mov out1 1[virtual-signal=signal-pink]
mov out1 0
xmov mem1 red
xmax r1 mem1
ble r1 1 :allow_comm
slp 16
jmp :assign_ch
:allow_comm
mov out1 1[virtual-signal=signal-yellow]
mov out1 0
;test
slp 8
xmov mem2 red
beq cnm2 0 :wait
slp 58
mov out1 1[virtual-signal=signal-yellow]
mov out1 0
slp 36
:verify
mov out1 1[virtual-signal=signal-cyan]
mov out1 0
slp 1
xmov mem2 red
xmax r1 mem2
beq r1 1 :confirm
inc r8
bge r8 10 :end_v
slp 5
jmp :verify
:end_v
mov out1 -1[virtual-signal=signal-cyan]
clr out

:confirm
slp 10
mov out1 1[virtual-signal=signal-green]
mov out1 0
;xmov mem3 red
jmp :start

:wait
slp 100
mov out1 [virtual-signal=signal-white]
clr out
jmp :start
