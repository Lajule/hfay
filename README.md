hfay
=====

An OTP application to demonstrate how to use [cowboy](https://github.com/ninenines/cowboy)'s websocket handler.
The application also uses [mnesia](http://erlang.org/doc/man/mnesia.html) database provided with Erlang.

Config
------

```
[
  {hfay, [
    {port, 8080}
  ]},
  {mnesia, [
    {dir, "/tmp/db"}
  ]}
].
```

Build
-----

    $ rebar3 compile

Release
-------

    $ rebar3 release
