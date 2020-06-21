/ip firewall mangle
add action=jump chain=prerouting connection-mark=no-mark in-interface-list=WAN jump-target=ecmp disabled=yes 
add action=mark-connection chain=ecmp in-interface=wan1 new-connection-mark=isp1 passthrough=no disabled=yes
add action=mark-connection chain=ecmp in-interface=wan2 new-connection-mark=isp2 passthrough=no disabled=yes
add action=jump chain=prerouting connection-mark=!no-mark jump-target=route-mark disabled=yes
add action=mark-routing chain=route-mark connection-mark=isp1 new-routing-mark=isp1 passthrough=no disabled=yes
add action=mark-routing chain=route-mark connection-mark=isp2 new-routing-mark=isp2 passthrough=no disabled=yes
