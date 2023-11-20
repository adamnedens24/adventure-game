description(school,
	'You begin your journey at school, entering the dark night.').
description(busystreet,
	'You walk along the busy street, unsure of what is ahead.').
description(sewer,
	'You are currently in a dark, cold sewer.').
description(downtown,
	'You enter downtown, where it is rampant with all sorts of activity.').
description(alley,
	'You walk towards a dark alley. It is eery.').
description(mall,
	'You come across an outdoor mall, filled with people and distractions.').
description(crimescene,
	'You find a crime scene.').
description(park,
	'You enter a park, which is dimly lit, but at least you can see what lies ahead.').
description(bridge,
	'You walk across a tiny bridge, with different paths after it.').
description(building,
	'You are at an old abandoned building. Very spooky.').
description(darkstreet,
	'You are walking on an unlit street, seems scary.').
description(hideout,
	'You have come across an old hideout, that appears to be abandoned.').
description(trail,
	'You are at the fork of a trail. Where to go from here?').
description(home,
	'You have arrived home, safe and sound.').

report :-
	at(you,X),
	description(X, Y),
	write(Y), nl.

connect(school, forward, busystreet).
connect(busystreet, right, downtown).
connect(busystreet, left, sewer).
connect(downtown, forward, alley).
connect(downtown, left, mall).
connect(mall, left, crimescene).
connect(mall, right, park).
connect(park, forward, bridge).
connect(bridge, right, building).
connect(bridge, left, darkstreet).
connect(darkstreet, forward, hideout).
connect(darkstreet, right, trail).	
connect(trail, left, hideout).
connect(trail, right, home).

move(Dir) :-
	at(you, Loc),
	connect(Loc, Dir, Next),
	retract(at(you, Loc)),
	assert(at(you, Next)),
	report,
	!.

move(_) :-
	write('That is not a legal move.\n'),
	report.

forward :- move(forward).
left :- move(left).
right :- move(right).

serialkiller :-
	at(serialkiller, Loc),
	at(you, Loc),
	write('A serial killer pops out and kills you!\n'),
	retract(at(you,Loc)),
	assert(as(you,done)),
	!.
	
serialkiller.

victory :-
	at(victory, Loc),
	at(you, Loc),
	write('Congratulations! You win!\n'),
	retract(at(you,Loc)),
	assert(at(you,done)),
	!.
	
victory.

sewer :-
	at(you, sewer),
	write('You are trapped in the sewer with no way out.\n'),
	retract(at(you, sewer)),
	assert(at(you, done)),
	!.
sewer.

alley :-
	at(you, alley),
	write('You get attacked in the alley \n'),
	write('by mysterious figures, and you die.\n'),
	retract(at(you, alley)),
	assert(at(you, done)),
	!.
alley.

crimescene :-
	at(you, crimescene),
	write('The police spot you and arrest you, as you closely \n'),
	write('resemble the description of the suspect.\n'),
	retract(at(you, crimescene)),
	assert(at(you, done)),
	!.
crimescene.

building :-
	at(you, building),
	write('You enter the building, where something \n'),
	write('falls on you, leading to your death.\n'),
	retract(at(you, building)),
	assert(at(you, done)),
	!.
building.

main :-
	at(you, done),
	write('Thank you for playing!\n'),
	!.

main :-
	write('\nYour next move - '),
	read(Move),
	call(Move),
	serialkiller,
	sewer,
	alley,
	crimescene,
	building,
	victory,
	main.

go :-
	retractall(at(_,_)), % clean up from previous runs
	assert(at(you, school)),
	assert(at(serialkiller, hideout)),
	assert(at(victory, home)),
	write('Welcome to this adventure game! \n'),
	write('Only possible moves are left, right, or forward.\n'),
	write('Remember: end each move with a period. \n\n'),
	report,
	main.