:: phobos
::  urbit guest authentication prototype
::
/-  store=phobos
/+  phobos, server, schooner
/+  rudder
/+  default-agent, verb, dbug, agentio
/~  pages  (page:rudder guests:store action:store)  /app/phobos/webui
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
++  on-peek
  |=  =path
  ^-  (unit (unit cage))
  ?+    path  (on-peek:def path)
      [%x %get-session @ ~]
    :: expects full session-token as cord
    =;  return  ``noun+!>(return)
    ^-  (unit ship)
    =/  token=@t  i.t.t.path
    :: split by =
    ::    find =
    ?~  tis=(find "=" (trip token))
      :: no = in token
      ~
    :: split
    =/  trimmed  (trim u.tis (trip token))
    :: remove 'phobos-'
    =.  p.trimmed  (slag 7 p.trimmed)
    :: remove '='
    =.  q.trimmed  (slag 1 q.trimmed)
    :: cord to aura
    ?~  ship=(slaw %p (crip p.trimmed))
      ~
    ::
    :: get ship
    ?~  got=(~(get by guests) u.ship)
      :: not in guests
      ~
    :: final token check
    ?~  session-token.u.got
      ~
    ?.  =(u.session-token.u.got token)
      ~
    [~ id.u.got]
  ==
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  (on-poke:def mark vase)
      %handle-http-request
    =;  out=(quip card:agent:gall _guests)
      [-.out this(guests +.out)]
    %.  :+  bowl
          !<(order:rudder vase)
          guests
    %:  (steer:rudder _guests action:store)
      pages
      %:  point:rudder
        /apps/phobos
        | :: not auth by default, auth has to be enforced elseware for some pages
          ::  this is because we need the guest claim endpoint to be publicly accessible,
          ::  plus some interactable test site for use with the new cookie
        ~(key by pages)
      ==
      (fours:rudder guests)
      |=  act=action:store
      ^-  $@  brief:rudder
          [brief:rudder (list card:agent:gall) _guests]
      ?+  -.act
        =^  caz  this
          (on-poke %phobos-action !>(act))
        [~ caz +.state]
          %claim-guest
        :: special case for claim-guest, in order to get return msg
        :: TODO this should be improved,
        :: probably make explicit in /sur/phobos
        :: [~ ~ +.state]
        ?>  =(src.bowl our.bowl)
        ::
        =/  matches=(list guest:store)
          %+  skim  ~(val by guests)
          |=  =guest:store
          ^-  ?
          ?~  invite-code.guest  |
          ?&  =(invite-code.act u.invite-code.guest)
              =(~ time-claimed.guest)
          ==
        ::
        ?~  matches
          :: ['authentication failed' ~ guests]
          'authenticationFailed'
        :: ~&  ['phobos got matche' matches]
        :: just take the first match
        =/  gus=guest:store  i.matches
        =.  time-claimed.gus  [~ now.bowl]
        =.  invite-code.gus  ~
        =/  rng  ~(. og eny.bowl)
        :: =^  sess-raw=@q  rng
        ::   (rads:rng (pow 2 64))
        =/  session-token-val=@ux
            (~(rad og eny.bowl) (pow 2 128))
        =/  session-token=@t
            (make-full-session-token id.gus session-token-val)
            :: %-  crip
            :: "phobos-{<id.gus>}={<session-token-val>}"
        =.  session-token.gus
            [~ session-token]
        =.  guests
          (~(put by guests) id.gus gus)
        [session-token ~ guests]
      ==
    ==
      %phobos-action
    =/  act  !<(action:store vase)
    ?+  -.act  `this
        %create-guest
      ?>  =(src.bowl our.bowl)
      :: edge case, you can technically run out of id's at length=2^16
      :: ~&  [%create-guest act]
      =/  =guest:store  create-new-guest:hc
      =.  tags.guest
        ?~  tags.act  tags.guest
        (~(uni in tags.guest) u.tags.act)
      =.  guests
        %+  ~(put by guests)
        id.guest
        guest
      `this
        %delete-guest
      ?>  =(src.bowl our.bowl)
      =.  guests
        (~(del by guests) id.act)
      `this
        %tag-guest
      ?>  =(src.bowl our.bowl)
      =/  ugu=(unit guest:store)
        (~(get by guests) id.act)
      ?~  ugu
        ~|  'phobos: bad guest id'  !!
      :: ?:  (~(has in tags.u.ugu) tags.act)
      ::   ~&  'phobos: already tagged'
      ::   `this
      =.  tags.u.ugu
        (~(uni in tags.u.ugu) tags.act)
      =.  time-altered.u.ugu
        now.bowl
      =.  guests
        (~(put by guests) id.act u.ugu)
      `this
        %untag-guest
      ?>  =(src.bowl our.bowl)
      =/  ugu=(unit guest:store)
        (~(get by guests) id.act)
      ?~  ugu
        ~|  'phobos: bad guest id'  !!
      =.  tags.u.ugu
          (~(del in tags.u.ugu) tag.act)
      =.  time-altered.u.ugu
        now.bowl
      =.  guests
        (~(put by guests) id.act u.ugu)
      `this
    ==
  ==
