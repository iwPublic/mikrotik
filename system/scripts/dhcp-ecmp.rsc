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
