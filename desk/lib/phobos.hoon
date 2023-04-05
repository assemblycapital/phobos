/-  sur=phobos
=<  [sur .]
=,  sur
|%
:: this should probably be renamed, as should the actual scry endpoint
::
++  peek-get-session
  |=  [=bowl:gall token=@t]
  .^((unit @p) %gx /(scot %p our.bowl)/phobos/(scot %da now.bowl)/get-session/[token]/noun)
::
::
:: should this be renamed?
:: should this return `our.bowl` if authenticated.request?
:: then it could be used more generically for auth.
++  scry-validate-guest
  |=  [=bowl:gall =request:http]
  ^-  (unit ship)
  ?~  cookie-header=(get-header:http 'cookie' header-list.request)
    ~
  ::  is the cookie line is valid?
  ?~  all-cookies=(rush u.cookie-header cock:de-purl:html)
    ~
  ?~  got=(get-phobos-cookies u.all-cookies)
    ~
  :: TODO rename from phobos to phobos-cookies or something
  :: This is only a list because browsers might have multiple, and
  :: its good to check all of them. This is common in dev environment or admin experimentation.
  :: Its probably less common for actual users, but would still be good to have.
  =/  phobos=(list [key=@t val=@t])  got
  :: foreach phobos cookie, check if its valud for guests
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
:: this is just some boilerplate for a more fleshed out json interface in the future
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