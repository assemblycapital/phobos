|%
:: phobos
::  urbit guest authentication prototype
::
+$  guest
  $:
    id=@p
    handle=(unit @t)
    otp=@t
    tags=(list @t)
    session-token=(unit @t)
    time-created=@da
    time-altered=@da
    time-claimed=(unit @da)
  ==
+$  action
  $%
    [%create-guest ~]
    [%tag-guest id=@p tag=@t]
    [%delete-guest id=@p]
    [%claim-guest id=@p otp=@t]
  ==
--
