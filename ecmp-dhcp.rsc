/system script
add dont-require-permissions=no name=dhcp-ecmp owner=admin policy=read,write source=":local wan1Gateway; \\\r\
    \n:local wan2Gateway; \\\r\
    \n:local wan1Gateway [/ip dhcp-client get [find interface=\"wan1\"] gateway]; \\\r\
    \n:local wan2Gateway [/ip dhcp-client get [find interface=\"wan2\"] gateway]; \\\r\
    \n:local gateway;\\\r\
    \n:if (\$wan1Gateway!=nothing and \$wan2Gateway!=nothing) \\\r\
    \n do={:set gateway value=\"\$wan1Gateway,\$wan2Gateway\"};\\\r\
    \n:if (\$wan1Gateway!=nothing and \$wan2Gateway=nothing) \\\r\
    \n do={:set gateway value=\$wan1Gateway}; \\\r\
    \n:if (\$wan1Gateway=nothing and \$wan2Gateway!=nothing) \\\r\
    \n do={:set gateway value=\$wan2Gateway}; \\\r\
    \n:put [/ip route set [find comment=ecmp] dst-address=0.0.0.0/0 gateway=\$gateway]"

/ip dhcp-client
add default-route-distance=10 dhcp-options=hostname,clientid disabled=no interface=wan1 script=dhcp-ecmp use-peer-dns=no \
    use-peer-ntp=no
add default-route-distance=20 dhcp-options=hostname,clientid disabled=no interface=wan2 script=dhcp-ecmp use-peer-dns=no \
    use-peer-ntp=no

/routing filter
add chain=dynamic-in distance=10 set-check-gateway=ping set-distance=10 set-routing-mark=isp1
add chain=dynamic-in distance=20 set-check-gateway=ping set-distance=10 set-routing-mark=isp2

/ip route
add distance=1 dst-address=192.168.0.0/16 gateway=lan1 routing-mark=isp1
add distance=1 dst-address=192.168.0.0/16 gateway=lan1 routing-mark=isp2

/ip firewall mangle
add action=fasttrack-connection chain=prerouting connection-state=established disabled=yes
add action=jump chain=prerouting connection-mark=no-mark in-interface-list=WAN jump-target=ecmp disabled=yes 
add action=mark-connection chain=ecmp in-interface=wan1 new-connection-mark=isp1 passthrough=no disabled=yes
add action=mark-connection chain=ecmp in-interface=wan2 new-connection-mark=isp2 passthrough=no disabled=yes
add action=jump chain=prerouting connection-mark=!no-mark jump-target=route-mark disabled=yes
add action=mark-routing chain=route-mark connection-mark=isp1 new-routing-mark=isp1 passthrough=no disabled=yes
add action=mark-routing chain=route-mark connection-mark=isp2 new-routing-mark=isp2 passthrough=no disabled=yes
