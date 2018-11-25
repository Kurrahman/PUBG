use_module(library(random)).

inventory([],4).

weapon(ak47, 40).
weapon(pistol, 25).
weapon(crossbow, 69).

ammo(ak47, 10).
ammo(pistol, 6).
ammo(crossbow, 1).

armor(armor1, 20).
armor(armor2, 40).
armor(armor3, 60).
armor(helmet1, 10).
armor(helmet2, 25).
armor(helmet3, 40).

medicine(daun, 15).
medicine(perban, 30).
medicine(p3k, 50).

:- dynamic(enemy/4).
:- dynamic(posisi/3).
:- dynamic(player/6).
:- dynamic(deadzone/1).

initPl :- 
    random(1,11,Xp), random(1,11,Yp), assertz(posisi(player,Xp,Yp)).

randomW(1, X) :- X = ak47.
randomW(2, X) :- X = pistol.
randomW(3, X) :- X = crossbow.

randomA(1, X) :- X = ak47Ammo.
randomA(2, X) :- X = pistolAmmo.
randomA(3, X) :- X = crossbowAmmo.

randomS(1, X) :- X = armor1.
randomS(2, X) :- X = armor2.
randomS(3, X) :- X = armor3.
randomS(4, X) :- X = helmet1.
randomS(5, X) :- X = helmet2.
randomS(6, X) :- X = helmet3.

randomM(1, X) :- X = daun.
randomM(2, X) :- X = perban.
randomM(3, X) :- X = p3k.

randomD(1,X,Y) :- X is 0, Y is 1. /*atas*/
randomD(2,X,Y) :- X is -1, Y is 0. /*kiri*/
randomD(3,X,Y) :- X is 0 , Y is -1. /*bawah*/
randomD(4,X,Y) :- X is 1, Y is 0. /*kanan*/

initEn(1) :- 
    random(1,11,Xe), random(1,11,Ye), random(1,4,We), randomW(We, S), assertz(enemy(1,Xe,Ye,S)),
    assertz(posisi(enemy,Xe,Ye)).
initEn(X) :- 
    random(1,11,Xe), random(1,11,Ye), random(1,4,We), randomW(We, S), assertz(enemy(X,Xe,Ye,S)),
    assertz(posisi(enemy,Xe,Ye)),
    Y is X -1, initEn(Y).

initWe(1) :-
    random(1,11,Xe), random(1,11,Ye), random(1,4,We), randomW(We, S), assertz(posisi(S,Xe,Ye)).
initWe(X) :-
    random(1,11,Xe), random(1,11,Ye), random(1,4,We), randomW(We, S), assertz(posisi(S,Xe,Ye)),
    Y is X - 1, initWe(Y).

initAm(1) :-
    random(1,11,Xe), random(1,11,Ye), random(1,4,Am), randomA(Am, S), assertz(posisi(S,Xe,Ye)).
initAm(X) :-
    random(1,11,Xe), random(1,11,Ye), random(1,4,Am), randomA(Am, S), assertz(posisi(S,Xe,Ye)),
    Y is X - 1, initAm(Y).

initSh(1) :-
    random(1,11,Xe), random(1,11,Ye), random(1,7,Sh), randomS(Sh, S), assertz(posisi(S,Xe,Ye)).
initSh(X) :-
    random(1,11,Xe), random(1,11,Ye), random(1,7,Sh), randomS(Sh, S), assertz(posisi(S,Xe,Ye)),
    Y is X - 1, initSh(Y).

initMe(1) :-
    random(1,11,Xe), random(1,11,Ye), random(1,4,Me), randomM(Me, S), assertz(posisi(S,Xe,Ye)).
initMe(X) :-
    random(1,11,Xe), random(1,11,Ye), random(1,4,Me), randomM(Me, S), assertz(posisi(S,Xe,Ye)),
    Y is X - 1, initMe(Y).

lihat :-
    posisi(player,X,Y),
    L is X - 1,
    R is X + 1,
    T is Y + 1,
    B is Y - 1, 
    tulislihat(R,B), tulislihat(R,Y), tulislihat(R,T), nl,
    tulislihat(X,B), tulislihat(X,Y), tulislihat(X,T), nl,
    tulislihat(L,B), tulislihat(L,Y), tulislihat(L,T), nl.

