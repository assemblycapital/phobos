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
  :: ~&  >  ['argue got args' args]
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
  ?~  brief
    [%code 404 ~]
  =|  =simple-payload:http
  =.  response-header.simple-payload
    :-  303
    ~[['Location' 'claim-success'] ['set-cookie' brief]]
    :: TODO add to set-cookie ;Path=/;

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
  =/  ,request-line:server
    (parse-request-line:server url.request)
  =/  args=(map @t @t)
        (~(gas by *(map @t @t)) args)
  ::
  =+  code=(~(get by args) 'code')
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
    /*
      >what is this doing?
      we want a clickable link to claim the OTP.
      a 'GET' request is not supposed to alter app state.
      instead, we return a webpage that autosubmits a form...
      is this an antipattern? or is this the proper way to accomplish these ends?
      I feel like I've seen similar behavior in the wild, but it feels pretty stupid
    */

    function submitClaimForm() { 
      const form = document.getElementById('claimForm');
      console.log('form', form)
      if(!form) return;
      form.submit()
    }
    // window.onload = submitForm;

    function main() {

      const currentUrl = new URL(window.location.href);
      const urlParams = new URLSearchParams(currentUrl.search);

      const code = urlParams.get('code');
      if(!code) {
        console.log('no code')
        return;
      }
      console.log('code', code)
      submitClaimForm();
    }
    
    document.addEventListener('DOMContentLoaded', () => {
      main();
    });
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
          ;+  ?~  msg
                claim-form
            ?.  o.u.msg
              :: auth failed
              ;p:"{(trip t.u.msg)}"
            ::
            claim-form
        ==
      ==
    ==
  ++  claim-form
    ^-  manx
    ;form(method "post", id "claimForm")
      ;input(type "hidden", name "head", value "claim-guest");
      ;input(type "text", name "otp", value ?~(code "" (trip u.code)));
      ;input(type "submit", value "claim");
    ==
  --
--