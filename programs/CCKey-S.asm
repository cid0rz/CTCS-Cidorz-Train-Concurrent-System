##CCKEY SERVER
:start
clr
mov r8 cng
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
slp
jmp :assign_ch
:allow comm
mov out1 1[virtual-signal=signal-yellow]
mov out1 0
slp 9
xmov mem2 red
xmax r1 mem2




jmp :start
