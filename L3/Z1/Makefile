all: bison flex
	g++ zad1.tab.c lex.yy.c converter.cpp -lfl -lm

bison:
	bison -d zad1.y

flex: 
	flex zad1.l

clean:
	rm zad1.tab.h zad1.tab.c lex.yy.c