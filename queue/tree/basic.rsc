/queue tree
add name=OUT packet-mark=no-mark parent=ether1 queue=pcq-dst
add name=IN packet-mark=no-mark parent=ether2 queue=pcq-src
