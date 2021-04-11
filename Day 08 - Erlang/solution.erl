-module(solution).
-compile(export_all).

solve() ->
    In = readlines("input.txt"),
    Dict = dict:new(),
    run(In, Dict, 0).

readlines(FileName) ->
    {ok, Binary} = file:read_file(FileName),
    [string:tokens(Line, " ") || Line <- string:tokens(erlang:binary_to_list(Binary), "\n")].

get(V, Dict) ->
    case dict:find(V, Dict) of
        {ok, N} -> N;
        error -> 0
    end.

run([], Dict, Highest) ->
    AllValues = [V || {_,V} <- dict:to_list(Dict)] ++ [0],
    io:format("Part 1: ~w~n", [lists:max(AllValues)]),
    io:format("Part 2: ~w~n", [Highest]);

run([[ModVar, Action, ActionVal, "if", CompVar, Op, OpVal]|T], Dict, Highest) ->
    ModVal = get(ModVar, Dict),
    {ActionNum, _} = string:to_integer(ActionVal),
    CompVal = get(CompVar, Dict),
    {OpNum, _} = string:to_integer(OpVal),
    Eval = case Op of
        ">" -> CompVal > OpNum;
        ">=" -> CompVal >= OpNum;
        "<" -> CompVal < OpNum;
        "<=" -> CompVal =< OpNum;
        "==" -> CompVal =:= OpNum;
        "!=" -> CompVal =/= OpNum
    end,
    Total = case Eval of
        true -> case Action of
                    "inc" -> ModVal + ActionNum;
                    "dec" -> ModVal - ActionNum
                end;
        false -> ModVal
    end,
    NewDict = dict:store(ModVar, Total, Dict),
    NewHighest = case Total > Highest of
        true -> Total;
        false -> Highest
    end,
    run(T, NewDict, NewHighest).
