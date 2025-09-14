// BLOCK_SIZE = 8
// UNROLL = 4 
// OMP_THREADS = 12
// OPTIMISATION = -O3

// combination attempt 1
// multicore + blocking
void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
    for (int i=si; i<si+BLOCK_SIZE; i++){
        for (int j=sj; j<sj+BLOCK_SIZE; j++){
	        double C_ij = C[i][j];
            for (int k=sk; k<sk+BLOCK_SIZE; k++){
		        C_ij += A[i][k] * B[k][j]; 
            }
            C[i][j] = C_ij;
        }
    }	 
}

#pragma omp parallel for
for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
    for(int si=0; si<N; si+=BLOCK_SIZE) {
        for(int sk=0; sk<M; sk+=BLOCK_SIZE){
            do_block_combination(si, sj, sk, A, B, C);
        }
    }
}

// combination attempt 2 
// multicore + blocking + SIMD
void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
    for (int i=si; i<si+BLOCK_SIZE; i++){
        for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	        __m256d c0 = _mm256_load_pd(&C[i][j]);
            for (int k=sk; k<sk+BLOCK_SIZE; k++){
		        c0 = _mm256_add_pd(c0, _mm256_mul_pd(_mm256_load_pd(&B[k][j]), _mm256_broadcast_sd(&A[i][k])));
            }
            _mm256_store_pd(&C[i][j], c0);
        }
    }	 
}

void matrix_multiply_combination(double **A, double **B, double **C, int L, int M, int N) {    
    #pragma omp parallel for
    for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
        for(int si=0; si<N; si+=BLOCK_SIZE) {
            for(int sk=0; sk<M; sk+=BLOCK_SIZE){
                do_block_combination(si, sj, sk, A, B, C);
            }
        }
    }
}

// combination attempt 3
// multicore + auto-unroll + SIMD + blocking
void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
    for (int i=si; i<si+BLOCK_SIZE; i++){
        for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	        __m256d c0 = _mm256_load_pd(&C[i][j]);

            #pragma GCC unroll 4
            for (int k=sk; k<sk+BLOCK_SIZE; k++){
		        c0 = _mm256_add_pd(c0, _mm256_mul_pd(_mm256_load_pd(&B[k][j]), _mm256_broadcast_sd(&A[i][k])));
            }
            _mm256_store_pd(&C[i][j], c0);
        }
    }	 
}

void matrix_multiply_combination(double **A, double **B, double **C, int L, int M, int N) {    
    #pragma omp parallel for
    for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
        for(int si=0; si<N; si+=BLOCK_SIZE) {
            for(int sk=0; sk<M; sk+=BLOCK_SIZE){
                do_block_combination(si, sj, sk, A, B, C);
            }
        }
    }
}

// combination attempt 4
// multicore + auto-unroll + SIMD + blocking + prefetching
void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
    for (int i=si; i<si+BLOCK_SIZE; i++){
        for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	        __m256d c0 = _mm256_load_pd(&C[i][j]);

            #pragma GCC unroll 4
            for (int k=sk; k<sk+BLOCK_SIZE; k++){
		        c0 = _mm256_add_pd(c0, _mm256_mul_pd(_mm256_load_pd(&B[k][j]), _mm256_broadcast_sd(&A[i][k])));
                if (k + PREFETCH_DISTANCE < sk + BLOCK_SIZE) {
                    _mm_prefetch((const char*)&A[i][k + PREFETCH_DISTANCE], _MM_HINT_T0);
                    _mm_prefetch((const char*)&B[k + PREFETCH_DISTANCE][j], _MM_HINT_T0);
                }
            }
            _mm256_store_pd(&C[i][j], c0);
        }
    }	 
}

void matrix_multiply_combination(double **A, double **B, double **C, int L, int M, int N) {    
    #pragma omp parallel for
    for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
        for(int si=0; si<N; si+=BLOCK_SIZE) {
            for(int sk=0; sk<M; sk+=BLOCK_SIZE){
                do_block_combination(si, sj, sk, A, B, C);
            }
        }
    }
}

// combination attempt 5
// multicore + auto-unroll + blocking
void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
    for (int i=si; i<si+BLOCK_SIZE; i++){
        for (int j=sj; j<sj+BLOCK_SIZE; j++){
	        double C_ij = C[i][j];

            #pragma GCC unroll 4
            for (int k=sk; k<sk+BLOCK_SIZE; k++){
		        C_ij += A[i][k] * B[k][j]; 
            }

            C[i][j] = C_ij;
        }
    }	 
}

void matrix_multiply_combination(double **A, double **B, double **C, int L, int M, int N) {    
    #pragma omp parallel for
    for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
        for(int si=0; si<N; si+=BLOCK_SIZE) {
            for(int sk=0; sk<M; sk+=BLOCK_SIZE){
                do_block_combination(si, sj, sk, A, B, C);
            }
        }
    }
}

// combination attempt 6
// multicore + auto-unroll + blocking + prefetch
void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
    for (int i=si; i<si+BLOCK_SIZE; i++){
        for (int j=sj; j<sj+BLOCK_SIZE; j++){
	        double C_ij = C[i][j];

            #pragma GCC unroll 4
            for (int k=sk; k<sk+BLOCK_SIZE; k++){
		        C_ij += A[i][k] * B[k][j]; 
                if (k + PREFETCH_DISTANCE < sk + BLOCK_SIZE) {
                    _mm_prefetch((const char*)&A[i][k + PREFETCH_DISTANCE], _MM_HINT_T0);
                    _mm_prefetch((const char*)&B[k + PREFETCH_DISTANCE][j], _MM_HINT_T0);
                }
            }
            C[i][j] = C_ij;
        }
    }	 
}

void matrix_multiply_combination(double **A, double **B, double **C, int L, int M, int N) {    
    #pragma omp parallel for
    for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
        for(int si=0; si<N; si+=BLOCK_SIZE) {
            for(int sk=0; sk<M; sk+=BLOCK_SIZE){
                do_block_combination(si, sj, sk, A, B, C);
            }
        }
    }
}