:: phobos
::  urbit guest authentication prototype
::
/-  store=phobos
/+  phobos, server, schooner
/+  default-agent, verb, dbug, agentio
=,  format
:: ::
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  $:
  %0  =guests:store
  ==
+$  card     card:agent:gall
--
%+  verb  &
%-  agent:dbug
=|  state-0
=*  state  -
^-  agent:gall
=<
|_  =bowl:gall
+*  this  .
    def   ~(. (default-agent this %|) bowl)
    hc    ~(. +> bowl)
    io    ~(. agentio bowl)
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  (on-poke:def mark vase)
      %handle-http-request
    =^  cards  state
      (handle-http:hc !<([@ta =inbound-request:eyre] vase))
    [cards this]
      %phobos-action
    =/  act  !<(action:store vase)
    ?-  -.act
        %create-guest
      ?>  =(src.bowl our.bowl)
      ::TODO edge case, you can technically run out of id's at length=2^16
      =/  =guest:store  create-new-guest:hc
      =.  guests
        %+  ~(put by guests)
        id.guest
        guest
      `this
        %tag-guest
      ?>  =(src.bowl our.bowl)
      =/  ugu=(unit guest:store)
        (~(get by guests) id.act)
      ?~  ugu
        ~|  'phobos: bad guest id'  !!
      =.  tags.u.ugu
        :-  tag.act
        tags.u.ugu
      =.  time-altered.u.ugu
        now.bowl
      =.  guests
        (~(put by guests) id.act u.ugu)
      `this
        %delete-guest
      ?>  =(src.bowl our.bowl)
      =.  guests
        (~(del by guests) id.act)
      `this
    ==
  ==
++  on-leave  on-leave:def
++  on-agent  on-agent:def
++  on-peek   on-peek:def
++  on-fail   on-fail:def
++  on-load   on-load:def
  :: |=  old-state=vase
  :: ^-  (quip card _this)
  :: =/  old  !<(versioned-state old-state)
  :: :: ::
  :: `this(state old)
++  on-save
  ^-  vase
  !>(state)
++  on-init
  ^-  (quip card _this)
  :_  this
  :-  [%pass /eyre/connect %arvo %e %connect [~ /apps/[dap.bowl]] dap.bowl]
  ~
++  on-arvo
  |=  [=wire =sign-arvo]
  ^-  (quip card _this)
  `this
++  on-watch
  |=  =path
  ^-  (quip card _this)
  ?+    path  (on-watch:def path) 
      [%http-response *]
    `this
  ==
--
:: ::
:: :: helper core
:: ::
|_  bowl=bowl:gall
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^-  (quip card _state)
  =/  ,request-line:server
    (parse-request-line:server url.request.inbound-request)
  =+  send=(cury response:schooner eyre-id)
  ?.  authenticated.inbound-request
    :_  state
    %-  send
    [302 ~ [%login-redirect './apps/phobos']]
  ::           
  ?+    method.request.inbound-request 
    [(send [405 ~ [%stock ~]]) state]
    ::
      %'GET'
    ?+    site  
      :_  state 
      (send [404 ~ [%plain "404 - Not Found"]])
      ::
        [%apps %phobos ~]
      :_  state
      =/  ht
        %-  crip
        %-  en-xml:html
        (page:webui:phobos bowl guests)
      (send [200 ~ [%html ht]])
    ==
  ==
++  create-random-botnet-moon
  |=  rng=_~(. og eny.bowl)
  ^-  [ship _rng]
  :: get random 16bit value
  :: ~botnet-[inner-id]-[our.bowl]
  =^  inner-id=ship  rng  (rads:rng (pow 2 16))
  :: format a tape patp
  =/  inner-id-no-sig=tape  (slag 1 (trip (scot %p inner-id)))
  =/  our-no-sig=tape  (slag 1 (trip (scot %p our.bowl)))
  =/  random-botnet-moon=tape
    ?:  =(%czar (clan:title our.bowl))
      "~botnet-{inner-id-no-sig}-dozzod-doz{our-no-sig}"
    ?:  =(%king (clan:title our.bowl))
      "~botnet-{inner-id-no-sig}-dozzod-{our-no-sig}"
    ?:  =(%duke (clan:title our.bowl))
      "~botnet-{inner-id-no-sig}-dozzod-{our-no-sig}"
    ~|  'only planets and higher can create phobos guests'
    !!
  :: slaw
  =/  us=(unit ship)  (slaw %p (crip random-botnet-moon))
  ?~  us  !!
  :-  u.us  rng
++  create-new-guest
  :: performance is bad after a few thousand guests
  :: doesnt matter for prototype, but should solve later
  ^-  guest:store
  :: get set of existing guest ships
  =/  existing-guests=(set ship)
    %-  %~  gas  in  *(set ship)
    %+  turn  ~(val by guests)
    |=  =guest:store
    id.guest
  :: get random guest id
  ::  (botnet prefix)
  ::   until not in set
  =/  rng  ~(. og eny.bowl)
  =^  new-guest-id=ship  rng
      (create-random-botnet-moon rng)
  =.  new-guest-id
    |-
    ?:  (~(has in existing-guests) new-guest-id)
      =^  res  rng  (create-random-botnet-moon rng)
      $(new-guest-id res)
    new-guest-id
  ::
  ::
  :: initialize guest
  =|  =guest:store
  =.  id.guest
    new-guest-id
  =^  otp-raw=@q  rng
    (rads:rng (pow 2 64))
  =.  otp.guest
    %-  crip
    %+  slag  1
    %-  trip
    %+  scot  %p
    otp-raw
  =.  time-created.guest
    now.bowl
  =.  time-altered.guest
    now.bowl
  guest
-- 
