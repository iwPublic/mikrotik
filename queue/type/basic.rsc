/queue type
add kind=pcq name=pcq-dst pcq-classifier=dst-address pcq-dst-address6-mask=64 pcq-limit=8KiB pcq-src-address6-mask=64 \
    pcq-total-limit=4096KiB
add kind=pcq name=pcq-src pcq-classifier=src-address pcq-dst-address6-mask=64 pcq-limit=8KiB pcq-src-address6-mask=64 \
    pcq-total-limit=4096KiB
add kind=pcq name=pcq-src-dst pcq-classifier=src-address,dst-address pcq-limit=8KiB pcq-total-limit=8096KiB
