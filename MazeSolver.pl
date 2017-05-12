

% 1 : empty cell
% 2 : blocked cell
% 0 : path
% TestCase1 : go([1,1,1,2],2,2).
% TestCase2 : go([1,1,2,2,1,2,2,1,1],3,3).
% TestCase3 : go([1,1,2,2,1,2,2,1,1,1,1,1],4,4).
% TestCase4 go([1,1,1,2,1,2,2,1,1,1,1,1,1,2,2,1,2,1,1,2,2,2,2,1,1],5,5).
ismem(X,[X|_]):-!.
ismem(X,[_|T]):-
    ismem(X,T).
notmem(X,R):-
    not(ismem(X,R)).

%print The Path Of The Current List
path([],_,_,_):-!.
path([H|T],Indx,M,1):-
    put(10),
    print(H),print(,),
    NewIndx is Indx+1 ,
    path(T,NewIndx,M,2).
path([H|T],Indx,M,Md):-
	print(H),print(,),
	NewIndx is Indx+1,
        NewMd is NewIndx mod M,
	path(T,NewIndx,M,NewMd).

%add element in the closed list
addelement(Indx,Closed,[Indx|Closed]).

%substitute element in position x by 0
sub(X,X,[H|T],[0|T]):-!.
sub(Indx,Cnt,[H|T],[H|NewT]):-
    NewCnt is Cnt+1,
    sub(Indx,NewCnt,T,NewT).

%get value in position Indx
getchar(1,[H|T],H):-!.
getchar(Indx,[H|T],Char):-
   NewIndx is Indx-1,
   getchar(NewIndx,T,Char).

%copy List
copynewlist([],_):-!.
copynewlist([H|T],[H|NT]):-
    copynewlist(T,NT).
%================================================
%================================================
%================================================
%
%Start
go(L,N,M):-
    move(L,[],N,M,1,1).
move(R,_,N,M,Indx,0):-
    sub(Indx,1,R,New),
    path(New,1,M,1),!.
move(R,Closed,N,M,Indx,Md):-
    notmem(Indx,Closed),
    addelement(Indx,Closed,NewClosed),
    copynewlist(R,NewList),
    sub(Indx,1,NewList,New),
    (
    moveup(New,NewClosed,N,M,Indx,Md);
    movedown(New,NewClosed,N,M,Indx,Md);
    moveleft(New,NewClosed,N,M,Indx,Md);
    moveright(New,NewClosed,N,M,Indx,Md)
    ).
moveup(R,Closed,N,M,Indx,Md):-
	solveup(R,Closed,N,M,Indx,Md).
movedown(R,Closed,N,M,Indx,Md):-
        solvedown(R,Closed,N,M,Indx,Md).
moveleft(R,Closed,N,M,Indx,Md):-
        solveleft(R,Closed,N,M,Indx,Md).
moveright(R,Closed,N,M,Indx,Md):-
	solveright(R,Closed,N,M,Indx,Md).
solveup(R,Closed,N,M,Indx,Md):-
	Indx>M,
        S is Indx-M,
	getchar(S,R,Char),
        Char == 1,
        NewMd is S mod M,
        move(R,Closed,N,M,S,NewMd).
solvedown(R,Closed,N,M,Indx,Md):-
        Tmp1 is  Indx + M,
        Tmp2 is M*N,
	Tmp1 =< Tmp2,
        S is Indx+M,
	getchar(S,R,Char),
        Char ==1,
        NewMd is S mod M,
        move(R,Closed,N,M,S,NewMd).
solveleft(R,Closed,N,M,Indx,Md):-
	Tmp is Indx  mod M,
        Tmp \= 1 ,
        S is Indx-1,
        getchar(S,R,Char),
        Char ==1,
        NewMd is S mod M,
        move(R,Closed,N,M,S,NewMd).
solveright(R,Closed,N,M,Indx,Md):-
        S is Indx+1,
	getchar(S,R,Char),
        Char ==1,
        NewMd is S mod M,
        move(R,Closed,N,M,S,NewMd).




























































