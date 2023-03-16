::  phobos index
::
/-  store=phobos
/+  rudder
::
^-  (page:rudder guests:store action:store)
::
|_  [=bowl:gall order:rudder =guests:store]
  ++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder action:store)
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  what=(~(get by args) 'what')
    ~
  ?~  who=(slaw %p (~(gut by args) 'who' ''))
    'invalid ship name'
  |^  ?+  u.what  'say what now'
          %create-guest
        [%create-guest ~]
      ==
    ++  nil  ~
  --
++  final  (alert:rudder url.request build)
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  ::
  :: =/  rel=role
  ::   =/  a  (~(gas by *(map @t @t)) arg)
  ::   =/  r  (~(gut by a) 'rel' %all)
  ::   ?:(?=(role r) r %all)
  :: =/  tag=(set @ta)
  ::   %-  sy
  ::   %+  murn  arg
  ::   |=  [k=@t v=@t]
  ::   ?:(=('tag' k) (some v) ~)
  ::
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
          :: height-wrapper
          =style  "height:100vh;max-height:100vh"
          ;h1: phobos
          ;p: testing rudder
        ::  ;p
        ::    ;a(target "_blank", href "https://github.com/assemblycapital/vita/#readme"): README
        ::  ==
        ::  ;hr;
          ;button: create new invite
        
          ;div
          :: content
          =style  "overflow:scroll;padding-bottom:128px;"
            :: ;h3: guests
            ;+  render-guests
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
    ^-  manx
    ;table
      =style  "margin:auto;padding-bottom:2vh;text-align:center;font-family:monospace;"
      ::
      ;thead
        =style  "font-weight: bold;"
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
        |=  =guest:store
        ;tr
          ;td: {<(crip (scag 6 (slag 8 (trip (scot %p id.guest)))))>}
          ;td: {<handle.guest>}
          ;td: {<otp.guest>}
          ;td.tags
            ;form(method "post")
              ;input(type "hidden", name "who", value "{(scow %p id.guest)}");
              ;input(type "text", name "tag", placeholder "new tag");
            ==
            ;span: {<(flatten-tags tags.guest)>}
          ==
          ;td: {<session-token.guest>}
          ;td: {<time-created.guest>}
          ;td: {<time-altered.guest>}
          ;td: {<time-claimed.guest>}
        ==
      ==
    ==
--
--