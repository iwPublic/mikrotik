/ip firewall raw
add action=drop chain=prerouting disabled=yes log=yes log-prefix=blacklisted src-address-list=blacklist
