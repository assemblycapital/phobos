|%
:: phobos
::  urbit guest authentication prototype
::
+$  guest
  $:
    username=@p
    otp=@t
    issued=@da
    tags=(list @t)
    claimed=(unit @da)
    session-token=@t
  ==
+$  action
  $%
    [%create-guest ~]
    [%tag-guest tag=@t]
    [%delete-guest username=@p]
    [%claim-guest otp=@t]
  ==
--
