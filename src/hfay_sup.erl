-module(hfay_sup).

-behaviour(supervisor).

-export([start_link/0, init/1]).

start_link() -> supervisor:start_link(hfay_sup, []).

init(_Args) ->
  SupFlags = #{strategy => one_for_one, intensity => 10, period => 10},
  {ok, {SupFlags, []}}.
