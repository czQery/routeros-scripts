:local ttl "5m";
:local token "dhcp-to-dns";
:local domain "lan";
:local hosts [:toarray ""];

:local normalize do={
  :local result;
  :local isInvalidChar true;
  :for i from=0 to=([:len $name]-1) do={
    :local char [:pick $name $i];
    :if ($i < 32) do={
      :if ($char~"[a-zA-Z0-9]") do={
        :set result ($result . $char);
        :set isInvalidChar false;
      } else={
        :if (!$isInvalidChar) do={
          :set result ($result . "-");
          :set isInvalidChar true;
        }
      }
    }
  }

  :if ($isInvalidChar) do={
    :set result [:pick $result 0 ([:len $result]-1)];
  }
  :return $result;
}

:foreach lease in [/ip dhcp-server lease find] do={
  :local hostName [/ip dhcp-server lease get value-name=host-name $lease];
  :local hostComment [/ip dhcp-server lease get value-name=comment $lease];
  :local hostIP [/ip dhcp-server lease get value-name=address $lease];
  :local hostMAC [/ip dhcp-server lease get value-name=mac-address $lease];
  :local name;

  :if ([:len $hostComment] > 0) do={:set name $hostComment} else={
    :if ([:len $hostName] > 0) do={
      :set name $hostName;
    } else={
      :set name $hostMAC;
    }
  }

  :set name [$normalize name=$name];

  :local hostDomain "$name.$domain"
  :set hosts ($hosts, $hostDomain);
    
  :if ([:len [/ip dns static find where address=$hostIP comment=$token]] = 0) do={
    /ip dns static add name=$hostDomain address=$hostIP comment=$token ttl=$ttl;
  } else={
    :if ([:len [/ip dns static find where address=$hostIP name=$hostDomain comment=$token]] = 0) do={
      /ip dns static set name=$hostDomain [/ip dns static find address=$hostIP comment=$token];
    }
  }

}

:foreach dnsItem in [/ip dns static find where comment=$token] do={
  :local hostName [/ip dns static get value-name=name $dnsItem];
  :if ([:type [:find $hosts $hostName]] = "nil") do={
    /ip dns static remove $dnsItem;
  }
}
