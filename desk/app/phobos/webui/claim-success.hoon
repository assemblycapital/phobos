::  phobos /claim
::
::
/-  store=phobos
/+  rudder, server
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
  :: TODO validate cookie, if invalid redir to claim
  
    
  ::  are there cookies passed with this request?
  ::   
  ::    TODO: In HTTP2, the client is allowed to put multiple 'Cookie'
  ::    headers.
  ::   
  ?~  cookie-header=(get-header:http 'cookie' header-list.request)
    [%code 404 ~]
  ::  is the cookie line is valid?
  ::   
  ?~  cookies=(rush u.cookie-header cock:de-purl:html)
    [%code 404 ~]
  ~&  u.cookies

  |^  [%page page]
  ::
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
        ==
      ==
    ==
  --
--