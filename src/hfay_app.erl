-module(hfay_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
  hfay_db:start_clear(),
  File = filename:join(code:priv_dir(hfay), "index.mustache"),
  Dispatch = cowboy_router:compile([
    {'_', [
      {"/", hfay_index_h, {bbmustache:parse_file(File)}},
      {"/favicon.ico", cowboy_static, {priv_file, hfay, "favicon.ico"}},
      {"/ws", hfay_ws_h, []}
    ]}
  ]),
  {ok, Port} = application:get_env(hfay, port),
  {ok, _ListenerPid} = cowboy:start_clear(http, [{port, Port}], #{env => #{dispatch => Dispatch}}),
  hfay_sup:start_link().

stop(_State) -> ok.
