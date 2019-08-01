hfay
=====

An OTP application to demonstrate how to use [cowboy][1]'s websocket handler.
This application also uses [mnesia][2] database provided with Erlang.

Config
------

You can configure HTTP server 

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

[1]: https://github.com/ninenines/cowboy
[2]: http://erlang.org/doc/man/mnesia.html