tulisbaris(1) :- 
    tulistitikpeta(1,1), 
    tulistitikpeta(1,2),
    tulistitikpeta(1,3), 
    tulistitikpeta(1,4),
    tulistitikpeta(1,5), 
    tulistitikpeta(1,6),
    tulistitikpeta(1,7), 
    tulistitikpeta(1,8),
    tulistitikpeta(1,9), 
    tulistitikpeta(1,10),
    nl. 

tulisbaris(X) :-
    X > 1,
    tulistitikpeta(X,1), 
    tulistitikpeta(X,2),
    tulistitikpeta(X,3), 
    tulistitikpeta(X,4),
    tulistitikpeta(X,5), 
    tulistitikpeta(X,6),
    tulistitikpeta(X,7), 
    tulistitikpeta(X,8),
    tulistitikpeta(X,9), 
    tulistitikpeta(X,10),
    nl,
    Y is X - 1,
    tulisbaris(Y).

tulistitikpeta(X,Y) :- deadzone(D), B is 11 - Y, K is 11 - X, (X < D ; Y < D ; B < D ; K < D), write(' X'),!.
tulistitikpeta(X,Y) :- posisi(player,X,Y), write(' P'),!.
tulistitikpeta(_,_) :- write(' _').

tulislihat(X,Y) :- deadzone(D), B is 11 - Y, K is 11 - X, (X < D ; Y < D ; B < D ; K < D), write(' X'),!.
tulislihat(X,Y) :- posisi(enemy,X,Y), write(' E'),!.
tulislihat(X,Y) :- (posisi(daun,X,Y); posisi(perban,X,Y); posisi(p3k,X,Y)), write(' M'),!.
tulislihat(X,Y) :- (posisi(ak47,X,Y); posisi(pistol,X,Y); posisi(crossbow,X,Y)), write(' W'),!.
tulislihat(X,Y) :- (posisi(armor1,X,Y); posisi(armor2,X,Y); posisi(armor3,X,Y)), write(' D'),!.
tulislihat(X,Y) :- (posisi(helmet1,X,Y); posisi(helmet2,X,Y); posisi(helmet3,X,Y)), write(' D'),!.
tulislihat(X,Y) :- (posisi(ak47Ammo,X,Y); posisi(pistolAmmo,X,Y); posisi(crossbowAmmo,X,Y)), write(' A'),!.
tulislihat(X,Y) :- posisi(player,X,Y), write(' P'),!.
tulislihat(_,_) :- write(' _').

input(help) :-
    write('drop     - menjatuhkan item dari inventory'), nl,
    write('take     - mengambil item dari map'), nl,
    write('save     - menyimpan status game'), nl,
    write('load     - melanjutkan status game yang telah disimpan sebelumnya'), nl,
    write('status   - menampilkan statu permainan'), nl,
    write('look     - menampilkan wilayah 3x3 disekitar pemain'), nl,
    write('map      - menampilkan status peta'), nl,
    write('attack   - menyerang enemy yang berada di kotak yang sama dengan pemain'), nl,
    write('n        - menggerakkan pemain ke arah Utara (atas)'), nl,
    write('e        - menggerakkan pemain ke arah Timur (kanan)'), nl,
    write('s        - menggerakkan pemain ke arah Selatan (bawah)'), nl,
    write('w        - menggerakkan pemain ke arah Barat (kiri)'), nl,
    write('quit     - menghentikan permainan (jangan lupa untuk menyimpan permainan)'),nl.

input(look) :- lihat.
input(map) :- tulisbaris(10).

input(e) :- 
    posisi(player,X,Y),
    posisi(enemy,X,Y),
    input(attack),
    retract(posisi(player,X,Y)),
    N is Y + 1,
    assertz(posisi(player,X,N)),
    player(_,_,_,_,A,K),
    Nw is A+K,
    jalanenemy(Nw)
    . 
input(e) :- 
    posisi(player,X,Y),
    retract(posisi(player,X,Y)),
    N is Y + 1,
    assertz(posisi(player,X,N)),
    player(_,_,_,_,A,K),
    Nw is A+K,
    jalanenemy(Nw)
    . 

input(n) :- 
    posisi(player,X,Y),
    posisi(enemy,X,Y),
    input(attack),
    retract(posisi(player,X,Y)),
    E is X + 1,
    assertz(posisi(player,E,Y)),
    player(_,_,_,_,A,K),
    Nw is A+K,
    jalanenemy(Nw)
    . 
