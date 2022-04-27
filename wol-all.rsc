:log warning "Sending WOL broadcast!"
/ip dhcp-server lease
:foreach i in=[find] do={
    :tool wol interface=LAN-BRIDGE mac=[get $i mac-address]
    :log info ("Sending WOL to device: ".[get $i mac-address]."  ".[get $i host-name])
}