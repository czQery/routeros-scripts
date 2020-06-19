:local FILE "ping";
:local ALL true;
:while ($ALL) do={
:local HOST "77.75.75.172";
:local TIME ([/system clock get time]);
:local DATE ([/system clock get date]);
:local LOOP true;
:local COUNTER 0;
:if ([/ping $HOST interval=1 count=1] = 0) do={

:while ($LOOP) do={
:delay 1s;
:beep frequency=770 length=50ms;
:set COUNTER ($COUNTER + 1);
:if ([/ping $HOST interval=1 count=1] = >1) do={:set LOOP false;}
}

:log error "INTERNET DOWN ($COUNTER s)";
} else {
:delay 1s;
}
}
