#!/bin/sh

opkg update
opkg list-upgradable | cut -f 1 -d ' ' | xargs opkg upgrade

opkg install luci-ssl luci-app-nlbwmon

opkg remove wpad-basic
opkg install kmod-batman-adv wpad-mesh-openssl
