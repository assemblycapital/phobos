::  phobos index
::
:: this is my first time using rudder,
:: much of the code uses ~paldev/pals as a reference
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
  ?.  authenticated
    'phobos index argue: unauthorized'
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  head=(~(get by args) 'head')
    ~
  
  :: ~&  >  ['got args' args]
  |^  ?+  u.head  'invalid action head'
          %create-guest
        [%create-guest get-tags]
          %delete-guest
        ?~  who=(slaw %p (~(gut by args) 'who' ''))
          'invalid ship name'
        [%delete-guest u.who]
          %tag-guest
        =/  tags  get-tags
        ?~  tags  'no tags'
        ?~  who=(slaw %p (~(gut by args) 'who' ''))
          'invalid ship name'
        [%tag-guest u.who u.tags]
          %untag-guest
        =+  tag=(~(gut by args) 'tag' '')
        ?~  who=(slaw %p (~(gut by args) 'who' ''))
          'invalid ship name'
        [%untag-guest u.who tag]
      ==
    ++  get-tags
      :: from ~paldev/pals
      ^-  (unit (set @ta))
      %+  rush  (~(gut by args) 'tags' '')
      %+  cook
        |=(s=(list @ta) (~(del in (~(gas in *(set @ta)) s)) ''))
      (more (ifix [. .]:(star ace) com) urs:ab)
  --
++  final  (alert:rudder url.request build)
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  ?.  authenticated
    [%auth url.request]
  |^  [%page page]
  ::
  ++  style
    '''
    p { max-width: 50em; }

    form {
      display: inline-block;
      margin: 0;
      padding: 0;
    }

    button {
      padding: 0.2em 0.5em;
    }
    '''
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"phobos"
        ;style:"body \{ text-align: center; margin:0;}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        ;style:"{(trip style)}"
      ==
      ;body
        ;div
          :: height-wrapper
          =style  "height:100vh;max-height:100vh"
          ;h1: phobos
          ;form(method "post")
            ;input(type "hidden", name "head", value "create-guest");
            ;input(type "text", name "tags", placeholder "some, tags", autocomplete "off");
            ;input(type "submit", value "new");
          ==
        
          ;div
          :: content
          =style  "overflow:scroll;padding-bottom:128px;"
            :: ;h3: guests
            ;+  render-guests
          ==
        ==
      ==
    ==
  ++  render-tags
    |=  [who=@p tags=(set @t)]
    ^-  manx
    ;span
      ;*  %+  turn  ~(tap in tags)
      |=  tag=@t
      ;span
        =style  "display:inline-block;margin-left:0.4rem;border: 1px solid gray; border-radius: 2px;"
        ;span
          =style  "margin:0rem 0.2rem;"
          ; {(trip tag)}
        ==
        ;form(method "post")
          ;input(type "hidden", name "head", value "untag-guest");
          ;input(type "hidden", name "tag", value "{(trip tag)}");
          ;input(type "hidden", name "who", value "{(scow %p who)}");
          ;input(type "submit", value "x");
        == 
      ==
    ==
  ++  render-guests
    ^-  manx
    ;table
      =style  "margin:auto;padding-bottom:2vh;text-align:center;font-family:monospace;"
      ::
      ;thead
        =style  "font-weight: bold;"
        ;tr
          ;td: id
          ;td: tags
          ;td: handle
          ;td: invite-code
          ;td: session-token
          ;td: time-created
          ;td: time-altered
          ;td: time-claimed
        ==
      ==
      ;tbody
      ;*  %+  turn
              %+  sort  ~(val by guests)
              |=  [a=guest:store b=guest:store]
              ^-  ?
              (gth time-altered.a time-altered.b)
        |=  =guest:store
        ;tr
          ;td
            =style  "white-space:nowrap;"
            ;form(method "post")
              =style  "margin-right:2px;"
              ;input(type "hidden", name "head", value "delete-guest");
              ;input(type "hidden", name "who", value "{(scow %p id.guest)}");
              ;input(type "submit", value "-");
            ==
            ;span: {"_{(scag 6 (slag 8 (trip (scot %p id.guest))))}"}
          ==
          ;td.tags
            =style  "text-align:left;"
            ;form(method "post")
              =style  "white-space:nowrap;"
              ;input(type "hidden", name "head", value "tag-guest");
              ;input(type "hidden", name "who", value "{(scow %p id.guest)}");
              ;input(type "text", name "tags", placeholder "some, tags", autocomplete "off");
              ;input(type "submit", value "+");
            ==
            ;+  (render-tags id.guest tags.guest)
          ==
          ;td: {<handle.guest>}
          ;td  :: invite-code
            ;+
            ?~  invite-code.guest
              ;span: {"~"}
            ;span
              ;a(href "/apps/phobos/claim?invite-code={(trip u.invite-code.guest)}")
                link
              ==
            ==
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