++  on-leave  on-leave:def
++  on-agent  on-agent:def
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
:: ++  handle-poke
:: TODO
:::
++  fof
  [404 ~ [%plain "404 - Not Found"]]
::
++  make-full-session-token
  |=  [=@p =@ux]
  %-  crip
  "phobos-{<p>}={<ux>}"
++  handle-http
  |=  [eyre-id=@ta =inbound-request:eyre]
  ^-  (quip card _state)
  :: TODO this is no longer used.
  :: it may be worth binding this to another endpoint,
  :: so that non-browser apps can authenticate
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
      %'POST'
    ?~  body.request.inbound-request
      [(send fof) state]
    =/  are=(unit (map @t @t))
        %+  bind
          (rush q.u.body.request.inbound-request yquy:de-purl:html)
        ~(gas by *(map @t @t))
    ?~  are
      [(send fof) state]
    =/  arm  u.are 
    ::
    ?+  site  [(send fof) state]
      [%apps %phobos ~]
    :: ~&  ['phobos got body stuff' arm]
    :_  state
      (send [200 ~ [%plain "200 - Success"]])
    ==
    ::
      %'GET'
    ?+    site  
      :_  state 
      (send [404 ~ [%plain "404 - Not Found"]])
      ::
        [%apps %phobos ~]
      :_  state
      :: =/  ht
      ::   %-  crip
      ::   %-  en-xml:html
      ::   (page:webui:phobos bowl guests)
      (send [200 ~ [%html 'todo replaceme']])
        [%apps %phobos %claim ~]
      :: ~&  request.inbound-request
      :: ~&  args
      =/  args=(map @t @t)
        (~(gas by *(map @t @t)) args)
      
      ?.  (~(has by args) 'invite-code')
        :: ~&  'phobos: no invite-code in claim'
        :_  state
        (send [403 ~ [%plain "403 - Forbidden"]])
      =/  invite-code=term
        (~(got by args) 'invite-code')
      :: ~&  "phobos: got invite-code {<invite-code>}"
      =/  matches=(list guest:store)
        %+  skim  ~(val by guests)
        |=  =guest:store
        ^-  ?
        ?~  invite-code.guest  |
        ?&  =(invite-code u.invite-code.guest)
            =(~ time-claimed.guest)
        ==
      ::
      ?~  matches
        :: ~&  'phobos: bad invite-code'
        :_  state
        (send [403 ~ [%plain "403 - Forbidden"]])
      :: ~&  ['phobos got matches' matches]
      =/  gus=guest:store  i.matches
      =.  time-claimed.gus  [~ now.bowl]
      =.  invite-code.gus  ~
      =.  guests
        (~(put by guests) id.gus gus)
      :_  state
      (send [200 ~ [%html 'test']])
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
  =^  invite-code-raw=@q  rng
    (rads:rng (pow 2 64))
  =.  invite-code.guest
    :-  ~
    %-  crip
    %+  slag  1
    %-  trip
    %+  scot  %p
    invite-code-raw
  =.  time-created.guest
    now.bowl
  =.  time-altered.guest
    now.bowl
  guest
-- 
