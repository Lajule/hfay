%% Feel free to use, reuse and abuse the code in this file.

%% @private
-module(hfay_app).

-behaviour(application).

%% API.
-export([start/2]).
-export([stop/1]).

%% API.
start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", cowboy_static, {priv_file, hfay, "index.html"}},
			{"/websocket", hfay_handler, []}
		]}
	]),
	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}),
	hfay_sup:start_link().

stop(_State) ->
	ok.
