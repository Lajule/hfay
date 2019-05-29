-module(hfay_ws_h).

-export([init/2, websocket_init/1, websocket_handle/2, websocket_info/2]).

-include("hfay.hrl").

-define(MIN_TIMEOUT, 3000).
-define(MAX_TIMEOUT, 10000).

init(Req, State) -> {cowboy_websocket, Req, State}.

websocket_init(State) -> {ok, State}.

websocket_handle({text, Text}, State) -> websocket_handle(string:split(Text, ":"), State);

websocket_handle([<<"start">>, Uuid], State) ->
  erlang:start_timer(timeout(), self(), {Uuid}),
  {ok, State};

websocket_handle([<<"stop">>, Uuid], State) ->
  [Row] = hfay_db:select(Uuid),
  Duration = timestamp() - Row#hfay.start,
  hfay_db:insert(Row#hfay{duration=Duration}),
  {reply, {text, io_lib:format("stopped:~p", [Duration])}, State};

websocket_handle(_Frame, State) -> {ok, State}.

websocket_info({timeout, _Ref, {Uuid}}, State) ->
  hfay_db:insert(#hfay{uuid=Uuid, start=timestamp()}),
  {reply, {text, <<"started">>}, State};

websocket_info(_Info, State) -> {ok, State}.

timestamp() -> os:system_time(millisecond).

timeout() -> round(rand:uniform() * (?MAX_TIMEOUT - ?MIN_TIMEOUT) + ?MIN_TIMEOUT).
