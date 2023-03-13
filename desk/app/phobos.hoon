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
  %0  guests=(list guest:store)
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
      `this
        %tag-guest
      ?>  =(src.bowl our.bowl)
      `this
        %delete-guest
      ?>  =(src.bowl our.bowl)
      `this
        %claim-guest
      ?>  =(src.bowl our.bowl)
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
        (page:webui:phobos bowl)
      (send [200 ~ [%html ht]])
    ==
  ==
-- 
