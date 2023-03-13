/-  sur=phobos
=<  [sur .]
=,  sur
|%
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
++  webui
  |%
  ++  flatten-tags
    |=  [tags=(list @t)]
    ^-  cord
    =/  lags=(list tape)
      %+  turn  tags
      |=  t=@t
      (trip t)
    %-  crip
    %-  zing
    %+  join  ", "
    lags
  ++  render-guests
    |=  [=guests]
    ^-  manx
    ;table
      =style  "margin:auto;padding-bottom:2vh;"
      ;thead
        ;tr
          ;td: id
          ;td: handle
          ;td: otp
          ;td: tags
          ;td: session-token
          ;td: time-created
          ;td: time-altered
          ;td: time-claimed
        ==
      ==
      ;tbody
      ;*  %+  turn  ~(val by guests)
        |=  =guest
        ;tr
          ;td: {<id.guest>}
          ;td: {<handle.guest>}
          ;td: {<otp.guest>}
          ;td: {<(flatten-tags tags.guest)>}
          ;td: {<session-token.guest>}
          ;td: {<time-created.guest>}
          ;td: {<time-altered.guest>}
          ;td: {<time-claimed.guest>}
        ==
      ==
    ==
  ++  page
    |=  [=bowl:gall =guests]
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
          :: height-wrapper
          =style  "height:100vh;max-height:100vh"
          ;h1: phobos
          ;p
            ;a(target "_blank", href "https://github.com/assemblycapital/vita/#readme"): README
          ==
          ;hr;
        
          ;div
          :: content
          =style  "overflow:scroll;padding-bottom:128px;"
            ;h3: guests
            ;+  (render-guests guests)
          ==

          ;footer
            :: footer
            =style  "bottom:0;position:fixed;width:100%;background-color:white;"
            ;p
              =style  "margin:4px 0px;"
              ; {<our.bowl>}
            ==
            ;p
              =style  "margin:4px 0px;"
              ; {<now.bowl>}
            ==
            :: assembly capital logo
            ;svg(width "32", height "32", viewbox "0 0 388 194", fill "none", xmlns "http://www.w3.org/2000/svg")
              ;path(d "M194 0H97V97H0V194H97V97H194H291V194H388V97H291V0H194Z", fill "black");
            ==
          ==
        ==
      ==
    ==
  --
--