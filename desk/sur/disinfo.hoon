|%
:: disnfo
::  basically rumors, but no gossip
::
+$  rumor
  $:
    =@t  :: contents
    =@da :: time received
  ==
+$  rumors
  (list rumor)
::
+$  action
  $%
    [%post-rumor =@t]
  ==
--
