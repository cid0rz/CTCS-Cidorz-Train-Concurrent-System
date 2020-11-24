##CCREQ
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
beq cnm2 0 :start
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
ssv r1    2000000000 ;2 for the second pulse
;there are 3 unused digits


fig r3 [virtual-signal=signal-station-number]           ;retrieve station number
mul r3 1000
add r1 r3            ;3 digits for req ID
div r6 1000     ;3 digits for thousands of goods requested
add r1 r6

btr [virtual-signal=signal-yellow]
mov out1 r1
mov out1 0
hlt
btr [virtual-signal=signal-cyan](trigger for replies)
fir r1 r2



:calculate number of trains
fid r1 mem1 r5 ;get stack size
div r5 r1 ;number of stacks
div r5 40 ;number of wagons
floor r5
div r5 r4 ;number of trains
ceil r5 ;we always round up for safety
