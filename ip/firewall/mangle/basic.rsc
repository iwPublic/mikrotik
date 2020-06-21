/ip firewall mangle
add action=fasttrack-connection chain=prerouting connection-state=established disabled=yes
