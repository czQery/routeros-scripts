:local host "1.1.1.1";
:local interval 1;
:local minLength 10;

:while (true) do={
    :if ([/ping $host interval=1 count=1] = 0) do={
        :local loop true;
        :local counter 0;

        :while ($loop) do={
            :if ([/ping $host interval=1 count=1] != 0) do={
                :if (counter > $minLength) do={
                    :log warning ("Internet outage: $counter s");
                }
                :set loop false;
            } else {
                :if (counter > $minLength) do={
                    :beep frequency=770 length=50ms;
                }
            }
            :set counter ($counter + 1);
            :delay "1s";
        }
    } else {
        :delay $interval;
    }
}