input(n) :- 
    posisi(player,X,Y),
    retract(posisi(player,X,Y)),
    E is X + 1,
    assertz(posisi(player,E,Y)),
    player(_,_,_,_,A,K),
    Nw is A+K,
    jalanenemy(Nw)
    . 

input(s) :-
    posisi(player,X,Y),
    posisi(enemy,X,Y),
    input(attack),
    retract(posisi(player,X,Y)),
    W is X - 1,
    assertz(posisi(player,W,Y)),
    player(_,_,_,_,A,K),
    Nw is A+K,
    jalanenemy(Nw)
    . 
input(s) :-
    posisi(player,X,Y),
    retract(posisi(player,X,Y)),
    W is X - 1,
    assertz(posisi(player,W,Y)),
    player(_,_,_,_,A,K),
    Nw is A+K,
    jalanenemy(Nw)
    . 

input(w) :- 
    posisi(player,X,Y),
    posisi(enemy,X,Y),
    input(attack),
    retract(posisi(player,X,Y)),
    S is Y - 1,
    assertz(posisi(player,X,S)),
    player(_,_,_,_,A,K),
    Nw is A+K,
    jalanenemy(Nw)
    . 
input(w) :- 
    posisi(player,X,Y),
    retract(posisi(player,X,Y)),
    S is Y - 1,
    assertz(posisi(player,X,S)),
    player(_,_,_,_,A,K),
    Nw is A+K,
    jalanenemy(Nw)
    . 

input(start) :-
    randomize,
    initPl,
    random(10, 20, E),
    initEn(E),
    assertz(deadzone(1)),
    assertz(player(100,0,none,0,E,0)),
    random(10, 20, W),
    initWe(W),
    random(10, 20, M),
    initMe(M),
    random(10, 20, S),
    initSh(S),
    random(10, 20, A),
    initAm(A).

input(attack):-
	posisi(player,X,Y),
	\+posisi(enemy,X,Y),
	write('Tidak ada enemy di wilayah anda !\n')
    .

input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We == none,
	Ar > 0,
	posisi(player,X,Y),
	enemy(_,X,Y,S),
    weapon(S,D),
    ArB is Ar - D,
    ArB > 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	assertz(player(Hp,ArB,We,Am,En,Ki)),
	write('Anda terkena serangan, HP musuh masih penuh\n'),!
    .

input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We == none,
	Ar > 0,
	posisi(player,X,Y),
	enemy(_,X,Y,S),
	weapon(S,D),
	ArB is Ar - D,
	ArB =< 0,
	HpB is Hp + ArB,
    ArB is 0,
    HpB > 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	assertz(player(HpB,ArB,We,Am,En,Ki)),
	write('Anda terkena serangan, HP musuh masih penuh\n'),!
    .

input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We == none,
	Ar > 0,
	posisi(player,X,Y),
	enemy(_,X,Y,S),
	weapon(S,D),
	ArB is Ar - D,
	ArB =< 0,
    HpB is Hp + ArB,
    ArB is 0,
    HpB =< 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	assertz(player(HpB,ArB,We,Am,En,Ki)),
    write('YOU DIED !\n'),!
    .

input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We == none,
	Ar =:= 0,
	posisi(player,X,Y),
	enemy(_,X,Y,S),
	weapon(S,D),
    HpB is Hp - D,
    HpB > 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	assertz(player(HpB,Ar,We,Am,En,Ki)),
	write('Anda terkena serangan, HP musuh masih penuh\n'),!
    .

input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We == none,
	Ar =:= 0,
	posisi(player,X,Y),
    enemy(_,X,Y,S),
    weapon(S,D),
    HpB is Hp - D,
    HpB =< 0, 
    HpB is 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	assertz(player(HpB,Ar,We,Am,En,Ki)),
    write('Anda terkena serangan, HP musuh masih penuh\n'),
    write('YOU DIED\n'),!
    .






