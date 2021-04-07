#!/bin/sh

opkg update;
opkg list-upgradable | cut -f 1 -d ' ' | xargs opkg upgrade;

rm /etc/config/fm;
rm -rf /freemesh/;
/etc/init.d/fmstartup disable;
rm /etc/init.d/fmstartup;

/etc/init.d/uhttpd disable;
rm /etc/init.d/uhttpd;

/etc/init.d/batmand disable;
rm /etc/init.d/batmand;

reboot;
