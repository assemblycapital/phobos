/-  sur=phobos
=<  [sur .]
=,  sur
|%
::
++  peek-get-session
  |=  [=bowl:gall token=@t]
  .^((unit @p) %gx /(scot %p our.bowl)/phobos/(scot %da now.bowl)/get-session/[token]/noun)
++  scry-validate-guest
  |=  [=bowl:gall =request:http]
  ^-  (unit ship)
  :: assumes we dont have access to full guests, most apps wont
  ?~  cookie-header=(get-header:http 'cookie' header-list.request)
    ~
  :: ~&  >>  u.cookie-header
  ::  is the cookie line is valid?
  ::   
  ?~  cookies=(rush u.cookie-header cock:de-purl:html)
    ~
  :: ~&  u.cookies
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
  :: ~&  [our.bowl now.bowl i.phobos]
  =/  user
    (peek-get-session bowl (combine-phobos-cookie i.phobos))
  :: ~&  >>  user
  ?~  user
    $(phobos t.phobos)
  user
::
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
++  enjs
  =,  enjs:format
  |%
  ++  action
    |=  act=^action
    ^-  json
    ~
  --
++  unit-ship
    |=  who=(unit @p)
    ^-  json
    ?~  who
      ~
    [%s (scot %p u.who)]
++  set-ship
  |=  ships=(set @p)
  ^-  json
  :-  %a
  %+  turn
    ~(tap in ships)
    |=  her=@p
    [%s (scot %p her)]
::
++  dejs
  =,  dejs:format
  |%
  ++  patp
    (su ;~(pfix sig fed:ag))
  ++  action
    |=  jon=json
    ^-  ^action
    *^action
  --
--