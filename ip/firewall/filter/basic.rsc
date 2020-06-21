/ip firewall filter
add action=accept chain=forward in-interface-list=LAN out-interface-list=WAN
add action=accept chain=forward connection-state=established,related in-interface-list=WAN out-interface-list=LAN
add action=accept chain=forward connection-nat-state=dstnat in-interface-list=WAN out-interface-list=LAN
add action=drop chain=forward log=yes log-prefix=last
add action=accept chain=input connection-state=established,related in-interface-list=WAN
add action=accept chain=input dst-port=53,67,123,1900 in-interface-list=!WAN protocol=udp
add action=accept chain=input dst-port=22,53,80,123,443,2828,8291,8728,8729 in-interface-list=!WAN protocol=tcp
add action=reject chain=input in-interface-list=!WAN log=yes log-prefix=lan reject-with=icmp-protocol-unreachable
add action=drop chain=input log=yes log-prefix=last
