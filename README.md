# phobos

An Urbit guest authentication prototype

## High Level Description

Urbit can be used as an HTTP server for the public web. Some urbit apps have supported public read-access. None (to my knowledge) have supported public write-access. This is because the public internet is rampant with bots and exploiters. Phobos enables Urbit, as an HTTP server, to distinguish between public HTTP requesters and trusted users who have been invited by the admin.

## Implementation Details

Phobos exposes a public HTTP POST endpoint where "invite codes" can be claimed. If the code is valid, the server responds with a set-cookie header for a session-token corresponding to a nominal moon identity (TODO does phobos have to ask for "cookie permission"?)

Phobos "guests" use a moon @p as an identity. They are not actual urbit ships, and they dont actually have access to the keypair for their moon identity. A phobos "guest" is a browser session, which can authenticate with a cookie to the parent ships HTTP server. **The cookie can be validated by any urbit app via scry to the phobos agent.** Guest users are given moon identities so that they can natively interact with urbit applications. Guest users cannot run their own gall agents, they do not have their own virtual machine of any kind. Guest users cannot speak directly to the urbit network. They can only make HTTP requests to the parent. Since guest users are moons (subsidiary identities) of the parent, the parent can make actions in the urbit network on their behalf. This creates the potential for guest users to interact with native urbit users and guest users of other parents.

To easily distinguish phobos-issued moons from real moons (and as a preventative measure against impersonation attacks), guest user ID's are prefixed with ~botnet. This means a given ship can issue up to 2^16 or ~65thousand phobos guest identities.

Onboarding for phobos guest users is currently one click to open a link in a browser. Each guest user incurs virtually zero cost on the host. However, a large number of active guest users could potentially have a performance cost on the parent ship.

## Future Changes and Goals

Phobos is subject to change, it is still being prototyped. Future versions of phobos will not be compatible with the current version. Phobos is still being developed, and is staying flexible in order to support the most interesting usecases. I advise against using it in production until a future-compatible version is established.

The goal for phobos is to facilitate real usecases for Urbit as an HTTP server for more than just the admin user. As an example, phobos is packaged with a simple app called "disinfo", a client-server rumors clone over HTTP, only accessible to phobos guest users. Phobos admin users can create invite codes to be sent as links to a dozen of their friends. Each friend just has to open the link in any browser, and now this network of friends has an MVP anonymous message board. disinfo could easily sync with the parent ships rumors, but for now it is silo'd.

Some web2 apps to provide inspiration for apps on top of phobos are [ask.fm](https://ask.fm), [Gas](https://apps.apple.com/us/app/gas/id1641791746), and [yikyak](https://yikyak.com/). Each of these apps have been wildly successful by providing a layer of anonymity to real social graphs. ask.fm is of particular interest because it naturally hooks into existing social media platforms. Users interact with ask.fm by posting an anonymous Q&A link to their social media account.

Another potential usecase would be for phobos to facilitate guest access to urbit chat platforms. Owning a full urbit ship is a high barrier-to-entry for any users who might want to start by just participating in chat. Using phobos, or something similar, these kind of users could jump into an urbit chat over HTTP via invite from an urbit user. This would require custom integration, since these guest users cannot participate in typical urbit gall agent protocols.
