auto lo
iface lo inet loopback

auto eth0
allow-hotplug eth0
iface eth0 inet dhcp

auto eth1
allow-hotplug eth1
iface eth1 inet manual
    pre-up ip link set $IFACE up
    post-down ip link set $IFACE down