##CCMAIN SERVER
:reset
clr
:main_loop
mov out1 1[virtual-signal=signal-grey] ;start of loop signal
clr out
:send_dict
xmov out green
clr out
hlt
