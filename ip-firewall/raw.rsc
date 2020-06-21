/ip firewall raw
add action=drop chain=prerouting disabled=yes log-prefix=tcp-null port=0 protocol=tcp
add action=drop chain=prerouting disabled=yes in-interface-list=WAN log=yes log-prefix=spoof src-address-list=_NotPublic
add action=drop chain=prerouting disabled=yes log=yes log-prefix=blacklisted src-address-list=blacklist
