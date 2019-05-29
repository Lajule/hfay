-module(hfay_index_h).

-include("hfay.hrl").

-export([init/2]).

init(Req1, State) ->
  Uuid = from_req(Req1),
  Req0 = cowboy_req:set_resp_cookie(<<"uuid">>, Uuid, Req1),
  Body = to_body(State, Uuid),
  Req = cowboy_req:reply(200, #{<<"content-type">> => <<"text/html">>}, Body, Req0),
  {ok, Req, State}.

from_req(Req) -> from_query(lists:keyfind(<<"uuid">>, 1, cowboy_req:parse_qs(Req)), Req).

from_query({<<"uuid">>, Uuid}, _Req) -> Uuid;

from_query(false, Req) ->
  from_cookie(lists:keyfind(<<"uuid">>, 1, cowboy_req:parse_cookies(Req)), Req).

from_cookie({<<"uuid">>, Uuid}, _Req) -> Uuid;
from_cookie(false, _Req)              -> hfay_uuid:generate().

to_body({Template}, Uuid) ->
  bbmustache:compile(Template, #{"uuid" => Uuid, "duration" => to_duration(hfay_db:select(Uuid))}).

to_duration([])                                                  -> [];
to_duration([Row])                                               -> to_duration(Row);
to_duration(#hfay{uuid=_Uuid, start=_Start, duration=undefined}) -> [];
to_duration(#hfay{uuid=_Uuid, start=_Start, duration=Duration})  -> Duration.
