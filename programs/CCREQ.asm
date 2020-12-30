##CCREQ
hlt
:start
clr
:check_inventory
fig r6 [item=wood]
bge r6 1000 :make_req
slp 3600
jmp :check_inventory

:make_req
:load_dict
btr [virtual-signal=signal-grey] ;wait for polling signal
slp 4
xmov mem1 red
nop
xmov mem2 red
:select_channel
blt cnm2 3 :start ; to prevent infinite looping
rnd r7 1 cnm2
floor r7
mov r1 mem2@7
:bid_for_channel
btr [virtual-signal=signal-pink]
mov out1 r1
xmov mem3 red;
clr out
fid r2 mem3 r1
beq r2 1 :got
xceq mem3 mem3 1
xmul mem3 -1
xuni mem2 mem2 mem3
jmp :select_channel

:got
btr [virtual-signal=signal-yellow]
:encode_req ;convert the request to a number
idx r3 mem1 r6 ;dictionary pos of the goods
fig r4 [virtual-signal=signal-L] ;number of locomotives
fig r5 [virtual-signal=signal-W] ;number of wagons

##will be a concatenation of the data
;we need to split into two "pulses" each with 9 usable digits
ssv r1    1000000000 ;1 for the first pulse
mul r5       1000000 ;3 digits for wagons (per train)
add r1 r5
mul r4         1000  ;3 digits for locomotives (per train)
add r1 r4
add r1 r3            ; 3 digits for material ID
mov out1 r1
mov out1 0
;second pulse
ssv r8    2000000000 ;2 for the second pulse
sst r8 r1
;there are 3 unused digits
fig r3 [virtual-signal=signal-station-number]           ;retrieve station number
mul r3 1000
add r8 r3            ;3 digits for req ID
div r6 1000     ;3 digits for thousands of goods requested
add r8 r6

btr [virtual-signal=signal-yellow]
mov out1 r8
mov out1 0
mov r7 0
btr [virtual-signal=signal-green] ;trigger for replies
nop
fir r7 r2
beq r7 0 :start ;no one replied
mov out1 r1
mov out1 0
:wait_for_trains
mov out1 1[virtual-signal=signal-white]
mov out1 r7
mov out1 0
jmp 1
