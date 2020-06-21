/ip dhcp-client
add default-route-distance=10 dhcp-options=hostname,clientid disabled=no interface=wan1 script=dhcp-ecmp use-peer-dns=no \
    use-peer-ntp=no
add default-route-distance=20 dhcp-options=hostname,clientid disabled=no interface=wan2 script=dhcp-ecmp use-peer-dns=no \
    use-peer-ntp=no
