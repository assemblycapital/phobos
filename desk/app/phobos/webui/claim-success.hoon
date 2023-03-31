::  phobos /claim
::
::
/-  store=phobos
/+  rudder, server, phobos
::
^-  (page:rudder guests:store action:store)
::
|_  [=bowl:gall order:rudder =guests:store]
  ++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder action:store)
  'Nothing to see here.'
++  final  (alert:rudder url.request build)
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  ?~  who=(scry-validate-guest:phobos bowl request)
    [%code 403 ~]
  ~&  >  ["AUTHENTICATED:" u.who]
  |^
  [%page page]
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"phobos"
        ;style:"body \{ text-align: center; margin:0;}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
      ==
      ;body
        ;div
          ;h1: phobos claim
          ;p: successfully authenticated!
          ;p: welcome {<u.who>}
        ==
      ==
    ==
  --
--