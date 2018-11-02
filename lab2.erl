-module(lab2).
-export([pole/1, objetosc/1, len/1, amin/1, amax/1,
        tmin_max/1, lmin_max/1, polaFigur/1, tailPolaFigur/1,
        listaMalejaca/1, tailListaMalejaca/1, temp_conv/2,
        generatorListyJedynek/1, generatorListyLiczb/2,
        mergeSort/1, split/1, merge/2, bubbleSort/1
        ]).
 
pole({kwadrat,X,Y}) ->  X*Y;
pole({kolo,X}) -> 3.14*X*X;
pole({trojkat,W,P}) -> (W*P)/2;
pole({kula,R}) -> 4 * 3.14 * R * R;
pole({szescian,B}) -> 6 * B * B;
pole({stozek,R,L}) -> 3.14 * R * R + 3.14 * R * L.

objetosc({kula,R}) -> (4/3) * 3.14 * R * R * R;
objetosc({szescian,B}) -> B * B * B;
objetosc({stozek,H,R}) -> (1/3) * 3.14 * R * R * H.

len([]) -> 0;
len([_|T]) -> 1 + len(T).

amin([H|T]) -> listMin(T,H).

listMin([],Min) -> Min;
listMin([H|T],Min) when H < Min -> listMin(T, H);
listMin([H|T],Min) when H >= Min -> listMin(T, Min).

amax([H|T]) -> listMax(T,H).

listMax([],Max) -> Max;
listMax([H|T],Max) when H > Max -> listMax(T, H);
listMax([H|T],Max) when H =< Max -> listMax(T, Max).

tmin_max(L) ->
    Min = amin(L),
    Max = amax(L),
    {Min,Max}.

lmin_max(L) ->
    Min = amin(L),
    Max = amax(L),
    [Min,Max].

polaFigur([]) -> [];
polaFigur([H|T]) -> [pole(H) | polaFigur(T)].

reverse(L) -> reverse(L, []).

reverse([], Acc) -> Acc;
reverse([H|T], Acc) -> reverse(T, [H|Acc]).
 
tailPolaFigur(L) -> reverse(tailPolaFigur(L,[])).

tailPolaFigur([], Acc) -> Acc;
tailPolaFigur([H|T], Acc) -> tailPolaFigur(T, [pole(H) | Acc]).

listaMalejaca(0) -> [];
listaMalejaca(N) -> [N|listaMalejaca(N-1)].

tailListaMalejaca(N) -> reverse(tailListaMalejaca(N,[])).

tailListaMalejaca(0,Acc) -> Acc;
tailListaMalejaca(N,Acc) -> tailListaMalejaca(N-1,[N|Acc]).

temp_conv({c,N},k) -> {k, N + 273.15};
temp_conv({k,N},c) -> {c, N - 273.15};
temp_conv({f,N},c) -> {c, (N - 32) / 1.8};
temp_conv({c,N},f) -> {f, (N * 1.8) + 32};
temp_conv({f,N},k) -> temp_conv(temp_conv({f,N},c),k);
temp_conv({k,N},f) -> temp_conv(temp_conv({k,N},c),f).

generatorListyJedynek(0) -> [];
generatorListyJedynek(N) -> [1|generatorListyJedynek(N-1)].

generatorListyLiczb(0,_) -> [];
generatorListyLiczb(N,Liczba) -> [Liczba|generatorListyLiczb(N-1,Liczba)].


mergeSort([]) -> [];
mergeSort([H]) -> [H];
mergeSort(List) -> 
    {Front, Back} = split(List),
    merge(mergeSort(Front), mergeSort(Back)).

split(List) -> split(List,[],[],len(List),0).

split([],Front,Back,_,_) -> {Front,Back}; 
split([H|T],Front,Back,Len,Curr) when Curr < Len/2 -> split(T,[H|Front],Back,Len,Curr+1);
split([H|T],Front,Back,Len,Curr) when Curr >= Len/2 -> split(T,Front,[H|Back],Len,Curr+1).

merge([], Back) -> Back;
merge(Front, []) -> Front;
merge([H1|T1],[H2|T2]) when H1 < H2 -> [H1 | merge(T1, [H2|T2])];
merge([H1|T1],[H2|T2]) when H1 >= H2 -> [H2 | merge([H1|T1], T2)].

bubbleSort([]) -> [];
bubbleSort([H]) -> [H];
bubbleSort(List) -> bubbleSort(List,[],true).

bubbleSort([], List, true) -> reverse(List);
bubbleSort([], List, false) -> bubbleSort(reverse(List), [], true);
bubbleSort([F,S|T], List, _) when F > S -> bubbleSort([F|T],[S|List],false);
bubbleSort([X|T], List, Zatrzymac) -> bubbleSort(T, [X|List], Zatrzymac).