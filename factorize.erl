
-module(factorize).

-export([
	 getbit/2,
	 setbit/3,
	 bitcmp/3,
	 fac_check/4,
	 main/1
	]).


getbit(X, N) ->
    (X bsr N) band 1.


setbit(X, N, 1) ->
    X bor (1 bsl N);
setbit(X, N, 0) ->
    X band (bnot (1 bsl N)).


bitcmp(_I1, _I2, _N, _N)->
    0;
bitcmp(I1, I2, N, I)->
    B1=getbit(I1, I),
    B2=getbit(I2, I),
    if
	B1 /= B2 ->
	    B1 - B2;
	true ->
	    bitcmp(I1, I2, N, I + 1)
    end.

bitcmp(I1, I2, N) ->
    bitcmp(I1, I2, N, 0).

fac_check(I, 1, _I2, P, _Bits) when P == I ->
    false;
fac_check(I, _I1, 1, P, _Bits) when P == I ->
    false;
fac_check(I, _I1, _I2, P, _Bits) when P > I ->
    false;
fac_check(I, _I1, _I2, P, _Bits) when P == I ->
    true;
fac_check(I, _I1, _I2, P, Bits) ->
    bitcmp(I, P, Bits).


fac_check(I, I1, I2, Bits) ->
    fac_check(I, I1, I2, I1 * I2, Bits).


fac_run(I, _I1, _I2, _N, 4) ->
    [I];
fac_run(I, I1, I2, N, B) ->
    B1 = getbit(B, 0),
    B2 = getbit(B, 1),
    I1N = setbit(I1, N, B1),
    I2N = setbit(I2, N, B2),

    R = fac_check(I, I1N, I2N, N + 1),

    case R of
	true ->
	    lists:append(factorize(I1N), factorize(I2N));
	0 ->
	    F=fac_run(I, I1N, I2N, N+1, 0),
	    if 
		F =/= [I] ->
		    F;
		true ->
		    fac_run(I, I1, I2, N, B + 1)
	    end;
	_ ->
	    fac_run(I, I1, I2, N, B + 1)
    end.
    


fac_run(I, I1, I2) ->
    fac_run(I, I1, I2, 0, 0).
    

factorize (I) ->
    lists:sort(fac_run(I, 0, 0)).

main(Val) ->
    [X]=Val, 
    R=factorize(list_to_integer(X)),
    io:write(R),
    io:format("~n").
