#!/bin/bash
N=128 # Starting matrix dimensions
dN=128 # Increment in matrix dimensions
NUM_TESTS=20 # Number increments to make 
MAX=$((dN*NUM_TESTS))

while [ $N -le $MAX ]
    do
    ./matrix_multiply.out $N $N $N 0
    ((N += dN))
    done
    
