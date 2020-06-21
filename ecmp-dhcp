:local status [/ip dhcp-client get [find interface="wan1"] status];\
:if ($status="bound") \
 do={:global wan1Gateway [/ip dhcp-client get [find interface="wan1"] gateway];} \
 else={:set wan1Gateway value=""]}; \

:local wan1Gateway; \
:local wan2Gateway; \
:local wan1Gateway [/ip dhcp-client get [find interface="wan1"] gateway]; \
:local wan2Gateway [/ip dhcp-client get [find interface="wan2"] gateway]; \
:local gateway;\
:if ($wan1Gateway!=nothing and $wan2Gateway!=nothing) \
 do={:set gateway value="$wan1Gateway,$wan2Gateway"};\
:if ($wan1Gateway!=nothing and $wan2Gateway=nothing) \
 do={:set gateway value=$wan1Gateway}; \
:if ($wan1Gateway=nothing and $wan2Gateway!=nothing) \
 do={:set gateway value=$wan2Gateway}; \
:put [/ip route set [find comment=ecmp] dst-address=0.0.0.0/0 gateway=$gateway]
