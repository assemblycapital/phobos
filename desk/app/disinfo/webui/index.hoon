::  disinfo /index
::
::
/-  store=disinfo
/+  rudder, server, phobos
::
^-  (page:rudder rumors:store action:store)
::
|_  [=bowl:gall order:rudder =rumors:store]
  ++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder action:store)
  
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  head=(~(get by args) 'head')
    ~
  ?~  t=(~(get by args) 't')
    ~
  ?:  authenticated
    [%post-rumor u.t]
  ?~  who=(scry-validate-guest:phobos bowl request)
    'bad auth'
  [%post-rumor u.t]
::
++  final  (alert:rudder url.request build)
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  |^
  ?:  authenticated
    [%page page]
  ?~  who=(scry-validate-guest:phobos bowl request)
    :: todo create option for admin to view
    [%code 403 'contact admin for an invite']
  :: ~&   >>   who
  [%page page]
  ::
  ::
  ++  style
    '''
    .temp {
      color:red;
    }
    '''
  ++  script
    '''
    function main() {
      console.log('init')
    }
    
    document.addEventListener('DOMContentLoaded', () => {
      main();
    });
    '''
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"disinfo"
        ;style:"body \{ text-align: center; margin:0;}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        :: ;style:"{(trip style)}"
        ;script:"{(trip script)}"
      ==
      ;body
        ;div
          ;h1: disinfo
          ;form(method "post")
            =style  ""
            ;input(type "hidden", name "head", value "post-rumor");
            ;input(type "text", name "t", placeholder "anon message", autocomplete "off");
            ;input(type "submit", value "submit");
          ==
          ;div
            =style  "padding-bottom:4rem"
            ;p:test
            ;*
              %+  turn  rumors
              |=  =rumor:store
                ;p: {(trip t.rumor)}
          ==
        ==
        ;footer
            :: footer
            =style  "bottom:0;position:fixed;width:100%;background-color:white;"
            :: assembly capital logo
            ;svg(width "32", height "32", viewbox "0 0 388 194", fill "none", xmlns "http://www.w3.org/2000/svg")
              ;path(d "M194 0H97V97H0V194H97V97H194H291V194H388V97H291V0H194Z", fill "black");
            ==
            ;p
              =style  "margin:4px 0px;"
              ; {<our.bowl>}
            ==
          ==
      ==
    ==
  --
--