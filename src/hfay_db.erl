-module(hfay_db).

-include("hfay.hrl").

-export([start_clear/0, select/1, insert/1]).

start_clear() ->
  mnesia:create_schema([node()]),
  mnesia:start(),
  mnesia:create_table(hfay, [{disc_copies, [node()]}, {attributes, record_info(fields, hfay)}]).

-spec select(binary()) -> [#hfay{}].
select(Uuid) ->
  Fun = fun() -> mnesia:read({hfay, Uuid}) end,
  {atomic, Rows} = mnesia:transaction(Fun),
  Rows.

-spec insert(#hfay{}) -> #hfay{}.
insert(Row) ->
  Fun = fun() -> mnesia:write(Row) end,
  mnesia:transaction(Fun),
  Row.
