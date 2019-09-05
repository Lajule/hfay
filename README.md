hfay
=====

An OTP application to demonstrate how to use [cowboy][1]'s WebSocket handler.
This application also uses [mnesia][2] database provided with Erlang.

Config
------

You can configure [cowboy][1] HTTP server port and [mnesia][2] database directory in `config/sys.config` file :

```erlang
[
  {hfay, [
    {port, 8080}
  ]},
  {mnesia, [
    {dir, "/tmp/db"}
  ]}
].
```

Release
-------

Use [rebar3][3] to build the application, typically type `rebar3 release` to build a release.
You can launch the application now with following command :

```shell
_build/default/rel/hfay_release/bin/hfay_release start
```

WebSocket
---------

Basically the WebSocket handler calculates the duration between two messages, following diagram illustrates the flow of messages :

![Sequence diagram](http://www.plantuml.com/plantuml/png/SoWkIImgAStDuNBEoKpDAr7GjLC8JYqgIosoKW1BMTc4Xdgws75111LqWV8GbL3vr1Gkh5hp2t3gX4WNfAPOsRY41Zc6UFhxsN4vfEQb09q10000)

[1]: https://github.com/ninenines/cowboy
[2]: http://erlang.org/doc/man/mnesia.html
[3]: https://www.rebar3.org/
