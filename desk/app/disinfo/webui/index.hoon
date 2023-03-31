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
  ?~  who=(scry-validate-guest:phobos bowl request)
    'bad auth'
  :: ~&  >  ['argue got args' args]
  ?+  u.head  'invalid action head'
      %post-rumor
    [%post-rumor u.t]
  ==
::
++  final  (alert:rudder url.request build)
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  :: ?.  authenticated
  ::   [%auth url.request]
  :: =/  ,request-line:server
  ::   (parse-request-line:server url.request)
  :: =/  args=(map @t @t)
  ::       (~(gas by *(map @t @t)) args)
  ?~  who=(scry-validate-guest:phobos bowl request)
    [%code 403 ~]
  ~&   >>   who
  |^  [%page page]
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
            ;input(type "text", name "t", placeholder "youre fat", autocomplete "off");
            ;input(type "submit", value "submit");
          ==
          ;div
            ;p:test
            ;*
              %+  turn  rumors
              |=  =rumor:store
                ;p: {(trip t.rumor)}
          ==
        ==
      ==
    ==
  --
--