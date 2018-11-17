-module(lab3).
-export([
    insertElement/2, 
    insertValue/2, 
    generateRandomTree/1,
    generateFromList/1,
    listFromTreePre/1,
    listFromTreeIn/1,
    listFromTreePost/1,
    hasValue/2,
    hasValueEx/2
    ]).

insertElement({node,Value,Left,Right}, null) -> {node,Value,Left,Right};

insertElement({node,Value,Left,Right}, {node,TVal,TLeft,null}) when Value >= TVal -> 
    {node,TVal,TLeft,{node,Value,Left,Right}};
insertElement({node,Value,Left,Right}, {node,TVal,null,TRight}) when Value < TVal -> 
    {node,TVal,{node,Value,Left,Right},TRight};
insertElement({node,Value,Left,Right}, {node,TVal,TLeft,TRight}) when Value >= TVal ->
    {node,TVal,TLeft,insertElement({node,Value,Left,Right}, TRight)};
insertElement({node,Value,Left,Right}, {node,TVal,TLeft,TRight}) when Value < TVal ->
    {node,TVal,insertElement({node,Value,Left,Right}, TLeft), TRight}.

insertValue(Value, null) -> {node,Value,null,null};

insertValue(Value, {node,TVal,TLeft,null}) when Value >= TVal -> 
    {node,TVal,TLeft,{node,Value,null,null}};
insertValue(Value, {node,TVal,null,TRight}) when Value < TVal -> 
    {node,TVal,{node,Value,null,null},TRight};
insertValue(Value, {node,TVal,TLeft,TRight}) when Value >= TVal ->
    {node,TVal,TLeft,insertValue(Value, TRight)};
insertValue(Value, {node,TVal,TLeft,TRight}) when Value < TVal ->
    {node,TVal,insertValue(Value, TLeft), TRight}.

generateRandomTree(0) -> null;
generateRandomTree(N) -> insertValue(rand:uniform(100), generateRandomTree(N-1)).

generateFromList([]) -> null;
generateFromList([V|T]) -> insertValue(V, generateFromList(T)).

listFromTreePre({node,V,null,null}) -> [V];
listFromTreePre({node,V,Left,null}) -> [V | listFromTreePre(Left)];
listFromTreePre({node,V,null,Right}) -> [V | listFromTreePre(Right)];
listFromTreePre({node,V,Left,Right}) -> [V | listFromTreePre(Left) ++ listFromTreePre(Right)].

listFromTreeIn({node,V,null,null}) -> [V];
listFromTreeIn({node,V,Left,null}) -> listFromTreeIn(Left) ++ [V];
listFromTreeIn({node,V,null,Right}) -> [V] ++ listFromTreeIn(Right);
listFromTreeIn({node,V,Left,Right}) -> listFromTreeIn(Left) ++ [V] ++ listFromTreeIn(Right).

listFromTreePost({node,V,null,null}) -> [V];
listFromTreePost({node,V,Left,null}) -> listFromTreePost(Left) ++ [V];
listFromTreePost({node,V,null,Right}) -> listFromTreePost(Right) ++ [V];
listFromTreePost({node,V,Left,Right}) -> listFromTreePost(Left) ++ listFromTreePost(Right) ++ [V].

hasValue(_, null) -> false;
hasValue(V, {node,V,_,_}) -> true;
hasValue(V, {node,TV,Left,_}) when V < TV -> hasValue(V, Left);
hasValue(V, {node,TV,_,Right}) when V > TV -> hasValue(V, Right).


hasValueEx(Val, Tree) ->
    try hasValueE(Val, Tree) of
        false -> false;
        true -> true
    catch
        false -> false;
        true -> true
    end.


hasValueE(_, null) -> throw(false);
hasValueE(V, {node,V,_,_}) -> throw(true);
hasValueE(V, {node,TV,Left,_}) when V < TV -> hasValueE(V, Left);
hasValueE(V, {node,TV,_,Right}) when V > TV -> hasValueE(V, Right).