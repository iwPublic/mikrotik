/routing filter
add chain=dynamic-in distance=10 set-check-gateway=ping set-distance=10 set-routing-mark=isp1
add chain=dynamic-in distance=20 set-check-gateway=ping set-distance=10 set-routing-mark=isp2
