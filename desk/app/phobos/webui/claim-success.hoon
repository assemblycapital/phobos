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
  |^
  =/  validate-guest-result=(unit guest:store)
    validate-guest
  ?~  validate-guest-result
    [%code 403 ~]
  :: =/  authenticated-guest=(guest:store)
  ::   u.validate-guest-result
  ~&  >  ["AUTHENTICATED:" validate-guest-result]
  [%page page]
  :: check cookies for 'phobos' prefix
  :: find first match with from guests
  :: TODO refactor to a library arm and a :phobos scry
  ::
  ++  validate-guest
    ^-  (unit guest:store)
    :: ~&  >>>  header-list.request
      
    ::  are there cookies passed with this request?
    ::   
    ::    TODO: In HTTP2, the client is allowed to put multiple 'Cookie'
    ::    headers.
    ::   
    ?~  cookie-header=(get-header:http 'cookie' header-list.request)
      ~
    :: ~&  >>  u.cookie-header
    ::  is the cookie line is valid?
    ::   
    ?~  cookies=(rush u.cookie-header cock:de-purl:html)
      ~
    ~&  u.cookies
    ?~  got=(get-phobos-cookies u.cookies)
      :: ~&  >>  "missing phobos cookie"
      ~
    =/  phobos=(list [key=@t val=@t])  got
    :: ~&  >  :-  'got phobos cookies'  phobos
    :: foreach phobos cookie, check if guests
    |-  ?~  phobos  ~
    :: get the patp out
    =/  trim  (crip (slag 7 (trip key.i.phobos)))
    ?~  ship=(slaw %p trim)
      $(phobos t.phobos)
    :: ~&  >>  ['cookie for' u.ship]
    ?~  got=(~(get by guests) u.ship)
      :: ~&  >>>  "not in guests"
      $(phobos t.phobos)
    ?~  session-token.u.got
      $(phobos t.phobos)
    :: ~&  >>  [u.session-token.u.got (combine-phobos-cookie i.phobos)]
    :: ~&  >>  =(u.session-token.u.got (combine-phobos-cookie i.phobos))
    ?.  =(u.session-token.u.got (combine-phobos-cookie i.phobos))
      $(phobos t.phobos)
    got
    :: $(phobos t.phobos)

  ++  get-phobos-cookies
    |=  [cookies=(list [key=@t val=@t])]
    ^-  (list [key=@t val=@t])
    %+  skim  cookies
      |=  cookie=[key=@t val=@t]
      =((scag 6 (trip key.cookie)) "phobos")
  ++  combine-phobos-cookie
    |=  cookie=[key=@t val=@t]
    ^-  @t
    %-  crip
    "{(trip key.cookie)}={(trip val.cookie)}"
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
          ;p: test
        ==
      ==
    ==
  --
--