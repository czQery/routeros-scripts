routeros-scripts
============

## internet-checker.rsc
- RouterOS Script for checking internet connection
- Every second it pings `$host`, and if the server doesn't respond within the set time (`$minLength`), the router beeps and prints the time of the outage to the log.

## wol-all.rsc
- sends WOL packet to all devices in network

## dhcp-to-dns.rsc
- Adds DNS entry for every DHCP lease
- Create 5min (or what you want) scheduler for this script to keep the DNS up to date