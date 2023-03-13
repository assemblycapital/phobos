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
  ++  page
    |=  [=bowl:gall]
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
            ;p: TODO
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