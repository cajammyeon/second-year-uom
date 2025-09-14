OPT=-O3
CFLAGS=-fopenmp -mavx

all: matrix_multiply.out

matrix_multiply.out: main.o
	gcc $(CFLAGS) -o matrix_multiply.out main.o

main.o:
	gcc -c $(CFLAGS) $(OPT) main.c
	gcc -S -fverbose-asm $(CFLAGS) $(OPT) main.c

clean:
	rm matrix_multiply.out main.o main.s 
