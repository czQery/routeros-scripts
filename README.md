routeros-scripts
============

## ping.rsc
- RouterOS Script for checking internet connection
- It pings $HOST every second, and when the server does not respond, it logs it and starts beeping

## wol-all.rsc
- sends WOL packet to all devices in network

## dhcp-to-dns.rsc
- Adds DNS entry for every DHCP lease
- Create 5min (or what you want) scheduler for this script to keep the DNS up to date