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
::
:: you usually want to avoid having a map where
::   the key is a part of the value
:: but in this case I'm considering it OK
+$  guests  (map @p guest)
+$  action
  $%
    [%create-guest ~]
    [%tag-guest id=@p tag=@t]
    [%delete-guest id=@p]
  ==
--
