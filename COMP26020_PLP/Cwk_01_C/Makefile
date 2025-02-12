all: prog

prog: unity.o basic-test-suite.o matrix.o
	gcc unity.o basic-test-suite.o matrix.o -o prog

unity.o: unity.c
	gcc -c unity.c -o unity.o

basic-test-suite.o: basic-test-suite.c
	gcc -c basic-test-suite.c -o basic-test-suite.o

matrix.o: matrix.c
	gcc -c matrix.c -o matrix.o

clean:
	rm -rf *.o prog