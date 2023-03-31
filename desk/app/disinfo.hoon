:: disinfo
::  an example phobos app
::  rumors, but using phobos
::
:: /-  store=phobos
/-  store=disinfo
/+  phobos, server
/+  rudder
/+  default-agent, verb, dbug, agentio
/~  pages  (page:rudder rumors:store action:store)  /app/disinfo/webui
=,  format
:: ::
|%
+$  versioned-state
  $%  state-0
  ==
+$  state-0  $:
  %0  =rumors:store
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
++  on-peek   on-peek:def
::
++  on-poke
  |=  [=mark =vase]
  ^-  (quip card _this)
  ?+  mark  (on-poke:def mark vase)
      %handle-http-request
    =;  out=(quip card:agent:gall _rumors)
      [-.out this(rumors +.out)]
    %.  :+  bowl
          !<(order:rudder vase)
          rumors
    %:  (steer:rudder _rumors action:store)
      pages
      %:  point:rudder
        /apps/disinfo
        |  :: not auth by default, auth elsewhere
        ~(key by pages)
      ==
      (fours:rudder rumors)
      |=  act=action:store
      ^-  $@  brief:rudder
          [brief:rudder (list card:agent:gall) _rumors]
      =^  caz  this
        (on-poke %disinfo-action !>(act))
      [~ caz +.state]
    ==
      %disinfo-action
    =/  act  !<(action:store vase)
    ?-  -.act
        %post-rumor
      ?>  =(src.bowl our.bowl)
      ~&  >  ['in post-rumor' act]
      =.  rumors
        :_  rumors
        [t.act now.bowl]
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
++  nil  ~
:::
--