::  phobos /claim
::
::
/-  store=phobos
/+  rudder, server
::
^-  (page:rudder guests:store action:store)
::
|_  [=bowl:gall order:rudder =guests:store]
  ++  argue
  |=  [headers=header-list:http body=(unit octs)]
  ^-  $@(brief:rudder action:store)
  =/  args=(map @t @t)
    ?~(body ~ (frisk:rudder q.u.body))
  ?~  head=(~(get by args) 'head')
    ~
  ?~  otp=(~(get by args) 'otp')
    'missing otp arg'
  ~&  >  ['argue got args' args]
  ?+  u.head  'invalid action head'
      %claim-guest
    [%claim-guest u.otp]
  ==
::
:: ++  final  (alert:rudder url.request build)
++  final
  |=  [success=? =brief:rudder]
  ^-  reply:rudder
  ?.  success  (build ~ `[| `@t`brief])
  ::
  :: success
  :: setcookie and 303 to ./claim-success
  :: I think the brief needs to be the session token for this to work in rudder... lol
  =|  =simple-payload:http
  =.  response-header.simple-payload
    :-  303
    ~[['Location' 'claim-success'] ['set-cookie' 'test=banana']]
    :: ~[['Location' 'claim-success'] ['testing123' 'bananabanananananananana']]

  :: [%next 'claim-success' ~]
  [%full simple-payload]
::
++  build
  |=  $:  arg=(list [k=@t v=@t])
          msg=(unit [o=? =@t])
      ==
  ^-  reply:rudder
  :: ?.  authenticated
  ::   [%auth url.request]
  :: TODO xtra for setcookie and optional redir
  ::
  =/  ,request-line:server
    (parse-request-line:server url.request)
  =/  args=(map @t @t)
        (~(gas by *(map @t @t)) args)
  :: ~&  >>>  msg
  :: =/  are=(unit (map @t @t))
  ::     ?~  body.request  ~
  ::     %+  bind
  ::       (rush q.u.body.request yquy:de-purl:html)
  ::     ~(gas by *(map @t @t))
  :: ~&  >>  are
  :: ~&  >>  request
  ::
  =+  otp=(~(get by args) 'otp')
  :: ?~  otp=(~(get by args) 'otp')
  ::   [%code 403 'missing otp header']
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
    function submitClaimForm() { 
      document.claimForm.submit()
    }
    // window.onload = submitForm;
    // >what is this doing?
    // we want a clickable link to claim the OTP.
    // a 'GET' request is not supposed to alter app state.
    // instead, we return a webpage that autosubmits a form...
    //  is this an antipattern? or is this the proper way to accomplish these ends?
    //  I feel like I've seen similar behavior in the wild, but it feels pretty stupid
    '''
  ++  page
    ^-  manx
    ;html
      ;head
        ;title:"phobos"
        ;style:"body \{ text-align: center; margin:0;}"
        ;meta(charset "utf-8");
        ;meta(name "viewport", content "width=device-width, initial-scale=1");
        :: ;style:"{(trip style)}"
        ;script:"{(trip script)}"
      ==
      ;body
        ;div
          ;h1: phobos claim
          ;+  ?~  msg  ;p:""
            ?:  o.u.msg
              :: authenticated
              :: TODO, who am I auth as?? o_o
              ;p:"{(trip t.u.msg)}"
            :: auth failed
            ;p:"{(trip t.u.msg)}"

          ;form(method "post", name "claimForm")
            ;input(type "hidden", name "head", value "claim-guest");
            ;input(type "text", name "otp", value ?~(otp "" (trip u.otp)));
            ;input(type "submit", value "claim");
          ==
        ==
      ==
    ==
  --
--