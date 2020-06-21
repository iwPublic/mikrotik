/ip firewall filter
add action=accept chain=forward in-interface-list=LAN out-interface-list=WAN
add action=accept chain=forward connection-state=established,related in-interface-list=WAN out-interface-list=LAN
add action=jump chain=forward connection-state=new disabled=yes in-interface-list=WAN jump-target=scan out-interface-list=LAN \
    tcp-flags=""
add action=accept chain=forward connection-nat-state=dstnat in-interface-list=WAN out-interface-list=LAN
add action=drop chain=forward log=yes log-prefix=last
add action=accept chain=input connection-state=established,related in-interface-list=WAN
add action=accept chain=input dst-port=53,67,123,1900 in-interface-list=!WAN protocol=udp
add action=accept chain=input dst-port=22,53,80,123,443,2828,8291,8728,8729 in-interface-list=!WAN protocol=tcp
add action=jump chain=input connection-state=new disabled=yes in-interface-list=WAN jump-target=scan
add action=reject chain=input in-interface-list=!WAN log=yes log-prefix=lan reject-with=icmp-protocol-unreachable
add action=drop chain=input log=yes log-prefix=last
add action=return chain=scan connection-nat-state=dstnat disabled=yes dst-limit=1,5,src-and-dst-addresses/5s tcp-flags=""
add action=jump chain=scan disabled=yes jump-target=track log-prefix=udp protocol=udp tcp-flags=""
add action=jump chain=scan disabled=yes jump-target=track log-prefix=tcp protocol=tcp tcp-flags=syn
add action=jump chain=scan disabled=yes jump-target=track log-prefix=icmp protocol=icmp tcp-flags=""
add action=add-src-to-address-list address-list=blacklist address-list-timeout=12h chain=track disabled=yes log=yes \
    log-prefix=blacklist src-address-list=2strike
add action=add-src-to-address-list address-list=2strike address-list-timeout=6h chain=track disabled=yes log-prefix=2strike \
    src-address-list=1strike
add action=add-src-to-address-list address-list=1strike address-list-timeout=3h chain=track disabled=yes log-prefix=1strike
