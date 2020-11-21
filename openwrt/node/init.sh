#!/bin/sh

random_key() {
    tr -dc A-NP-Za-km-z2-9 </dev/urandom | head -c ${1:-16}
}

echo "Setting hostname";
uci set system.@system[0].hostname="mesh-node-$(random_key 4)";

echo "Basic configuration";
uci set network.lan.gateway="192.168.1.1";
uci set network.lan.ipaddr="192.168.1.4";
uci add_list dhcp.@dnsmasq[0].server="192.168.1.1";
uci set batmand.general.interface="bat0";
uci set dhcp.lan.ignore=1;

echo "Removing unneeded things";
rm /etc/config/fm;
rm -rf /freemesh/;
/etc/init.d/fmstartup disable;
rm /etc/init.d/fmstartup;

/etc/init.d/firewall disable;
/etc/init.d/dnsmasq disable;
/etc/init.d/uhttpd disable;
rm /etc/init.d/firewall;
rm /etc/init.d/dnsmasq;
rm /etc/init.d/uhttpd;
rm /etc/config/firewall;
rm /etc/firewall.user;
rm /etc/config/dhcp;
rm /etc/config/uhttpd;

echo "Committing";
uci commit;

# Set Wifi LEDs to be on and steady.
echo "Setting LEDs";
echo "none" > /sys/class/leds/mt76-phy0/trigger;
echo "none" > /sys/class/leds/zbt-we826\:green\:wifi/trigger;
echo 1 > /sys/class/leds/mt76-phy0/brightness;
echo 1 > /sys/class/leds/zbt-we826\:green\:wifi/brightness;

reboot;
