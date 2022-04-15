%Omar Khaled Al Haj: 20190351.
%Arwa Hazem Mohamed Khalil: 20190663.

%%%%% Include Dataset %%%%%

:-[students_courses].

%%%% Predicate that appends two lists %%%%%

append([], X, X). 

append([X | Y], Z, [X | W]):-
	append(Y, Z, W).

%%%%% Predicate that returns true if an item is not in a list %%%%%

notIn(_, []).

notIn(S, [H | T]):-
	(S \= H -> notIn(S, T)).

%%%%% Predicate that returns a nested list with all students in a course %%%%%

studentsInCourse(X, Y, Z):-
	student(S, X, G),
	notIn([S, G], Z),
	append(Z, [[S, G]], Z1),
	studentsInCourse(X, Y, Z1).

studentsInCourse(_, Y, Y).

studentsInCourse(X, Y):-
	studentsInCourse(X, Y, []).

%%%%% Predicate that returns the number of students in a course %%%%%

cntStudents(X, Y, Z):-
	student(S, X, G),
	notIn(S, Z),
	append(Z, [S], Z1),
	cntStudents(X, Y1, Z1),
	Y is Y1 + 1.

cntStudents(_, 0, _).

numStudents(X, Y):-
	cntStudents(X, Y, []).

%%%%% Predicate that returns the maximum grade of a student %%%%%

getMaxG(X, Y, Z):-
	student(X, S, G),
	notIn(S, Z),
	append(Z, [S], Z1),
	getMaxG(X, Y1, Z1),
	(G > Y1 -> Y is G ; Y is Y1).

getMaxG(_, 0, _).

maxStudentGrade(X, Y):-
	getMaxG(X, Y, []).

%%%%% Show a student's grade digits in a specific course as a list of words %%%%%
seperate(Num, ResList, TempL):-
	Num > 0,
	N is Num mod 10,
	NewNum is Num // 10,
	digitToWord(N, W),
	append([W], TempL, L1),
	seperate(NewNum, ResList, L1).

seperate(0, TempL, TempL).

digitToWord(0, Word):- Word = zero.
digitToWord(1, Word):- Word = one.
digitToWord(2, Word):- Word = two.
digitToWord(3, Word):- Word = three.
digitToWord(4, Word):- Word = four.
digitToWord(5, Word):- Word = five.
digitToWord(6, Word):- Word = six.
digitToWord(7, Word):- Word = seven.
digitToWord(8, Word):- Word = eight.
digitToWord(9, Word):- Word = nine.

gradeInWords(X, Y, G):-
	student(X, Y, Grade),
	seperate(Grade, G, []).

%%%%% Predicate that outputs all of a course's prerequisites %%%%%	
remainingCourses(S, T, Courses, Temp):-
	T \== finished,
	prerequisite(Pre, T),
	(student(S, Pre, Grade), Grade >= 50 -> remainingCourses(S, finished, Courses, Temp);
	append([Pre], Temp, L1), remainingCourses(S, Pre, Courses, L1)).

remainingCourses(S, finished, Temp, Temp).

remainingCourses(S,T,Courses):-
	remainingCourses(S,T,Courses,[]).