input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We \== none,
	Ar > 0,
	posisi(player,X,Y),
	enemy(_,X,Y,S),
	weapon(S,D),
	EnB is En -1,
    KiB is Ki +1,
    ArB is Ar - D,
    ArB > 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	retract(enemy(_,X,Y,S)),
	retract(posisi(enemy,X,Y)),
	assertz(player(Hp,ArB,We,Am,EnB,KiB)),
	assertz(posisi(S,X,Y)),
    write('Anda berhasil counter attack \n'),!
    .

input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We \== none,
	Ar > 0,
	posisi(player,X,Y),
	enemy(_,X,Y,S),
	weapon(S,D),
	EnB is En -1,
	KiB is Ki +1,
	ArB is Ar - D,
    ArB =< 0,
    HpB is Hp + ArB,
    ArB is 0,
    HpB > 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	retract(enemy(_,X,Y,S)),
	retract(posisi(enemy,X,Y)),
	assertz(player(HpB,ArB,We,Am,EnB,KiB)),
	assertz(posisi(S,X,Y)),
    write('Anda berhasil counter attack \n'),!
    .


input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We \== none,
	Ar > 0,
	posisi(player,X,Y),
	enemy(_,X,Y,S),
	weapon(S,D),
	EnB is En -1,
	KiB is Ki +1,
	ArB is Ar - D,
	ArB =< 0,
	HpB is Hp + ArB,
    ArB is 0,
    HpB =< 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	retract(enemy(_,X,Y,S)),
	retract(posisi(enemy,X,Y)),
	assertz(player(HpB,ArB,We,Am,EnB,KiB)),
    assertz(posisi(S,X,Y)),
    write('Anda berhasil counter attack, tapi sayang sekali anda mati \n'),
    write('YOU DIED ! \n'),!
    .


input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We \== none,
	Ar =:= 0,
	posisi(player,X,Y),
	enemy(_,X,Y,S),
	weapon(S,D),
	EnB is En -1,
	KiB is Ki +1,
    HpB is Hp - D,
    HpB > 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	retract(enemy(_,X,Y,S)),
	retract(posisi(enemy,X,Y)),
	assertz(player(HpB,Ar,We,Am,EnB,KiB)),
	assertz(posisi(S,X,Y)),
    write('Anda berhasil counter attack \n'),!
    .

input(attack) :-
	player(Hp,Ar,We,Am,En,Ki),
	We \== none,
	Ar =:= 0,
	posisi(player,X,Y),
    enemy(_,X,Y,S),
    EnB is En -1,
    KiB is Ki +1,
    HpB is 0,
	retract(player(Hp,Ar,We,Am,En,Ki)),
	retract(enemy(_,X,Y,S)),
	retract(posisi(enemy,X,Y)),
	assertz(player(HpB,Ar,We,Am,EnB,KiB)),
    assertz(posisi(S,X,Y)),
    write('Anda berhasil counter attack, tapi sayang sekali anda mati \n'),
    write('YOU DIED !'),!
    .

input(status) :- 
    player(Hp,Ar,We,Am,En,Ki),
    write('Health           :   '), write(Hp), nl,
    write('Armor            :   '), write(Ar), nl,
    write('Weapon           :   '), write(We), nl,
    write('Ammo             :   '), write(Am), nl,
    write('Enemy Alive      :   '), write(En), nl,
    write('Enemy Killed     :   '), write(Ki), nl.

loop(quit) :-
    write('Bye'), nl
    . 

loop(_) :- 
    read(I),
    input(I),
    loop(I).

initial :- 
    write('Selamat datang, untuk sekarang catetannya ini dulu'), nl,
    loop(sembarang).

jalanenemy(1) :-
    random(1,5,D),
    randomD(D,Xe,Ye),
    enemy(1,X,Y,S),
    retract(enemy(1,X,Y,S)),
    retract(posisi(enemy,X,Y)),
    Xb is X + Xe,
    Yb is Y + Ye,
    assertz(enemy(1,Xb,Yb,S)),
    assertz(posisi(enemy,Xb,Yb)).
    
jalanenemy(N) :-
    random(1,5,D),
    randomD(D,Xe,Ye),
    enemy(N,X,Y,S),
    retract(enemy(N,X,Y,S)),
    retract(posisi(enemy,X,Y)),
    Xb is X + Xe,
    Yb is Y + Ye,
    assertz(enemy(N,Xb,Yb,S)),
    assertz(posisi(enemy,Xb,Yb)),
    Nw is N - 1,
    jalanenemy(Nw).

