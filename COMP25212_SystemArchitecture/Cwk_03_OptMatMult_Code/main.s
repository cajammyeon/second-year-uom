	.file	"main.c"
# GNU C17 (Ubuntu 13.3.0-6ubuntu2~24.04) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mavx -mtune=generic -march=x86-64 -O3 -fopenmp -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.p2align 4
	.type	multicore_matrix_multiply._omp_fn.0, @function
multicore_matrix_multiply._omp_fn.0:
.LFB6655:
	.cfi_startproc
	endbr64	
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdi, %rbp	# tmp124, .omp_data_i
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 48
	call	omp_get_num_threads@PLT	#
	movl	%eax, %ebx	# tmp125, _18
	call	omp_get_thread_num@PLT	#
	movl	%eax, %r11d	# tmp126, _19
	movl	24(%rbp), %eax	# *.omp_data_i_11(D).L, *.omp_data_i_11(D).L
	cltd
	idivl	%ebx	# _18
	cmpl	%edx, %r11d	# tt.4_2, _19
	jl	.L2	#,
.L9:
	imull	%eax, %r11d	# q.3_1, tmp118
	addl	%edx, %r11d	# tt.4_2, _24
	leal	(%rax,%r11), %ebx	#, _25
	cmpl	%ebx, %r11d	# _25, _24
	jge	.L14	#,
# main.c:89:     #pragma omp parallel for
	movslq	32(%rbp), %rdx	# *.omp_data_i_11(D).N,
	movslq	28(%rbp), %rax	# *.omp_data_i_11(D).M,
	testl	%edx, %edx	# N
	jle	.L14	#,
	testl	%eax, %eax	# M
	jle	.L14	#,
	movq	16(%rbp), %r12	# *.omp_data_i_11(D).C, C
	movq	8(%rbp), %r9	# *.omp_data_i_11(D).B, B
	movslq	%r11d, %r11	# _24, ivtmp.53
	leaq	0(,%rdx,8), %r10	#, _80
	movq	0(%rbp), %rbp	# *.omp_data_i_11(D).A, A
	leaq	0(,%rax,8), %r8	#, _84
	.p2align 4,,10
	.p2align 3
.L6:
# main.c:96:                 C[i][j] += A[i][k] * B[k][j];
	movq	(%r12,%r11,8), %r13	# MEM[(double * *)C_15 + ivtmp.53_79 * 8], _31
# main.c:96:                 C[i][j] += A[i][k] * B[k][j];
	movq	0(%rbp,%r11,8), %rdi	# MEM[(double * *)A_17 + ivtmp.53_79 * 8], _37
	xorl	%ecx, %ecx	# ivtmp.50
	.p2align 4,,10
	.p2align 3
.L7:
# main.c:96:                 C[i][j] += A[i][k] * B[k][j];
	leaq	0(%r13,%rcx), %rsi	#, _34
	xorl	%eax, %eax	# ivtmp.45
	vmovsd	(%rsi), %xmm1	# *_34, _47
	.p2align 4,,10
	.p2align 3
.L5:
# main.c:96:                 C[i][j] += A[i][k] * B[k][j];
	movq	(%r9,%rax), %rdx	# MEM[(double * *)B_16 + ivtmp.45_89 * 1], MEM[(double * *)B_16 + ivtmp.45_89 * 1]
# main.c:96:                 C[i][j] += A[i][k] * B[k][j];
	vmovsd	(%rdx,%rcx), %xmm0	# *_44, *_44
	vmulsd	(%rdi,%rax), %xmm0, %xmm0	# MEM[(double *)_37 + ivtmp.45_89 * 1], *_44, tmp122
# main.c:95:             for(int k=0; k<M; k++){
	addq	$8, %rax	#, ivtmp.45
# main.c:96:                 C[i][j] += A[i][k] * B[k][j];
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp122, _47, _47
	vmovsd	%xmm1, (%rsi)	# _47, *_34
# main.c:95:             for(int k=0; k<M; k++){
	cmpq	%rax, %r8	# ivtmp.45, _84
	jne	.L5	#,
# main.c:93:         for(int j=0; j<N; j++) {
	addq	$8, %rcx	#, ivtmp.50
	cmpq	%rcx, %r10	# ivtmp.50, _80
	jne	.L7	#,
	addq	$1, %r11	#, ivtmp.53
	cmpl	%r11d, %ebx	# ivtmp.53, _25
	jg	.L6	#,
.L14:
# main.c:89:     #pragma omp parallel for
	addq	$8, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
	ret	
.L2:
	.cfi_restore_state
	addl	$1, %eax	#, q.3_1
# main.c:89:     #pragma omp parallel for
	xorl	%edx, %edx	# tt.4_2
	jmp	.L9	#
	.cfi_endproc
.LFE6655:
	.size	multicore_matrix_multiply._omp_fn.0, .-multicore_matrix_multiply._omp_fn.0
	.p2align 4
	.type	matrix_multiply_combination._omp_fn.0, @function
matrix_multiply_combination._omp_fn.0:
.LFB6656:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	movq	%rdi, %r13	# tmp170, .omp_data_i
	pushq	%r12	#
	pushq	%rbx	#
	andq	$-32, %rsp	#,
	subq	$96, %rsp	#,
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	call	omp_get_num_threads@PLT	#
	movl	%eax, %ebx	# tmp171, _18
	call	omp_get_thread_num@PLT	#
	movl	24(%r13), %edx	# *.omp_data_i_11(D).L, *.omp_data_i_11(D).L
	movl	%eax, %ecx	# tmp172, _19
	leal	62(%rdx), %eax	#, tmp147
	addl	$31, %edx	#, tmp143
	cmovns	%edx, %eax	# tmp147,, tmp143, tmp146
	sarl	$5, %eax	#, tmp148
	cltd
	idivl	%ebx	# _18
	cmpl	%edx, %ecx	# tt.9_2, _19
	jl	.L18	#,
.L29:
	imull	%eax, %ecx	# q.8_1, tmp151
	addl	%ecx, %edx	# tmp151, _26
	addl	%edx, %eax	# _26, _27
	cmpl	%eax, %edx	# _27, _26
	jge	.L56	#,
# main.c:185:     #pragma omp parallel for
	movl	32(%r13), %ebx	# *.omp_data_i_11(D).N, N
	sall	$5, %edx	#, _26
	sall	$5, %eax	#, _27
	movl	28(%r13), %r9d	# *.omp_data_i_11(D).M, M
	movl	%edx, %r14d	# _26, sj
	movl	%eax, %ecx	# _27, _29
	testl	%ebx, %ebx	# N
	jle	.L56	#,
	testl	%r9d, %r9d	# M
	jle	.L56	#,
	movq	0(%r13), %rax	# *.omp_data_i_11(D).A, A
	movslq	%edx, %rdx	# sj, sj
	movl	%r9d, 60(%rsp)	# M, %sfp
	movl	%r14d, %r10d	# sj, sj
	movq	16(%r13), %r12	# *.omp_data_i_11(D).C, C
	movq	8(%r13), %r15	# *.omp_data_i_11(D).B, B
	leaq	0(,%rdx,8), %r13	#, ivtmp.114
	movq	%rax, %r9	# A, A
	movl	%ecx, %eax	# _29, _29
.L23:
	movq	$0, 72(%rsp)	#, %sfp
# main.c:189:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	xorl	%ecx, %ecx	# si
	leal	31(%r10), %r14d	#, tmp165
	movl	%eax, %edx	# _29, _29
.L27:
	movq	72(%rsp), %rax	# %sfp, _66
	movl	%ebx, 56(%rsp)	# N, %sfp
	xorl	%edi, %edi	# ivtmp.98
	leal	31(%rcx), %esi	#, tmp166
	movq	%r12, 48(%rsp)	# C, %sfp
	movl	$31, %r11d	#, ivtmp.99
	salq	$8, %rax	#, _66
	leaq	(%r12,%rax), %r8	#, _64
	addq	%r9, %rax	# A, _56
	movq	%rax, 64(%rsp)	# _56, %sfp
.L21:
	movl	%r10d, 88(%rsp)	# sj, %sfp
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	64(%rsp), %r12	# %sfp, ivtmp.91
	movq	%r8, %rbx	# _64, ivtmp.90
# main.c:165:     for (int i=si; i<si+BLOCK_SIZE; i++){
	movl	%ecx, %eax	# si, i
	movq	%r9, 40(%rsp)	# A, %sfp
	movl	%ecx, 32(%rsp)	# si, %sfp
	movq	%r13, 80(%rsp)	# ivtmp.114, %sfp
	movq	%r8, 24(%rsp)	# _64, %sfp
	movl	%edx, 36(%rsp)	# _29, %sfp
	movl	%esi, %edx	# tmp166, tmp166
	.p2align 4,,10
	.p2align 3
.L22:
# main.c:189:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	movq	80(%rsp), %rcx	# %sfp, ivtmp.83
# main.c:166:         for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	movl	88(%rsp), %r10d	# %sfp, j
	movl	%eax, 92(%rsp)	# i, %sfp
	.p2align 4,,10
	.p2align 3
.L25:
	movq	(%r12), %r9	# MEM[(double * *)_96], MEM[(double * *)_96]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%r15,%rdi,8), %r8	# MEM[(double * *)B_16 + ivtmp.72_133 * 8], MEM[(double * *)B_16 + ivtmp.72_133 * 8]
	movl	%r11d, %esi	# ivtmp.99, tmp167
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leaq	1(%rdi), %rax	#, ivtmp.72
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%rbx), %r13	# MEM[(double * *)_98], MEM[(double * *)_98]
	subl	%edi, %esi	# ivtmp.98, tmp167
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r9,%rdi,8), %ymm0	#* MEM[(double * *)_96], tmp154
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r8,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_53], tmp154, tmp159
	andl	$3, %esi	#, tmp168
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	0(%r13,%rcx), %ymm0, %ymm1	# MEM[(__m256d * {ref-all})_42], tmp159, c0
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	cmpl	%eax, %r11d	# ivtmp.72, ivtmp.99
	jl	.L51	#,
	testl	%esi, %esi	# tmp168
	je	.L24	#,
	cmpl	$1, %esi	#, tmp168
	je	.L46	#,
	cmpl	$2, %esi	#, tmp168
	je	.L47	#,
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%r15,%rax,8), %r8	# MEM[(double * *)B_16 + ivtmp.72_133 * 8], MEM[(double * *)B_16 + ivtmp.72_133 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r9,%rax,8), %ymm0	#* MEM[(double * *)_96], tmp154
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leaq	2(%rdi), %rax	#, ivtmp.72
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r8,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_53], tmp154, tmp159
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp159, c0, c0
.L47:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%r15,%rax,8), %r8	# MEM[(double * *)B_16 + ivtmp.72_133 * 8], MEM[(double * *)B_16 + ivtmp.72_133 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r9,%rax,8), %ymm0	#* MEM[(double * *)_96], tmp154
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	addq	$1, %rax	#, ivtmp.72
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r8,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_53], tmp154, tmp159
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp159, c0, c0
.L46:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%r15,%rax,8), %r8	# MEM[(double * *)B_16 + ivtmp.72_133 * 8], MEM[(double * *)B_16 + ivtmp.72_133 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r9,%rax,8), %ymm0	#* MEM[(double * *)_96], tmp154
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	addq	$1, %rax	#, ivtmp.72
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r8,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_53], tmp154, tmp159
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp159, c0, c0
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	cmpl	%eax, %r11d	# ivtmp.72, ivtmp.99
	jl	.L51	#,
.L24:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%r15,%rax,8), %rsi	# MEM[(double * *)B_16 + ivtmp.72_133 * 8], MEM[(double * *)B_16 + ivtmp.72_133 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r9,%rax,8), %ymm0	#* MEM[(double * *)_96], tmp154
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leaq	1(%rax), %r8	#, tmp169
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%rsi,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_53], tmp154, tmp159
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%r15,%r8,8), %rsi	# MEM[(double * *)B_16 + ivtmp.72_133 * 8], MEM[(double * *)B_16 + ivtmp.72_133 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp159, c0, c0
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	8(%r9,%rax,8), %ymm0	#, tmp154
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%rsi,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_53], tmp154, tmp159
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	addq	$2, %rax	#, ivtmp.72
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%r15,%rax,8), %rsi	# MEM[(double * *)B_16 + ivtmp.72_133 * 8], MEM[(double * *)B_16 + ivtmp.72_133 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp159, c0, c0
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r9,%rax,8), %ymm0	#* MEM[(double * *)_96], tmp154
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%rsi,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_53], tmp154, tmp159
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leaq	3(%r8), %rax	#, ivtmp.72
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	16(%r15,%r8,8), %rsi	# MEM[(double * *)B_16 + ivtmp.72_133 * 8], MEM[(double * *)B_16 + ivtmp.72_133 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp159, c0, c0
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	16(%r9,%r8,8), %ymm0	#, tmp154
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%rsi,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_53], tmp154, tmp159
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp159, c0, c0
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	cmpl	%eax, %r11d	# ivtmp.72, ivtmp.99
	jge	.L24	#,
	.p2align 4,,10
	.p2align 3
.L51:
# main.c:166:         for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	addl	$4, %r10d	#, j
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:875:   *(__m256d *)__P = __A;
	vmovapd	%ymm1, 0(%r13,%rcx)	# c0, MEM[(__m256d * {ref-all})_61]
# main.c:166:         for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	addq	$32, %rcx	#, ivtmp.83
	cmpl	%r10d, %r14d	# j, tmp165
	jge	.L25	#,
# main.c:165:     for (int i=si; i<si+BLOCK_SIZE; i++){
	movl	92(%rsp), %eax	# %sfp, i
# main.c:165:     for (int i=si; i<si+BLOCK_SIZE; i++){
	addq	$8, %rbx	#, ivtmp.90
	addq	$8, %r12	#, ivtmp.91
# main.c:165:     for (int i=si; i<si+BLOCK_SIZE; i++){
	addl	$1, %eax	#, i
# main.c:165:     for (int i=si; i<si+BLOCK_SIZE; i++){
	cmpl	%edx, %eax	# tmp166, i
	jle	.L22	#,
# main.c:191:             for(int sk=0; sk<M; sk+=BLOCK_SIZE){
	movl	%edx, %esi	# tmp166, tmp166
	movl	88(%rsp), %r10d	# %sfp, sj
	movq	40(%rsp), %r9	# %sfp, A
	addq	$32, %rdi	#, ivtmp.98
	movl	32(%rsp), %ecx	# %sfp, si
	movq	80(%rsp), %r13	# %sfp, ivtmp.114
	addl	$32, %r11d	#, ivtmp.99
	movq	24(%rsp), %r8	# %sfp, _64
	movl	36(%rsp), %edx	# %sfp, _29
	cmpl	%edi, 60(%rsp)	# ivtmp.98, %sfp
	jg	.L21	#,
# main.c:189:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	movl	56(%rsp), %ebx	# %sfp, N
	addl	$32, %ecx	#, si
# main.c:189:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	addq	$1, 72(%rsp)	#, %sfp
# main.c:189:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	movq	48(%rsp), %r12	# %sfp, C
# main.c:189:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	cmpl	%ecx, %ebx	# si, N
	jg	.L27	#,
	addl	$32, %r10d	#, sj
	movl	%edx, %eax	# _29, _29
	addq	$256, %r13	#, ivtmp.114
	cmpl	%r10d, %edx	# sj, _29
	jg	.L23	#,
	vzeroupper
.L56:
# main.c:185:     #pragma omp parallel for
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
.L18:
	.cfi_restore_state
	addl	$1, %eax	#, q.8_1
# main.c:185:     #pragma omp parallel for
	xorl	%edx, %edx	# tt.9_2
	jmp	.L29	#
	.cfi_endproc
.LFE6656:
	.size	matrix_multiply_combination._omp_fn.0, .-matrix_multiply_combination._omp_fn.0
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"usage: %s <L> <M> <N> <seed>\n"
	.text
	.p2align 4
	.globl	print_help_and_exit
	.type	print_help_and_exit, @function
print_help_and_exit:
.LFB6642:
	.cfi_startproc
	endbr64	
	pushq	%rax	#
	.cfi_def_cfa_offset 16
	popq	%rax	#
	.cfi_def_cfa_offset 8
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC0(%rip), %rsi	#, tmp85
	xorl	%eax, %eax	#
# main.c:18: void print_help_and_exit(char **argv) {
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 16
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	(%rdi), %rdx	# *argv_3(D), *argv_3(D)
	movl	$2, %edi	#,
	call	__printf_chk@PLT	#
# main.c:20:     exit(0);
	xorl	%edi, %edi	#
	call	exit@PLT	#
	.cfi_endproc
.LFE6642:
	.size	print_help_and_exit, .-print_help_and_exit
	.section	.rodata.str1.1
.LC1:
	.string	"%f "
	.text
	.p2align 4
	.globl	print_matrix
	.type	print_matrix, @function
print_matrix:
.LFB6643:
	.cfi_startproc
	endbr64	
# main.c:24:    for(int i=0; i<rows; i++) {
	testl	%esi, %esi	# rows
	jle	.L72	#,
# main.c:23: void print_matrix(double **mat, int rows, int cols) {
	pushq	%r14	#
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	movslq	%esi, %rsi	# rows, rows
	movq	%rdi, %r14	# mat, ivtmp.131
	pushq	%r13	#
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	leaq	(%rdi,%rsi,8), %r13	#, _9
	pushq	%r12	#
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp	#
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movslq	%edx, %rbp	# cols, cols
	pushq	%rbx	#
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	salq	$3, %rbp	#, _24
	movl	%edx, %ebx	# tmp105, cols
.L62:
# main.c:25:         for(int j=0; j<cols; j++){
	testl	%ebx, %ebx	# cols
	jle	.L69	#,
	leaq	.LC1(%rip), %r12	#, tmp102
	.p2align 4,,10
	.p2align 3
.L64:
# main.c:23: void print_matrix(double **mat, int rows, int cols) {
	xorl	%ebx, %ebx	# ivtmp.126
	.p2align 4,,10
	.p2align 3
.L63:
# main.c:26:            printf("%f ", mat[i][j]);
	movq	(%r14), %rax	# MEM[(double * *)_36], MEM[(double * *)_36]
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movq	%r12, %rsi	# tmp102,
	movl	$2, %edi	#,
	vmovsd	(%rax,%rbx), %xmm0	# *_7, *_7
	movl	$1, %eax	#,
# main.c:25:         for(int j=0; j<cols; j++){
	addq	$8, %rbx	#, ivtmp.126
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	__printf_chk@PLT	#
# main.c:25:         for(int j=0; j<cols; j++){
	cmpq	%rbx, %rbp	# ivtmp.126, _24
	jne	.L63	#,
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$10, %edi	#,
# main.c:24:    for(int i=0; i<rows; i++) {
	addq	$8, %r14	#, ivtmp.131
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	putchar@PLT	#
# main.c:24:    for(int i=0; i<rows; i++) {
	cmpq	%r14, %r13	# ivtmp.131, _9
	jne	.L64	#,
.L70:
# main.c:30: }
	popq	%rbx	#
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp	#
	.cfi_def_cfa_offset 32
	popq	%r12	#
	.cfi_def_cfa_offset 24
	popq	%r13	#
	.cfi_def_cfa_offset 16
	popq	%r14	#
	.cfi_def_cfa_offset 8
	ret	
.L69:
	.cfi_restore_state
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	movl	$10, %edi	#,
# main.c:24:    for(int i=0; i<rows; i++) {
	addq	$8, %r14	#, ivtmp.131
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	call	putchar@PLT	#
# main.c:24:    for(int i=0; i<rows; i++) {
	cmpq	%r14, %r13	# ivtmp.131, _9
	jne	.L62	#,
	jmp	.L70	#
.L72:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	.cfi_restore 14
	ret	
	.cfi_endproc
.LFE6643:
	.size	print_matrix, .-print_matrix
	.p2align 4
	.globl	drand
	.type	drand, @function
drand:
.LFB6644:
	.cfi_startproc
	endbr64	
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 32
# main.c:32: double drand(double min, double max){ //
	vmovsd	%xmm0, 8(%rsp)	# min, %sfp
	vmovsd	%xmm1, (%rsp)	# max, %sfp
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	call	rand@PLT	#
# main.c:34:     random_double = (random_double * (max - min)) + min;
	vmovsd	8(%rsp), %xmm0	# %sfp, min
	vmovsd	(%rsp), %xmm1	# %sfp, max
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	vxorps	%xmm2, %xmm2, %xmm2	# tmp98
	vcvtsi2sdl	%eax, %xmm2, %xmm2	# tmp97, tmp98, tmp99
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	vdivsd	.LC2(%rip), %xmm2, %xmm2	#, tmp90, random_double
# main.c:36: }
	addq	$24, %rsp	#,
	.cfi_def_cfa_offset 8
# main.c:34:     random_double = (random_double * (max - min)) + min;
	vsubsd	%xmm0, %xmm1, %xmm1	# min, max, tmp93
# main.c:34:     random_double = (random_double * (max - min)) + min;
	vmulsd	%xmm1, %xmm2, %xmm1	# tmp93, random_double, _4
# main.c:34:     random_double = (random_double * (max - min)) + min;
	vaddsd	%xmm0, %xmm1, %xmm0	# min, _4, random_double
# main.c:36: }
	ret	
	.cfi_endproc
.LFE6644:
	.size	drand, .-drand
	.p2align 4
	.globl	matrix_multiply
	.type	matrix_multiply, @function
matrix_multiply:
.LFB6645:
	.cfi_startproc
	endbr64	
# main.c:45:     for(int i=0; i<L; i++) {
	testl	%ecx, %ecx	# L
	jle	.L88	#,
# main.c:43: void matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
	pushq	%r13	#
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12	#
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp	#
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx	#
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rdx, %rbx	# tmp114, C
	movslq	%r9d, %rdx	# tmp117,
	testl	%edx, %edx	# N
	jle	.L86	#,
	movslq	%r8d, %rax	# tmp116,
	testl	%eax, %eax	# M
	jle	.L86	#,
	movslq	%ecx, %rcx	# L, L
	movq	%rdi, %r10	# tmp112, A
	movq	%rsi, %r11	# tmp113, B
# main.c:45:     for(int i=0; i<L; i++) {
	xorl	%r13d, %r13d	# ivtmp.158
	leaq	0(,%rcx,8), %r12	#, _61
	leaq	0(,%rdx,8), %rbp	#, _65
	leaq	0(,%rax,8), %r8	#, _69
	.p2align 4,,10
	.p2align 3
.L80:
# main.c:50:                 C[i][j] += A[i][k] * B[k][j];
	movq	(%rbx,%r13), %r9	# MEM[(double * *)C_33(D) + ivtmp.158_64 * 1], _4
# main.c:50:                 C[i][j] += A[i][k] * B[k][j];
	movq	(%r10,%r13), %rdi	# MEM[(double * *)A_34(D) + ivtmp.158_64 * 1], _10
	xorl	%ecx, %ecx	# ivtmp.151
	.p2align 4,,10
	.p2align 3
.L83:
# main.c:50:                 C[i][j] += A[i][k] * B[k][j];
	leaq	(%r9,%rcx), %rsi	#, _7
	xorl	%eax, %eax	# ivtmp.147
	vmovsd	(%rsi), %xmm1	# *_7, _20
	.p2align 4,,10
	.p2align 3
.L81:
# main.c:50:                 C[i][j] += A[i][k] * B[k][j];
	movq	(%r11,%rax), %rdx	# MEM[(double * *)B_35(D) + ivtmp.147_74 * 1], MEM[(double * *)B_35(D) + ivtmp.147_74 * 1]
# main.c:50:                 C[i][j] += A[i][k] * B[k][j];
	vmovsd	(%rdx,%rcx), %xmm0	# *_17, *_17
	vmulsd	(%rdi,%rax), %xmm0, %xmm0	# MEM[(double *)_10 + ivtmp.147_74 * 1], *_17, tmp110
# main.c:49:             for(int k=0; k<M; k++){
	addq	$8, %rax	#, ivtmp.147
# main.c:50:                 C[i][j] += A[i][k] * B[k][j];
	vaddsd	%xmm0, %xmm1, %xmm1	# tmp110, _20, _20
	vmovsd	%xmm1, (%rsi)	# _20, *_7
# main.c:49:             for(int k=0; k<M; k++){
	cmpq	%rax, %r8	# ivtmp.147, _69
	jne	.L81	#,
# main.c:47:         for(int j=0; j<N; j++) {
	addq	$8, %rcx	#, ivtmp.151
	cmpq	%rcx, %rbp	# ivtmp.151, _65
	jne	.L83	#,
# main.c:45:     for(int i=0; i<L; i++) {
	addq	$8, %r13	#, ivtmp.158
	cmpq	%r13, %r12	# ivtmp.158, _61
	jne	.L80	#,
.L86:
# main.c:54: }
	popq	%rbx	#
	.cfi_def_cfa_offset 32
	popq	%rbp	#
	.cfi_def_cfa_offset 24
	popq	%r12	#
	.cfi_def_cfa_offset 16
	popq	%r13	#
	.cfi_def_cfa_offset 8
	ret	
.L88:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret	
	.cfi_endproc
.LFE6645:
	.size	matrix_multiply, .-matrix_multiply
	.p2align 4
	.globl	unrolled_matrix_multiply
	.type	unrolled_matrix_multiply, @function
unrolled_matrix_multiply:
.LFB6646:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movslq	%ecx, %rax	# tmp225,
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	pushq	%rbx	#
	andq	$-32, %rsp	#,
	subq	$160, %rsp	#,
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# main.c:61: void unrolled_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
	movq	%rdi, 40(%rsp)	# tmp222, %sfp
	movq	%fs:40, %rcx	# MEM[(<address-space-1> long unsigned int *)40B], tmp228
	movq	%rcx, 152(%rsp)	# tmp228, D.41265
	xorl	%ecx, %ecx	# tmp228
# main.c:63:     for(int i=0; i<L; i++) {
	testl	%eax, %eax	# L
	jle	.L91	#,
	movl	%r9d, %r13d	# tmp227, N
	testl	%r9d, %r9d	# N
	jle	.L91	#,
	movl	%r8d, %r11d	# M, bnd.169
	movq	%rdx, 24(%rsp)	# C, %sfp
	movl	%r8d, %r15d	# M, tmp214
	movq	%rsi, %r10	# tmp223, B
	shrl	$2, %r11d	#,
	movl	%r8d, %ebx	# tmp226, M
	xorl	%esi, %esi	# ivtmp.222
	andl	$3, %r15d	#, tmp214
	leaq	0(,%rax,8), %rdi	#, _176
	leal	-1(%r8), %eax	#, _118
	salq	$5, %r11	#, _15
	movl	%eax, 80(%rsp)	# _118, %sfp
	movl	%r8d, %eax	# M, _142
	leaq	96(%rsp), %r14	#, ivtmp.207
	leaq	128(%rsp), %r12	#, _129
	andl	$-4, %eax	#, _142
	movq	%rdi, 32(%rsp)	# _176, %sfp
	movl	%eax, 76(%rsp)	# _142, %sfp
.L93:
	movq	24(%rsp), %rax	# %sfp, C
	movq	%rsi, %rdi	# ivtmp.222, ivtmp.222
	xorl	%edx, %edx	# j
	movq	(%rax,%rsi), %rax	# MEM[(double * *)C_55(D) + ivtmp.222_173 * 1], ivtmp.214
	movl	%r13d, %esi	# N, N
	movq	%r12, %r13	# _129, _129
	.p2align 4,,10
	.p2align 3
.L102:
# main.c:68:                 C_temp[u] = C[i][j+u];
	vmovupd	(%rax), %ymm5	# MEM <vector(4) double> [(double *)_112], tmp298
	movq	%r14, %rcx	# ivtmp.207, ivtmp.207
	movl	%edx, %r9d	# j, ivtmp.208
	vmovapd	%ymm5, 96(%rsp)	# tmp298, MEM <vector(4) double> [(double *)&C_temp]
.L101:
# main.c:72:             	for(int k=0; k<M; k++){
	testl	%ebx, %ebx	# M
	jle	.L111	#,
	movq	40(%rsp), %r8	# %sfp, A
	movl	%edx, 72(%rsp)	# j, %sfp
	movq	%rax, 64(%rsp)	# ivtmp.214, %sfp
	movq	%rcx, 88(%rsp)	# ivtmp.207, %sfp
	movq	(%r8,%rdi), %r12	# MEM[(double * *)A_60(D) + ivtmp.222_173 * 1], _14
	movq	%rdi, 56(%rsp)	# ivtmp.222, %sfp
	movl	%esi, 52(%rsp)	# N, %sfp
.L97:
	movq	88(%rsp), %rax	# %sfp, ivtmp.207
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	movslq	%r9d, %rdx	# ivtmp.208, ivtmp.208
	cmpl	$2, 80(%rsp)	#, %sfp
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	leaq	0(,%rdx,8), %rsi	#, _23
	vmovsd	(%rax), %xmm2	# MEM[(double *)_108], C_temp_I_lsm.166
	jbe	.L104	#,
	movl	%r9d, 84(%rsp)	# ivtmp.208, %sfp
	xorl	%eax, %eax	# ivtmp.196
	.p2align 4,,10
	.p2align 3
.L95:
	leaq	(%r10,%rax), %rcx	#, _29
	movq	(%rcx), %r8	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_29], 64, 0>, BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_29], 64, 0>
	movq	16(%rcx), %r9	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_29], 64, 128>, BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_29], 64, 128>
	movq	8(%rcx), %rdi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_29], 64, 64>, BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_29], 64, 64>
	movq	24(%rcx), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_29], 64, 192>, BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_29], 64, 192>
	vmovsd	(%r9,%rsi), %xmm1	# MEM[(double *)_36], MEM[(double *)_36]
	vmovsd	(%r8,%rsi), %xmm0	# MEM[(double *)_45], MEM[(double *)_45]
	vmovhpd	(%rcx,%rsi), %xmm1, %xmm1	# MEM[(double *)_8], MEM[(double *)_36], tmp180
	vmovhpd	(%rdi,%rsi), %xmm0, %xmm0	# MEM[(double *)_41], MEM[(double *)_45], tmp183
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp180, tmp183, vect__25.178
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	vmulpd	(%r12,%rax), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)_14 + ivtmp.196_80 * 1], vect__25.178, vect__26.179
	addq	$32, %rax	#, ivtmp.196
	vaddsd	%xmm2, %xmm0, %xmm2	# C_temp_I_lsm.166, stmp__27.180, stmp__27.180
	vunpckhpd	%xmm0, %xmm0, %xmm1	# tmp187, stmp__27.180
	vextractf128	$0x1, %ymm0, %xmm0	# vect__26.179, tmp189
	vaddsd	%xmm2, %xmm1, %xmm1	# stmp__27.180, stmp__27.180, stmp__27.180
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	vaddsd	%xmm0, %xmm1, %xmm1	# stmp__27.180, stmp__27.180, stmp__27.180
	vunpckhpd	%xmm0, %xmm0, %xmm0	# tmp189, stmp__27.180
	vaddsd	%xmm0, %xmm1, %xmm2	# stmp__27.180, stmp__27.180, C_temp_I_lsm.166
	cmpq	%rax, %r11	# ivtmp.196, _15
	jne	.L95	#,
	movl	84(%rsp), %r9d	# %sfp, ivtmp.208
	testl	%r15d, %r15d	# tmp214
	je	.L96	#,
# main.c:72:             	for(int k=0; k<M; k++){
	movl	76(%rsp), %eax	# %sfp, k
.L94:
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	movslq	%eax, %rdi	# k, k
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	movq	(%r10,%rdi,8), %rcx	# *_24, *_24
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	leaq	0(,%rdi,8), %rsi	#, _18
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	vmovsd	(%rcx,%rdx,8), %xmm0	# *_26, *_26
	vmulsd	(%r12,%rdi,8), %xmm0, %xmm0	# *_19, *_26, tmp196
# main.c:72:             	for(int k=0; k<M; k++){
	leal	1(%rax), %edi	#, k
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	vaddsd	%xmm0, %xmm2, %xmm2	# tmp196, C_temp_I_lsm.166, C_temp_I_lsm.166
# main.c:72:             	for(int k=0; k<M; k++){
	cmpl	%edi, %ebx	# k, M
	jle	.L96	#,
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	movq	8(%r10,%rsi), %rdi	# *_95, *_95
# main.c:72:             	for(int k=0; k<M; k++){
	addl	$2, %eax	#, k
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	vmovsd	(%rdi,%rdx,8), %xmm0	# *_97, *_97
	vmulsd	8(%r12,%rsi), %xmm0, %xmm0	# *_92, *_97, tmp200
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	vaddsd	%xmm0, %xmm2, %xmm2	# tmp200, C_temp_I_lsm.166, C_temp_I_lsm.166
# main.c:72:             	for(int k=0; k<M; k++){
	cmpl	%eax, %ebx	# k, M
	jle	.L96	#,
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	movq	16(%r10,%rsi), %rax	# *_144, *_144
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	vmovsd	(%rax,%rdx,8), %xmm0	# *_136, *_136
	vmulsd	16(%r12,%rsi), %xmm0, %xmm0	# *_146, *_136, tmp204
# main.c:73:                     C_temp[u] += A[i][k] * B[k][j+u];
	vaddsd	%xmm0, %xmm2, %xmm2	# tmp204, C_temp_I_lsm.166, C_temp_I_lsm.166
.L96:
	movq	88(%rsp), %rax	# %sfp, ivtmp.207
# main.c:70: 	    for (int u=0; u<UNROLL; u++){
	addl	$1, %r9d	#, ivtmp.208
	vmovsd	%xmm2, (%rax)	# C_temp_I_lsm.166, MEM[(double *)_108]
	addq	$8, %rax	#, ivtmp.207
	movq	%rax, 88(%rsp)	# ivtmp.207, %sfp
	cmpq	%rax, %r13	# ivtmp.207, _129
	jne	.L97	#,
	movl	72(%rsp), %edx	# %sfp, j
	movq	64(%rsp), %rax	# %sfp, ivtmp.214
	movq	56(%rsp), %rdi	# %sfp, ivtmp.222
	movl	52(%rsp), %esi	# %sfp, N
.L98:
# main.c:77: 	        C[i][j+u] = C_temp[u];
	vmovapd	96(%rsp), %ymm4	# MEM <vector(4) double> [(double *)&C_temp], tmp297
# main.c:65:         for(int j=0; j<N; j+=UNROLL) {
	addl	$4, %edx	#, j
# main.c:65:         for(int j=0; j<N; j+=UNROLL) {
	addq	$32, %rax	#, ivtmp.214
# main.c:77: 	        C[i][j+u] = C_temp[u];
	vmovupd	%ymm4, -32(%rax)	# tmp297, MEM <vector(4) double> [(double *)_112]
# main.c:65:         for(int j=0; j<N; j+=UNROLL) {
	cmpl	%edx, %esi	# j, N
	jg	.L102	#,
# main.c:63:     for(int i=0; i<L; i++) {
	movq	%r13, %r12	# _129, _129
	movq	32(%rsp), %rax	# %sfp, _176
	movl	%esi, %r13d	# N, N
	movq	%rdi, %rsi	# ivtmp.222, ivtmp.222
	addq	$8, %rsi	#, ivtmp.222
	cmpq	%rax, %rsi	# _176, ivtmp.222
	jne	.L93	#,
	vzeroupper
.L91:
# main.c:81: }
	movq	152(%rsp), %rax	# D.41265, tmp229
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp229
	jne	.L116	#,
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret	
	.p2align 4,,10
	.p2align 3
.L111:
	.cfi_restore_state
# main.c:70: 	    for (int u=0; u<UNROLL; u++){
	addq	$8, %rcx	#, ivtmp.207
	addl	$1, %r9d	#, ivtmp.208
	cmpq	%r13, %rcx	# _129, ivtmp.207
	jne	.L101	#,
	jmp	.L98	#
.L104:
# main.c:72:             	for(int k=0; k<M; k++){
	xorl	%eax, %eax	# k
	jmp	.L94	#
.L116:
# main.c:81: }
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE6646:
	.size	unrolled_matrix_multiply, .-unrolled_matrix_multiply
	.p2align 4
	.globl	multicore_matrix_multiply
	.type	multicore_matrix_multiply, @function
multicore_matrix_multiply:
.LFB6647:
	.cfi_startproc
	endbr64	
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 64
# main.c:88: void multicore_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp98
	movq	%rax, 40(%rsp)	# tmp98, D.41270
	xorl	%eax, %eax	# tmp98
# main.c:89:     #pragma omp parallel for
	movl	%ecx, 24(%rsp)	# tmp95, .omp_data_o.2.L
	xorl	%ecx, %ecx	#
	movq	%rdx, 16(%rsp)	# tmp94, .omp_data_o.2.C
	xorl	%edx, %edx	#
	movq	%rsi, 8(%rsp)	# tmp93, .omp_data_o.2.B
	movq	%rsp, %rsi	#, tmp89
	movq	%rdi, (%rsp)	# tmp92, .omp_data_o.2.A
	leaq	multicore_matrix_multiply._omp_fn.0(%rip), %rdi	#, tmp90
	movl	%r9d, 32(%rsp)	# tmp97, .omp_data_o.2.N
	movl	%r8d, 28(%rsp)	# tmp96, .omp_data_o.2.M
	call	GOMP_parallel@PLT	#
# main.c:100: }
	movq	40(%rsp), %rax	# D.41270, tmp99
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp99
	jne	.L121	#,
	addq	$56, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L121:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE6647:
	.size	multicore_matrix_multiply, .-multicore_matrix_multiply
	.p2align 4
	.globl	do_block
	.type	do_block, @function
do_block:
.LFB6648:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movslq	%edi, %rdi	# tmp436, si
	movslq	%esi, %rsi	# tmp437, sj
	movslq	%edx, %rdx	# tmp438, sk
	leaq	0(,%rdi,8), %rax	#, ivtmp.263
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	pushq	%rbx	#
	andq	$-32, %rsp	#,
	subq	$136, %rsp	#,
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rax, -56(%rsp)	# ivtmp.263, %sfp
	addq	$256, %rax	#, _145
	movq	%rax, -80(%rsp)	# _145, %sfp
	leaq	0(,%rsi,8), %rax	#, ivtmp.251
	movq	%rax, -72(%rsp)	# ivtmp.251, %sfp
	addq	$256, %rax	#, _20
	movq	%rax, 112(%rsp)	# _20, %sfp
	leaq	0(,%rdx,8), %rax	#, _98
	movq	%rax, -64(%rsp)	# _98, %sfp
	addq	%r8, %rax	# tmp440, vectp.236
	movq	24(%rax), %rbx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94], 64, 192>, _60
	movq	16(%rax), %r15	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94], 64, 128>, _41
# main.c:102: void do_block(int si, int sj, int sk, double **A, double **B, double **C){
	movq	%rcx, -88(%rsp)	# tmp439, %sfp
	movq	%r9, -96(%rsp)	# tmp441, %sfp
	movq	(%rax), %r14	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94], 64, 0>, _11
	movq	%rbx, 104(%rsp)	# _60, %sfp
	movq	8(%rax), %rbx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94], 64, 64>, _15
	movq	%rbx, 120(%rsp)	# _15, %sfp
	movq	56(%rax), %rbx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 32B], 64, 192>, _125
	movq	%rbx, 56(%rsp)	# _125, %sfp
	movq	48(%rax), %r13	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 32B], 64, 128>, _121
	movq	40(%rax), %rdi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 32B], 64, 64>, _117
	movq	184(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 160B], 64, 192>, _265
	movq	88(%rax), %rbx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 64B], 64, 192>, _160
	movq	32(%rax), %r12	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 32B], 64, 0>, _113
	movq	64(%rax), %r11	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 64B], 64, 0>, _148
	movq	112(%rax), %r10	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 96B], 64, 128>, _191
	movq	%rdi, 64(%rsp)	# _117, %sfp
	movq	72(%rax), %rdi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 64B], 64, 64>, _152
	movq	96(%rax), %r9	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 96B], 64, 0>, _183
	movq	%rcx, -16(%rsp)	# _265, %sfp
	movq	168(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 160B], 64, 64>, _257
	movq	%rbx, 40(%rsp)	# _160, %sfp
	movq	144(%rax), %r8	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 128B], 64, 128>, _226
	movq	80(%rax), %rbx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 64B], 64, 128>, _156
	movq	%rdi, 48(%rsp)	# _152, %sfp
	movq	120(%rax), %rdi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 96B], 64, 192>, _195
	movq	176(%rax), %rsi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 160B], 64, 128>, _261
	movq	%rcx, -8(%rsp)	# _257, %sfp
	movq	160(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 160B], 64, 0>, _253
	movq	%rdi, 24(%rsp)	# _195, %sfp
	movq	104(%rax), %rdi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 96B], 64, 64>, _187
	movq	%rcx, (%rsp)	# _253, %sfp
	movq	216(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 192B], 64, 192>, _300
	movq	%rdi, 32(%rsp)	# _187, %sfp
	movq	152(%rax), %rdi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 128B], 64, 192>, _230
	movq	%rcx, -48(%rsp)	# _300, %sfp
	movq	208(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 192B], 64, 128>, _296
	movq	%rdi, 8(%rsp)	# _230, %sfp
	movq	136(%rax), %rdi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 128B], 64, 64>, _222
	movq	%rdi, 16(%rsp)	# _222, %sfp
	movq	128(%rax), %rdi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 128B], 64, 0>, _218
	movq	%rcx, -40(%rsp)	# _296, %sfp
	movq	200(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 192B], 64, 64>, _292
	movq	%rcx, -32(%rsp)	# _292, %sfp
	movq	192(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 192B], 64, 0>, _288
	movq	%rcx, -24(%rsp)	# _288, %sfp
	movq	248(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 224B], 64, 192>, _76
	movq	%rcx, 96(%rsp)	# _76, %sfp
	movq	240(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 224B], 64, 128>, _80
	movq	%rcx, 88(%rsp)	# _80, %sfp
	movq	232(%rax), %rcx	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 224B], 64, 64>, _84
	movq	224(%rax), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)vectp.236_94 + 224B], 64, 0>, _88
	movq	%rcx, 80(%rsp)	# _84, %sfp
	movq	%rax, 72(%rsp)	# _88, %sfp
.L123:
# main.c:106: 	    double C_ij = C[i][j];
	movq	-56(%rsp), %rax	# %sfp, ivtmp.263
	movq	-96(%rsp), %rcx	# %sfp, C
	movq	-64(%rsp), %rdx	# %sfp, vectp.233
	movq	(%rcx,%rax), %rcx	# MEM[(double * *)C_33(D) + ivtmp.263_19 * 1], _4
	movq	%rcx, 128(%rsp)	# _4, %sfp
	movq	-88(%rsp), %rcx	# %sfp, A
	addq	(%rcx,%rax), %rdx	# MEM[(double * *)A_38(D) + ivtmp.263_19 * 1], vectp.233
	movq	128(%rsp), %rcx	# %sfp, _4
	movq	%rsi, 128(%rsp)	# _261, %sfp
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	movq	-72(%rsp), %rax	# %sfp, ivtmp.251
	.p2align 4,,10
	.p2align 3
.L124:
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%r15), %xmm0	# MEM[(double *)_93], MEM[(double *)_93]
	movq	104(%rsp), %rsi	# %sfp, _60
	vmovsd	(%r14,%rax), %xmm1	# MEM[(double *)_13], MEM[(double *)_13]
	vmovsd	(%rcx,%rax), %xmm2	# MEM[(double *)_4 + ivtmp.251_21 * 1], stmp_C_ij_40.240
	vmovhpd	(%rax,%rsi), %xmm0, %xmm0	# MEM[(double *)_57], MEM[(double *)_93], tmp323
	movq	120(%rsp), %rsi	# %sfp, _15
	vmovhpd	(%rsi,%rax), %xmm1, %xmm1	# MEM[(double *)_17], MEM[(double *)_13], tmp326
	movq	56(%rsp), %rsi	# %sfp, _125
	vinsertf128	$0x1, %xmm0, %ymm1, %ymm1	# tmp323, tmp326, vect__17.238
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	(%rdx), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.233_103], vect__17.238, vect__18.239
	vaddsd	%xmm1, %xmm2, %xmm2	# tmp330, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm0	# tmp330, stmp_C_ij_40.240
	vextractf128	$0x1, %ymm1, %xmm1	# vect__18.239, tmp332
	vaddsd	%xmm2, %xmm0, %xmm2	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm2, %xmm1, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%r13), %xmm2	# MEM[(double *)_123], MEM[(double *)_123]
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp332, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovhpd	(%rax,%rsi), %xmm2, %xmm2	# MEM[(double *)_127], MEM[(double *)_123], tmp337
	movq	64(%rsp), %rsi	# %sfp, _117
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%r12), %xmm1	# MEM[(double *)_115], MEM[(double *)_115]
	vmovhpd	(%rax,%rsi), %xmm1, %xmm1	# MEM[(double *)_119], MEM[(double *)_115], tmp340
	movq	40(%rsp), %rsi	# %sfp, _160
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp337, tmp340, vect__17.238
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	32(%rdx), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.233_103 + 32B], vect__17.238, vect__18.239
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, C_ij, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp344, stmp_C_ij_40.240
	vextractf128	$0x1, %ymm1, %xmm1	# vect__18.239, tmp346
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%rbx), %xmm2	# MEM[(double *)_158], MEM[(double *)_158]
	vmovhpd	(%rax,%rsi), %xmm2, %xmm2	# MEM[(double *)_162], MEM[(double *)_158], tmp351
	movq	48(%rsp), %rsi	# %sfp, _152
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp346, stmp_C_ij_40.240
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%r11), %xmm1	# MEM[(double *)_150], MEM[(double *)_150]
	vmovhpd	(%rax,%rsi), %xmm1, %xmm1	# MEM[(double *)_154], MEM[(double *)_150], tmp354
	movq	24(%rsp), %rsi	# %sfp, _195
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp351, tmp354, vect__17.238
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	64(%rdx), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.233_103 + 64B], vect__17.238, vect__18.239
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, C_ij, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp358, stmp_C_ij_40.240
	vextractf128	$0x1, %ymm1, %xmm1	# vect__18.239, tmp360
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%r10), %xmm2	# MEM[(double *)_193], MEM[(double *)_193]
	vmovhpd	(%rax,%rsi), %xmm2, %xmm2	# MEM[(double *)_197], MEM[(double *)_193], tmp365
	movq	32(%rsp), %rsi	# %sfp, _187
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp360, stmp_C_ij_40.240
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%r9), %xmm1	# MEM[(double *)_185], MEM[(double *)_185]
	vmovhpd	(%rax,%rsi), %xmm1, %xmm1	# MEM[(double *)_189], MEM[(double *)_185], tmp368
	movq	8(%rsp), %rsi	# %sfp, _230
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp365, tmp368, vect__17.238
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	96(%rdx), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.233_103 + 96B], vect__17.238, vect__18.239
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, C_ij, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp372, stmp_C_ij_40.240
	vextractf128	$0x1, %ymm1, %xmm1	# vect__18.239, tmp374
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%r8), %xmm2	# MEM[(double *)_228], MEM[(double *)_228]
	vmovhpd	(%rax,%rsi), %xmm2, %xmm2	# MEM[(double *)_232], MEM[(double *)_228], tmp379
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp374, stmp_C_ij_40.240
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%rdi), %xmm1	# MEM[(double *)_220], MEM[(double *)_220]
	movq	16(%rsp), %rsi	# %sfp, _222
	vmovhpd	(%rax,%rsi), %xmm1, %xmm1	# MEM[(double *)_224], MEM[(double *)_220], tmp382
	movq	128(%rsp), %rsi	# %sfp, _261
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp379, tmp382, vect__17.238
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	128(%rdx), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.233_103 + 128B], vect__17.238, vect__18.239
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, C_ij, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp386, stmp_C_ij_40.240
	vextractf128	$0x1, %ymm1, %xmm1	# vect__18.239, tmp388
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%rsi), %xmm2	# MEM[(double *)_263], MEM[(double *)_263]
	movq	-16(%rsp), %rsi	# %sfp, _265
	vmovhpd	(%rax,%rsi), %xmm2, %xmm2	# MEM[(double *)_267], MEM[(double *)_263], tmp393
	movq	(%rsp), %rsi	# %sfp, _253
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp388, stmp_C_ij_40.240
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%rsi), %xmm1	# MEM[(double *)_255], MEM[(double *)_255]
	movq	-8(%rsp), %rsi	# %sfp, _257
	vmovhpd	(%rax,%rsi), %xmm1, %xmm1	# MEM[(double *)_259], MEM[(double *)_255], tmp396
	movq	-40(%rsp), %rsi	# %sfp, _296
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp393, tmp396, vect__17.238
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	160(%rdx), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.233_103 + 160B], vect__17.238, vect__18.239
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, C_ij, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp400, stmp_C_ij_40.240
	vextractf128	$0x1, %ymm1, %xmm1	# vect__18.239, tmp402
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%rsi), %xmm2	# MEM[(double *)_298], MEM[(double *)_298]
	movq	-48(%rsp), %rsi	# %sfp, _300
	vmovhpd	(%rax,%rsi), %xmm2, %xmm2	# MEM[(double *)_302], MEM[(double *)_298], tmp407
	movq	-24(%rsp), %rsi	# %sfp, _288
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp402, stmp_C_ij_40.240
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%rsi), %xmm1	# MEM[(double *)_290], MEM[(double *)_290]
	movq	-32(%rsp), %rsi	# %sfp, _292
	vmovhpd	(%rax,%rsi), %xmm1, %xmm1	# MEM[(double *)_294], MEM[(double *)_290], tmp410
	movq	88(%rsp), %rsi	# %sfp, _80
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp407, tmp410, vect__17.238
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	192(%rdx), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.233_103 + 192B], vect__17.238, vect__18.239
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, C_ij, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp414, stmp_C_ij_40.240
	vextractf128	$0x1, %ymm1, %xmm1	# vect__18.239, tmp416
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%rsi), %xmm2	# MEM[(double *)_78], MEM[(double *)_78]
	movq	96(%rsp), %rsi	# %sfp, _76
	vmovhpd	(%rax,%rsi), %xmm2, %xmm2	# MEM[(double *)_74], MEM[(double *)_78], tmp421
	movq	72(%rsp), %rsi	# %sfp, _88
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp416, stmp_C_ij_40.240
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rax,%rsi), %xmm1	# MEM[(double *)_86], MEM[(double *)_86]
	movq	80(%rsp), %rsi	# %sfp, _84
	vmovhpd	(%rax,%rsi), %xmm1, %xmm1	# MEM[(double *)_82], MEM[(double *)_86], tmp424
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp421, tmp424, vect__17.238
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	224(%rdx), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.233_103 + 224B], vect__17.238, vect__18.239
	vaddsd	%xmm0, %xmm1, %xmm0	# C_ij, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp428, stmp_C_ij_40.240
	vaddsd	%xmm0, %xmm2, %xmm2	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
	vextractf128	$0x1, %ymm1, %xmm0	# vect__18.239, tmp430
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm2, %xmm0, %xmm1	# stmp_C_ij_40.240, stmp_C_ij_40.240, stmp_C_ij_40.240
	vunpckhpd	%xmm0, %xmm0, %xmm0	# tmp430, stmp_C_ij_40.240
	vaddsd	%xmm0, %xmm1, %xmm0	# stmp_C_ij_40.240, stmp_C_ij_40.240, C_ij
# main.c:111:             C[i][j] = C_ij;
	vmovsd	%xmm0, (%rcx,%rax)	# C_ij, MEM[(double *)_4 + ivtmp.251_21 * 1]
# main.c:105:         for (int j=sj; j<sj+BLOCK_SIZE; j++){
	addq	$8, %rax	#, ivtmp.251
	cmpq	%rax, 112(%rsp)	# ivtmp.251, %sfp
	jne	.L124	#,
# main.c:104:     for (int i=si; i<si+BLOCK_SIZE; i++){
	addq	$8, -56(%rsp)	#, %sfp
	movq	-80(%rsp), %rcx	# %sfp, _145
	movq	-56(%rsp), %rax	# %sfp, ivtmp.263
	movq	128(%rsp), %rsi	# %sfp, _261
	cmpq	%rcx, %rax	# _145, ivtmp.263
	jne	.L123	#,
	vzeroupper
# main.c:114: }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6648:
	.size	do_block, .-do_block
	.p2align 4
	.globl	blocked_matrix_multiply
	.type	blocked_matrix_multiply, @function
blocked_matrix_multiply:
.LFB6649:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsi, %r11	# tmp455, B
	movl	%ecx, %esi	# tmp457, L
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	pushq	%r13	#
	pushq	%r12	#
	pushq	%rbx	#
	andq	$-32, %rsp	#,
	subq	$200, %rsp	#,
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
# main.c:121: void blocked_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
	movq	%rdi, -32(%rsp)	# tmp454, %sfp
	movq	%rdx, -40(%rsp)	# tmp456, %sfp
# main.c:123:     for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
	testl	%ecx, %ecx	# L
	jle	.L143	#,
	testl	%r9d, %r9d	# N
	jle	.L143	#,
	movl	%r8d, %eax	# tmp458, M
	testl	%r8d, %r8d	# M
	jle	.L143	#,
	subl	$1, %eax	#, tmp333
	xorl	%ebx, %ebx	# ivtmp.323
# main.c:123:     for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
	xorl	%edx, %edx	# sj
	shrl	$5, %eax	#, tmp334
	addl	$1, %eax	#,
	salq	$8, %rax	#, tmp336
	movq	%rax, 16(%rsp)	# tmp336, %sfp
.L132:
	movl	%edx, -60(%rsp)	# sj, %sfp
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	movl	$256, %r12d	#, ivtmp.317
# main.c:125:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	xorl	%r10d, %r10d	# si
	movq	%rbx, %rcx	# ivtmp.323, ivtmp.323
	leaq	256(%rbx), %rax	#, _131
	movq	%r12, %rdi	# ivtmp.317, ivtmp.317
	movq	%rax, -56(%rsp)	# _131, %sfp
.L139:
	leaq	-256(%rdi), %rax	#, ivtmp.304
	movl	%esi, -64(%rsp)	# L, %sfp
	movq	%r11, %rdx	# B, ivtmp.312
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	xorl	%ebx, %ebx	# ivtmp.311
	movq	%rax, -48(%rsp)	# ivtmp.304, %sfp
	movl	%r10d, %r13d	# si, si
	movq	%r11, -72(%rsp)	# B, %sfp
	movl	%r9d, -76(%rsp)	# N, %sfp
.L138:
	movq	24(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_262], 64, 192>, _100
	movq	-48(%rsp), %r12	# %sfp, ivtmp.304
	movq	16(%rdx), %r15	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_262], 64, 128>, _42
	movq	%rax, 136(%rsp)	# _100, %sfp
	movq	8(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_262], 64, 64>, _36
	movq	%rax, 176(%rsp)	# _36, %sfp
	movq	(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_262], 64, 0>, _32
	movq	%rax, 184(%rsp)	# _32, %sfp
	movq	56(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_263], 64, 192>, _44
	movq	%rax, 168(%rsp)	# _44, %sfp
	movq	48(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_263], 64, 128>, _50
	movq	%rax, 160(%rsp)	# _50, %sfp
	movq	40(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_263], 64, 64>, _55
	movq	%rax, 152(%rsp)	# _55, %sfp
	movq	32(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_263], 64, 0>, _60
	movq	%rax, 144(%rsp)	# _60, %sfp
	movq	88(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_264], 64, 192>, _174
	movq	%rax, 88(%rsp)	# _174, %sfp
	movq	80(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_264], 64, 128>, _170
	movq	%rax, 96(%rsp)	# _170, %sfp
	movq	72(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_264], 64, 64>, _166
	movq	%rax, 104(%rsp)	# _166, %sfp
	movq	64(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_264], 64, 0>, _162
	movq	%rax, 112(%rsp)	# _162, %sfp
	movq	120(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_295], 64, 192>, _209
	movq	%rax, 56(%rsp)	# _209, %sfp
	movq	112(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_295], 64, 128>, _205
	movq	%rax, 64(%rsp)	# _205, %sfp
	movq	104(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_295], 64, 64>, _201
	movq	%rax, 72(%rsp)	# _201, %sfp
	movq	96(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_295], 64, 0>, _197
	movq	%rax, 80(%rsp)	# _197, %sfp
	movq	152(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_228], 64, 192>, _244
	movq	%rdx, -88(%rsp)	# ivtmp.312, %sfp
	movq	160(%rdx), %r11	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_136], 64, 0>, _267
	movq	%rax, 24(%rsp)	# _244, %sfp
	movq	144(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_228], 64, 128>, _240
	movq	208(%rdx), %r10	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_143], 64, 128>, _310
	movq	192(%rdx), %r9	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_143], 64, 0>, _302
	movq	%rax, 32(%rsp)	# _240, %sfp
	movq	136(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_228], 64, 64>, _236
	movq	240(%rdx), %rsi	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_137], 64, 128>, _120
	movq	%rax, 40(%rsp)	# _236, %sfp
	movq	128(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_228], 64, 0>, _232
	movq	%rax, 48(%rsp)	# _232, %sfp
	movq	184(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_136], 64, 192>, _279
	movq	%rax, -8(%rsp)	# _279, %sfp
	movq	176(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_136], 64, 128>, _275
	movq	%rax, (%rsp)	# _275, %sfp
	movq	168(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_136], 64, 64>, _271
	movq	%rax, 8(%rsp)	# _271, %sfp
	movq	216(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_143], 64, 192>, _314
	movq	%rax, -24(%rsp)	# _314, %sfp
	movq	200(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_143], 64, 64>, _306
	movq	%rax, -16(%rsp)	# _306, %sfp
	movq	248(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_137], 64, 192>, _116
	movq	%rax, 128(%rsp)	# _116, %sfp
	movq	232(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_137], 64, 64>, _124
	movq	%rax, 120(%rsp)	# _124, %sfp
	movq	224(%rdx), %rax	# BIT_FIELD_REF <MEM <vector(4) long unsigned int> [(double * *)_137], 64, 0>, _128
.L136:
# main.c:106: 	    double C_ij = C[i][j];
	movq	-40(%rsp), %rdx	# %sfp, C
	movq	%rbx, -96(%rsp)	# ivtmp.311, %sfp
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	movq	%rcx, %r8	# ivtmp.323, ivtmp.292
# main.c:106: 	    double C_ij = C[i][j];
	movq	(%rdx,%r12), %rdx	# MEM[(double * *)C_15(D) + ivtmp.304_80 * 1], _22
	movq	%rdx, 192(%rsp)	# _22, %sfp
	movq	-32(%rsp), %rdx	# %sfp, A
	movq	(%rdx,%r12), %r14	# MEM[(double * *)A_13(D) + ivtmp.304_80 * 1], vectp.274
	movq	192(%rsp), %rdx	# %sfp, _22
	movq	%r12, 192(%rsp)	# ivtmp.304, %sfp
	movq	-96(%rsp), %r12	# %sfp, ivtmp.311
	addq	%rbx, %r14	# ivtmp.311, vectp.274
	movq	%rdi, %rbx	# ivtmp.317, ivtmp.317
	movq	%rcx, %rdi	# ivtmp.323, ivtmp.323
	movl	%r13d, %ecx	# si, si
	movq	%rbx, %r13	# ivtmp.317, ivtmp.317
	.p2align 4,,10
	.p2align 3
.L133:
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r15,%r8), %xmm1	# MEM[(double *)_133], MEM[(double *)_133]
	movq	136(%rsp), %rbx	# %sfp, _100
	vmovsd	(%rdx,%r8), %xmm2	# MEM[(double *)_22 + ivtmp.292_83 * 1], stmp_C_ij_41.281
	vmovhpd	(%r8,%rbx), %xmm1, %xmm1	# MEM[(double *)_98], MEM[(double *)_133], tmp338
	movq	184(%rsp), %rbx	# %sfp, _32
	vmovsd	(%rbx,%r8), %xmm0	# MEM[(double *)_34], MEM[(double *)_34]
	movq	176(%rsp), %rbx	# %sfp, _36
	vmovhpd	(%rbx,%r8), %xmm0, %xmm0	# MEM[(double *)_38], MEM[(double *)_34], tmp341
	movq	160(%rsp), %rbx	# %sfp, _50
	vinsertf128	$0x1, %xmm1, %ymm0, %ymm0	# tmp338, tmp341, vect__38.279
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	(%r14), %ymm0, %ymm0	# MEM <vector(4) double> [(double *)vectp.274_145], vect__38.279, vect__39.280
	vaddsd	%xmm0, %xmm2, %xmm2	# tmp345, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm0, %xmm0, %xmm1	# tmp345, stmp_C_ij_41.281
	vextractf128	$0x1, %ymm0, %xmm0	# vect__39.280, tmp347
	vaddsd	%xmm2, %xmm1, %xmm1	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm2	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm0, %xmm0, %xmm0	# tmp347, stmp_C_ij_41.281
	vaddsd	%xmm0, %xmm2, %xmm2	# stmp_C_ij_41.281, stmp_C_ij_41.281, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%rbx,%r8), %xmm0	# MEM[(double *)_48], MEM[(double *)_48]
	movq	168(%rsp), %rbx	# %sfp, _44
	vmovhpd	(%rbx,%r8), %xmm0, %xmm0	# MEM[(double *)_40], MEM[(double *)_48], tmp352
	movq	144(%rsp), %rbx	# %sfp, _60
	vmovsd	(%rbx,%r8), %xmm1	# MEM[(double *)_57], MEM[(double *)_57]
	movq	152(%rsp), %rbx	# %sfp, _55
	vmovhpd	(%rbx,%r8), %xmm1, %xmm1	# MEM[(double *)_53], MEM[(double *)_57], tmp355
	movq	96(%rsp), %rbx	# %sfp, _170
	vinsertf128	$0x1, %xmm0, %ymm1, %ymm1	# tmp352, tmp355, vect__38.279
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	32(%r14), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.274_145 + 32B], vect__38.279, vect__39.280
	vaddsd	%xmm2, %xmm1, %xmm2	# C_ij, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm0	# tmp359, stmp_C_ij_41.281
	vextractf128	$0x1, %ymm1, %xmm1	# vect__39.280, tmp361
	vaddsd	%xmm2, %xmm0, %xmm2	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm2, %xmm1, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rbx), %xmm2	# MEM[(double *)_172], MEM[(double *)_172]
	movq	88(%rsp), %rbx	# %sfp, _174
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp361, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovhpd	(%r8,%rbx), %xmm2, %xmm2	# MEM[(double *)_176], MEM[(double *)_172], tmp366
	movq	112(%rsp), %rbx	# %sfp, _162
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rbx), %xmm1	# MEM[(double *)_164], MEM[(double *)_164]
	movq	104(%rsp), %rbx	# %sfp, _166
	vmovhpd	(%r8,%rbx), %xmm1, %xmm1	# MEM[(double *)_168], MEM[(double *)_164], tmp369
	movq	64(%rsp), %rbx	# %sfp, _205
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp366, tmp369, vect__38.279
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	64(%r14), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.274_145 + 64B], vect__38.279, vect__39.280
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, C_ij, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp373, stmp_C_ij_41.281
	vextractf128	$0x1, %ymm1, %xmm1	# vect__39.280, tmp375
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rbx), %xmm2	# MEM[(double *)_207], MEM[(double *)_207]
	movq	56(%rsp), %rbx	# %sfp, _209
	vmovhpd	(%r8,%rbx), %xmm2, %xmm2	# MEM[(double *)_211], MEM[(double *)_207], tmp380
	movq	80(%rsp), %rbx	# %sfp, _197
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp375, stmp_C_ij_41.281
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rbx), %xmm1	# MEM[(double *)_199], MEM[(double *)_199]
	movq	72(%rsp), %rbx	# %sfp, _201
	vmovhpd	(%r8,%rbx), %xmm1, %xmm1	# MEM[(double *)_203], MEM[(double *)_199], tmp383
	movq	32(%rsp), %rbx	# %sfp, _240
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp380, tmp383, vect__38.279
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	96(%r14), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.274_145 + 96B], vect__38.279, vect__39.280
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, C_ij, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp387, stmp_C_ij_41.281
	vextractf128	$0x1, %ymm1, %xmm1	# vect__39.280, tmp389
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rbx), %xmm2	# MEM[(double *)_242], MEM[(double *)_242]
	movq	24(%rsp), %rbx	# %sfp, _244
	vmovhpd	(%r8,%rbx), %xmm2, %xmm2	# MEM[(double *)_246], MEM[(double *)_242], tmp394
	movq	48(%rsp), %rbx	# %sfp, _232
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp389, stmp_C_ij_41.281
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rbx), %xmm1	# MEM[(double *)_234], MEM[(double *)_234]
	movq	40(%rsp), %rbx	# %sfp, _236
	vmovhpd	(%r8,%rbx), %xmm1, %xmm1	# MEM[(double *)_238], MEM[(double *)_234], tmp397
	movq	(%rsp), %rbx	# %sfp, _275
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp394, tmp397, vect__38.279
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	128(%r14), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.274_145 + 128B], vect__38.279, vect__39.280
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, C_ij, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp401, stmp_C_ij_41.281
	vextractf128	$0x1, %ymm1, %xmm1	# vect__39.280, tmp403
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rbx), %xmm2	# MEM[(double *)_277], MEM[(double *)_277]
	movq	-8(%rsp), %rbx	# %sfp, _279
	vmovhpd	(%r8,%rbx), %xmm2, %xmm2	# MEM[(double *)_281], MEM[(double *)_277], tmp408
	movq	8(%rsp), %rbx	# %sfp, _271
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp403, stmp_C_ij_41.281
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%r11), %xmm1	# MEM[(double *)_269], MEM[(double *)_269]
	vmovhpd	(%r8,%rbx), %xmm1, %xmm1	# MEM[(double *)_273], MEM[(double *)_269], tmp411
	movq	-24(%rsp), %rbx	# %sfp, _314
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp408, tmp411, vect__38.279
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	160(%r14), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.274_145 + 160B], vect__38.279, vect__39.280
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, C_ij, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp415, stmp_C_ij_41.281
	vextractf128	$0x1, %ymm1, %xmm1	# vect__39.280, tmp417
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%r10), %xmm2	# MEM[(double *)_312], MEM[(double *)_312]
	vmovhpd	(%r8,%rbx), %xmm2, %xmm2	# MEM[(double *)_316], MEM[(double *)_312], tmp422
	movq	-16(%rsp), %rbx	# %sfp, _306
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp417, stmp_C_ij_41.281
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%r9), %xmm1	# MEM[(double *)_304], MEM[(double *)_304]
	vmovhpd	(%r8,%rbx), %xmm1, %xmm1	# MEM[(double *)_308], MEM[(double *)_304], tmp425
	movq	128(%rsp), %rbx	# %sfp, _116
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp422, tmp425, vect__38.279
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	192(%r14), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.274_145 + 192B], vect__38.279, vect__39.280
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, C_ij, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp429, stmp_C_ij_41.281
	vextractf128	$0x1, %ymm1, %xmm1	# vect__39.280, tmp431
	vaddsd	%xmm2, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rsi), %xmm2	# MEM[(double *)_118], MEM[(double *)_118]
	vmovhpd	(%r8,%rbx), %xmm2, %xmm2	# MEM[(double *)_114], MEM[(double *)_118], tmp436
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm1	# tmp431, stmp_C_ij_41.281
	vaddsd	%xmm1, %xmm0, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, C_ij
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	(%r8,%rax), %xmm1	# MEM[(double *)_126], MEM[(double *)_126]
	movq	120(%rsp), %rbx	# %sfp, _124
	vmovhpd	(%r8,%rbx), %xmm1, %xmm1	# MEM[(double *)_122], MEM[(double *)_126], tmp439
# main.c:105:         for (int j=sj; j<sj+BLOCK_SIZE; j++){
	movq	-56(%rsp), %rbx	# %sfp, _131
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vinsertf128	$0x1, %xmm2, %ymm1, %ymm1	# tmp436, tmp439, vect__38.279
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vmulpd	224(%r14), %ymm1, %ymm1	# MEM <vector(4) double> [(double *)vectp.274_145 + 224B], vect__38.279, vect__39.280
	vaddsd	%xmm0, %xmm1, %xmm0	# C_ij, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm1, %xmm1, %xmm2	# tmp443, stmp_C_ij_41.281
	vaddsd	%xmm0, %xmm2, %xmm2	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
	vextractf128	$0x1, %ymm1, %xmm0	# vect__39.280, tmp445
# main.c:109: 		C_ij += A[i][k] * B[k][j]; 
	vaddsd	%xmm2, %xmm0, %xmm1	# stmp_C_ij_41.281, stmp_C_ij_41.281, stmp_C_ij_41.281
	vunpckhpd	%xmm0, %xmm0, %xmm0	# tmp445, stmp_C_ij_41.281
	vaddsd	%xmm0, %xmm1, %xmm0	# stmp_C_ij_41.281, stmp_C_ij_41.281, C_ij
# main.c:111:             C[i][j] = C_ij;
	vmovsd	%xmm0, (%rdx,%r8)	# C_ij, MEM[(double *)_22 + ivtmp.292_83 * 1]
# main.c:105:         for (int j=sj; j<sj+BLOCK_SIZE; j++){
	addq	$8, %r8	#, ivtmp.292
	cmpq	%rbx, %r8	# _131, ivtmp.292
	jne	.L133	#,
# main.c:104:     for (int i=si; i<si+BLOCK_SIZE; i++){
	movq	%r12, %rbx	# ivtmp.311, ivtmp.311
	movq	192(%rsp), %r12	# %sfp, ivtmp.304
	movq	%r13, %rdx	# ivtmp.317, ivtmp.317
	movl	%ecx, %r13d	# si, si
	movq	%rdi, %rcx	# ivtmp.323, ivtmp.323
	movq	%rdx, %rdi	# ivtmp.317, ivtmp.317
	addq	$8, %r12	#, ivtmp.304
	cmpq	%rdx, %r12	# ivtmp.317, ivtmp.304
	jne	.L136	#,
# main.c:127:             for(int sk=0; sk<M; sk+=BLOCK_SIZE){
	movq	-88(%rsp), %rdx	# %sfp, ivtmp.312
	movq	16(%rsp), %rax	# %sfp, _260
	addq	$256, %rbx	#, ivtmp.311
	addq	$256, %rdx	#, ivtmp.312
	cmpq	%rax, %rbx	# _260, ivtmp.311
	jne	.L138	#,
# main.c:125:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	movl	%r13d, %r10d	# si, si
	movl	-76(%rsp), %r9d	# %sfp, N
	movl	-64(%rsp), %esi	# %sfp, L
# main.c:125:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	leaq	256(%r12), %rdi	#, ivtmp.317
# main.c:125:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	addl	$32, %r10d	#, si
	movq	-72(%rsp), %r11	# %sfp, B
# main.c:125:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	cmpl	%r10d, %r9d	# si, N
	jg	.L139	#,
# main.c:123:     for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
	movl	-60(%rsp), %edx	# %sfp, sj
	addl	$32, %edx	#, sj
# main.c:123:     for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
	cmpl	%edx, %esi	# sj, L
	jle	.L142	#,
	movq	%r8, %rbx	# ivtmp.292, ivtmp.323
	jmp	.L132	#
.L142:
	vzeroupper
.L143:
# main.c:132: }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6649:
	.size	blocked_matrix_multiply, .-blocked_matrix_multiply
	.p2align 4
	.globl	subword_parallelism_matrix_multiply
	.type	subword_parallelism_matrix_multiply, @function
subword_parallelism_matrix_multiply:
.LFB6650:
	.cfi_startproc
	endbr64	
	movq	%rdx, %r11	# tmp134, C
	movslq	%ecx, %rdx	# tmp135,
# main.c:141:     for(int i=0; i<L; i++) {
	testl	%edx, %edx	# L
	jle	.L158	#,
	movl	%r9d, %eax	# tmp137, N
	testl	%r9d, %r9d	# N
	jle	.L158	#,
# main.c:139: void subword_parallelism_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %r9	# A, ivtmp.347
	movq	%rsi, %r10	# tmp133, B
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r13	#
	.cfi_offset 13, -24
	leaq	(%rdi,%rdx,8), %r13	#, _72
	movslq	%r8d, %rdi	# M, M
	pushq	%r12	#
	salq	$3, %rdi	#, _47
	.cfi_offset 12, -32
	movl	%r8d, %r12d	# tmp136, M
	pushq	%rbx	#
	.cfi_offset 3, -40
	leal	-1(%rax), %ebx	#, tmp118
	shrl	$2, %ebx	#, tmp119
	addl	$1, %ebx	#,
	salq	$5, %rbx	#, _22
	.p2align 4,,10
	.p2align 3
.L148:
# main.c:139: void subword_parallelism_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
	xorl	%ecx, %ecx	# ivtmp.341
	.p2align 4,,10
	.p2align 3
.L151:
# main.c:145:             __m256d c0 = _mm256_load_pd(&C[i][j]);
	movq	(%r11), %r8	# MEM[(double * *)_74], MEM[(double * *)_74]
	leaq	(%r8,%rcx), %rax	#, _67
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	vmovapd	(%rax), %ymm1	# MEM[(__m256d * {ref-all})_7], c0
# main.c:147:             for(int k=0; k<M; k++){
	testl	%r12d, %r12d	# M
	jle	.L149	#,
	movq	(%r9), %rsi	# MEM[(double * *)_75], MEM[(double * *)_75]
	xorl	%eax, %eax	# ivtmp.334
	.p2align 4,,10
	.p2align 3
.L150:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%r10,%rax), %rdx	# MEM[(double * *)B_35(D) + ivtmp.334_62 * 1], MEM[(double * *)B_35(D) + ivtmp.334_62 * 1]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%rsi,%rax), %ymm0	#* ivtmp.334, tmp124
# main.c:147:             for(int k=0; k<M; k++){
	addq	$8, %rax	#, ivtmp.334
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%rdx,%rcx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp124, tmp128
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp128, c0, c0
# main.c:147:             for(int k=0; k<M; k++){
	cmpq	%rax, %rdi	# ivtmp.334, _47
	jne	.L150	#,
# main.c:154: 	    _mm256_store_pd(&C[i][j], c0);
	leaq	(%r8,%rcx), %rax	#, _67
.L149:
# main.c:143:         for(int j=0; j<N; j+=MM256_STRIDE) {
	addq	$32, %rcx	#, ivtmp.341
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:875:   *(__m256d *)__P = __A;
	vmovapd	%ymm1, (%rax)	# c0, MEM[(__m256d * {ref-all})prephitmp_68]
# main.c:143:         for(int j=0; j<N; j+=MM256_STRIDE) {
	cmpq	%rcx, %rbx	# ivtmp.341, _22
	jne	.L151	#,
# main.c:141:     for(int i=0; i<L; i++) {
	addq	$8, %r9	#, ivtmp.347
	addq	$8, %r11	#, ivtmp.346
	cmpq	%r13, %r9	# _72, ivtmp.347
	jne	.L148	#,
	vzeroupper
# main.c:157: }
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
.L158:
	.cfi_restore 3
	.cfi_restore 6
	.cfi_restore 12
	.cfi_restore 13
	ret	
	.cfi_endproc
.LFE6650:
	.size	subword_parallelism_matrix_multiply, .-subword_parallelism_matrix_multiply
	.p2align 4
	.globl	do_block_combination
	.type	do_block_combination, @function
do_block_combination:
.LFB6651:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movl	%esi, %eax	# tmp133, sj
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r15	#
	pushq	%r14	#
	.cfi_offset 15, -24
	.cfi_offset 14, -32
# main.c:166:         for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	leal	31(%rax), %r14d	#, _75
# main.c:164: void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
	pushq	%r13	#
	.cfi_offset 13, -40
	movq	%r9, %r13	# tmp137, C
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leal	31(%rdx), %r9d	#, _76
# main.c:164: void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
	pushq	%r12	#
	pushq	%rbx	#
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movslq	%edi, %rbx	# tmp132,
	movq	%r8, %rdi	# tmp136, B
	leaq	(%rcx,%rbx,8), %r12	#, ivtmp.377
	movslq	%eax, %rcx	# sj, sj
# main.c:165:     for (int i=si; i<si+BLOCK_SIZE; i++){
	leal	31(%rbx), %esi	#, _46
	leaq	0(,%rcx,8), %r11	#, ivtmp.369
	movslq	%edx, %rcx	# sk, ivtmp.358
# main.c:164: void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
	andq	$-32, %rsp	#,
	movl	%esi, -4(%rsp)	# _46, %sfp
	movq	%r11, -16(%rsp)	# ivtmp.369, %sfp
	movl	%eax, -8(%rsp)	# sj, %sfp
	.p2align 4,,10
	.p2align 3
.L162:
# main.c:164: void do_block_combination(int si, int sj, int sk, double **A, double **B, double **C){
	movq	-16(%rsp), %rdx	# %sfp, ivtmp.369
# main.c:166:         for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	movl	-8(%rsp), %esi	# %sfp, j
	.p2align 4,,10
	.p2align 3
.L164:
	movq	(%r12), %r10	# MEM[(double * *)_27], MEM[(double * *)_27]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%rdi,%rcx,8), %r15	# MEM[(double * *)B_38(D) + ivtmp.358_73 * 8], MEM[(double * *)B_38(D) + ivtmp.358_73 * 8]
	movl	%r9d, %r11d	# _76, tmp129
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leaq	1(%rcx), %rax	#, ivtmp.358
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	0(%r13,%rbx,8), %r8	# MEM[(double * *)C_33(D) + ivtmp.373_63 * 8], MEM[(double * *)C_33(D) + ivtmp.373_63 * 8]
	subl	%ecx, %r11d	# ivtmp.358, tmp129
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r10,%rcx,8), %ymm0	#* MEM[(double * *)_27], tmp119
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r15,%rdx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp119, tmp124
	andl	$3, %r11d	#, tmp130
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	(%r8,%rdx), %ymm0, %ymm1	# MEM[(__m256d * {ref-all})_7], tmp124, c0
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	cmpl	%eax, %r9d	# ivtmp.358, _76
	jl	.L184	#,
	testl	%r11d, %r11d	# tmp130
	je	.L163	#,
	cmpl	$1, %r11d	#, tmp130
	je	.L179	#,
	cmpl	$2, %r11d	#, tmp130
	je	.L180	#,
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%rdi,%rax,8), %r15	# MEM[(double * *)B_38(D) + ivtmp.358_73 * 8], MEM[(double * *)B_38(D) + ivtmp.358_73 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r10,%rax,8), %ymm0	#* MEM[(double * *)_27], tmp119
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leaq	2(%rcx), %rax	#, ivtmp.358
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r15,%rdx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp119, tmp124
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp124, c0, c0
.L180:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%rdi,%rax,8), %r15	# MEM[(double * *)B_38(D) + ivtmp.358_73 * 8], MEM[(double * *)B_38(D) + ivtmp.358_73 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r10,%rax,8), %ymm0	#* MEM[(double * *)_27], tmp119
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	addq	$1, %rax	#, ivtmp.358
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r15,%rdx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp119, tmp124
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp124, c0, c0
.L179:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%rdi,%rax,8), %r15	# MEM[(double * *)B_38(D) + ivtmp.358_73 * 8], MEM[(double * *)B_38(D) + ivtmp.358_73 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r10,%rax,8), %ymm0	#* MEM[(double * *)_27], tmp119
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	addq	$1, %rax	#, ivtmp.358
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r15,%rdx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp119, tmp124
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp124, c0, c0
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	cmpl	%eax, %r9d	# ivtmp.358, _76
	jl	.L184	#,
.L163:
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%rdi,%rax,8), %r11	# MEM[(double * *)B_38(D) + ivtmp.358_73 * 8], MEM[(double * *)B_38(D) + ivtmp.358_73 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r10,%rax,8), %ymm0	#* MEM[(double * *)_27], tmp119
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leaq	1(%rax), %r15	#, tmp131
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r11,%rdx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp119, tmp124
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%rdi,%r15,8), %r11	# MEM[(double * *)B_38(D) + ivtmp.358_73 * 8], MEM[(double * *)B_38(D) + ivtmp.358_73 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp124, c0, c0
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	8(%r10,%rax,8), %ymm0	#, tmp119
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	addq	$2, %rax	#, ivtmp.358
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r11,%rdx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp119, tmp124
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	(%rdi,%rax,8), %r11	# MEM[(double * *)B_38(D) + ivtmp.358_73 * 8], MEM[(double * *)B_38(D) + ivtmp.358_73 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp124, c0, c0
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	(%r10,%rax,8), %ymm0	#* MEM[(double * *)_27], tmp119
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r11,%rdx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp119, tmp124
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	leaq	3(%r15), %rax	#, ivtmp.358
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	16(%rdi,%r15,8), %r11	# MEM[(double * *)B_38(D) + ivtmp.358_73 * 8], MEM[(double * *)B_38(D) + ivtmp.358_73 * 8]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp124, c0, c0
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	vbroadcastsd	16(%r10,%r15,8), %ymm0	#, tmp119
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmulpd	(%r11,%rdx), %ymm0, %ymm0	# MEM[(__m256d * {ref-all})_15], tmp119, tmp124
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vaddpd	%ymm0, %ymm1, %ymm1	# tmp124, c0, c0
# main.c:170:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	cmpl	%eax, %r9d	# ivtmp.358, _76
	jge	.L163	#,
.L184:
# main.c:166:         for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	addl	$4, %esi	#, j
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:875:   *(__m256d *)__P = __A;
	vmovapd	%ymm1, (%r8,%rdx)	# c0, MEM[(__m256d * {ref-all})_19]
# main.c:166:         for (int j=sj; j<sj+BLOCK_SIZE; j+=MM256_STRIDE){
	addq	$32, %rdx	#, ivtmp.369
	cmpl	%r14d, %esi	# _75, j
	jle	.L164	#,
# main.c:165:     for (int i=si; i<si+BLOCK_SIZE; i++){
	addq	$1, %rbx	#, ivtmp.373
	addq	$8, %r12	#, ivtmp.377
	cmpl	%ebx, -4(%rsp)	# ivtmp.373, %sfp
	jge	.L162	#,
	vzeroupper
# main.c:176: }
	leaq	-40(%rbp), %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%r13	#
	popq	%r14	#
	popq	%r15	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE6651:
	.size	do_block_combination, .-do_block_combination
	.p2align 4
	.globl	matrix_multiply_combination
	.type	matrix_multiply_combination, @function
matrix_multiply_combination:
.LFB6652:
	.cfi_startproc
	endbr64	
	subq	$56, %rsp	#,
	.cfi_def_cfa_offset 64
# main.c:183: void matrix_multiply_combination(double **A, double **B, double **C, int L, int M, int N) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp98
	movq	%rax, 40(%rsp)	# tmp98, D.41451
	xorl	%eax, %eax	# tmp98
# main.c:185:     #pragma omp parallel for
	movl	%ecx, 24(%rsp)	# tmp95, .omp_data_o.7.L
	xorl	%ecx, %ecx	#
	movq	%rdx, 16(%rsp)	# tmp94, .omp_data_o.7.C
	xorl	%edx, %edx	#
	movq	%rsi, 8(%rsp)	# tmp93, .omp_data_o.7.B
	movq	%rsp, %rsi	#, tmp89
	movq	%rdi, (%rsp)	# tmp92, .omp_data_o.7.A
	leaq	matrix_multiply_combination._omp_fn.0(%rip), %rdi	#, tmp90
	movl	%r9d, 32(%rsp)	# tmp97, .omp_data_o.7.N
	movl	%r8d, 28(%rsp)	# tmp96, .omp_data_o.7.M
	call	GOMP_parallel@PLT	#
# main.c:196: }
	movq	40(%rsp), %rax	# D.41451, tmp99
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp99
	jne	.L193	#,
	addq	$56, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret	
.L193:
	.cfi_restore_state
	call	__stack_chk_fail@PLT	#
	.cfi_endproc
.LFE6652:
	.size	matrix_multiply_combination, .-matrix_multiply_combination
	.p2align 4
	.globl	free_matrices
	.type	free_matrices, @function
free_matrices:
.LFB6653:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13	# tmp110, A
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12	# tmp111, B
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movslq	%r8d, %rbp	# tmp114,
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp	#,
	.cfi_def_cfa_offset 80
# main.c:204: void free_matrices(double **A, double **B, double **C, int L, int M, int N) {
	movq	%rdx, 8(%rsp)	# C, %sfp
# main.c:205:     for(int i=0; i<L; i++) {
	testl	%ecx, %ecx	# L
	jle	.L195	#,
	movslq	%ecx, %rcx	# L, L
	movq	%rdi, %r14	# A, ivtmp.396
	movq	%rdx, %rbx	# C, ivtmp.397
	leaq	(%rdi,%rcx,8), %r15	#, _52
	.p2align 4,,10
	.p2align 3
.L196:
# main.c:206:         free(A[i]);
	movq	(%r14), %rdi	# MEM[(double * *)_47], MEM[(double * *)_47]
# main.c:205:     for(int i=0; i<L; i++) {
	addq	$8, %r14	#, ivtmp.396
	addq	$8, %rbx	#, ivtmp.397
# main.c:206:         free(A[i]);
	call	free@PLT	#
# main.c:207:         free(C[i]);
	movq	-8(%rbx), %rdi	# MEM[(double * *)_48], MEM[(double * *)_48]
	call	free@PLT	#
# main.c:205:     for(int i=0; i<L; i++) {
	cmpq	%r15, %r14	# _52, ivtmp.396
	jne	.L196	#,
.L195:
# main.c:209:     for(int i=0; i<M; i++) {
	testl	%ebp, %ebp	# M
	jle	.L197	#,
	movq	%r12, %rbx	# B, ivtmp.391
	leaq	(%r12,%rbp,8), %rbp	#, _29
	.p2align 4,,10
	.p2align 3
.L198:
# main.c:210:         free(B[i]);
	movq	(%rbx), %rdi	# MEM[(double * *)_39], MEM[(double * *)_39]
# main.c:209:     for(int i=0; i<M; i++) {
	addq	$8, %rbx	#, ivtmp.391
# main.c:210:         free(B[i]);
	call	free@PLT	#
# main.c:209:     for(int i=0; i<M; i++) {
	cmpq	%rbx, %rbp	# ivtmp.391, _29
	jne	.L198	#,
.L197:
# main.c:212:     free(A);
	movq	%r13, %rdi	# A,
	call	free@PLT	#
# main.c:213:     free(B);
	movq	%r12, %rdi	# B,
	call	free@PLT	#
# main.c:214:     free(C);
	movq	8(%rsp), %rdi	# %sfp,
# main.c:215: }
	addq	$24, %rsp	#,
	.cfi_def_cfa_offset 56
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
# main.c:214:     free(C);
	jmp	free@PLT	#
	.cfi_endproc
.LFE6653:
	.size	free_matrices, .-free_matrices
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"ERROR: incorrect number of arguments"
	.section	.rodata.str1.1
.LC4:
	.string	"ERROR: invalid arguments"
	.section	.rodata.str1.8
	.align 8
.LC5:
	.string	"ERROR: cannot allocate memory for matrix A"
	.align 8
.LC6:
	.string	"ERROR: cannot allocate memory for matrix B"
	.align 8
.LC8:
	.string	"ERROR: cannot allocate memory for matrix C"
	.align 8
.LC9:
	.string	"L = %u, M = %u, N = %u, EXEC TIME: %ld.%06ld\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB6654:
	.cfi_startproc
	endbr64	
	pushq	%r15	#
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14	#
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13	#
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12	#
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp	#
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx	#
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rsi, %rbx	# tmp263, argv
	subq	$152, %rsp	#,
	.cfi_def_cfa_offset 208
# main.c:217: int main(int argc, char **argv) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp281
	movq	%rax, 136(%rsp)	# tmp281, D.41527
	xorl	%eax, %eax	# tmp281
# main.c:226:     if(argc != 5) {
	cmpl	$5, %edi	#, tmp262
	jne	.L276	#,
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movq	8(%rsi), %rdi	# MEM[(char * *)argv_77(D) + 8B], MEM[(char * *)argv_77(D) + 8B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	call	strtol@PLT	#
	movq	16(%rbx), %rdi	# MEM[(char * *)argv_77(D) + 16B], MEM[(char * *)argv_77(D) + 16B]
	xorl	%esi, %esi	#
	movl	$10, %edx	#,
	movq	%rax, %r12	# tmp264, _115
	movq	%rax, 8(%rsp)	# _115, %sfp
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, 52(%rsp)	# tmp322, %sfp
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	call	strtol@PLT	#
	movq	24(%rbx), %rdi	# MEM[(char * *)argv_77(D) + 24B], MEM[(char * *)argv_77(D) + 24B]
	xorl	%esi, %esi	#
	movl	$10, %edx	#,
	movq	%rax, %r15	# tmp265, _113
	movq	%rax, 24(%rsp)	# _113, %sfp
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, 72(%rsp)	# tmp323, %sfp
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	call	strtol@PLT	#
	movq	32(%rbx), %rdi	# MEM[(char * *)argv_77(D) + 32B], MEM[(char * *)argv_77(D) + 32B]
	movl	$10, %edx	#,
	xorl	%esi, %esi	#
	movq	%rax, 16(%rsp)	# _111, %sfp
	movq	%rax, %r14	# tmp266, _111
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	movl	%eax, %ebp	# _111, _112
# /usr/include/stdlib.h:483:   return (int) strtol (__nptr, (char **) NULL, 10);
	call	strtol@PLT	#
# main.c:235:     srand(seed);
	movl	%eax, %edi	# tmp267, _110
	call	srand@PLT	#
# main.c:237:     if( !L || !M || !N ) {
	testl	%r12d, %r12d	# _115
	sete	%al	#, tmp191
# main.c:237:     if( !L || !M || !N ) {
	testl	%r15d, %r15d	# _113
	sete	%dl	#, tmp193
# main.c:237:     if( !L || !M || !N ) {
	orb	%dl, %al	# tmp193, tmp282
	jne	.L237	#,
	testl	%r14d, %r14d	# _111
	je	.L237	#,
# main.c:243:     omp_set_num_threads(OMP_THREADS);
	movl	$6, %edi	#,
	call	omp_set_num_threads@PLT	#
# main.c:249:     A = aligned_alloc(MEM_ALIGN, L * sizeof(double *));
	movq	8(%rsp), %rbx	# %sfp, _115
	movl	$32, %edi	#,
	movslq	%ebx, %rax	# _115, _116
	salq	$3, %rax	#, _12
	movq	%rax, %rsi	# _12,
	movq	%rax, 56(%rsp)	# _12, %sfp
	call	aligned_alloc@PLT	#
	movq	%rax, 32(%rsp)	# A, %sfp
# main.c:250:     if(A == NULL) {
	testq	%rax, %rax	# A
	je	.L206	#,
# main.c:263:     B = aligned_alloc(MEM_ALIGN, M * sizeof(double *));
	movslq	24(%rsp), %r12	# %sfp, _114
	salq	$3, %r12	#, _194
# main.c:254:     for(int i=0; i<L; i++) {
	testl	%ebx, %ebx	# _115
	jle	.L212	#,
	movq	%rax, %rcx	# A, A
	movq	%rax, %r13	# A, ivtmp.442
	movq	8(%rsp), %rax	# %sfp, _115
	subl	$1, %eax	#, tmp204
	leaq	8(%rcx,%rax,8), %rbx	#, _229
	.p2align 4,,10
	.p2align 3
.L211:
# main.c:255:         A[i] = aligned_alloc(MEM_ALIGN, M * sizeof(double));
	movq	%r12, %rsi	# _194,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
# main.c:255:         A[i] = aligned_alloc(MEM_ALIGN, M * sizeof(double));
	movq	%rax, 0(%r13)	# tmp207, MEM[(double * *)_222]
# main.c:256:         if(A[i] == NULL) {
	testq	%rax, %rax	# tmp207
	je	.L206	#,
# main.c:254:     for(int i=0; i<L; i++) {
	addq	$8, %r13	#, ivtmp.442
	cmpq	%rbx, %r13	# _229, ivtmp.442
	jne	.L211	#,
.L212:
# main.c:263:     B = aligned_alloc(MEM_ALIGN, M * sizeof(double *));
	movq	%r12, %rsi	# _194,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
	movq	%rax, 40(%rsp)	# B, %sfp
# main.c:264:     if(B == NULL) {
	testq	%rax, %rax	# B
	je	.L208	#,
# main.c:268:     for(int i=0; i<M; i++) {
	movl	24(%rsp), %edi	# %sfp,
	testl	%edi, %edi	#
	jle	.L277	#,
# main.c:269:         B[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movslq	16(%rsp), %rax	# %sfp, _112
	movl	24(%rsp), %ecx	# %sfp, tmp331
	movq	%rax, 64(%rsp)	# _112, %sfp
	leal	-1(%rcx), %r12d	#,
	leaq	0(,%rax,8), %r13	#, _22
	movq	40(%rsp), %rax	# %sfp, B
	movq	%r12, %r15	#,
	addq	$1, %r12	#, tmp258
	movq	%rax, %r14	# B, ivtmp.437
	leaq	(%rax,%r12,8), %rbx	#, _218
	.p2align 4,,10
	.p2align 3
.L215:
	movq	%r13, %rsi	# _22,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
# main.c:269:         B[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movq	%rax, (%r14)	# tmp213, MEM[(double * *)_211]
# main.c:270:         if(B[i] == NULL) {
	testq	%rax, %rax	# tmp213
	je	.L208	#,
# main.c:268:     for(int i=0; i<M; i++) {
	addq	$8, %r14	#, ivtmp.437
	cmpq	%rbx, %r14	# _218, ivtmp.437
	jne	.L215	#,
# main.c:276:     for(int i=0; i<L; i++)
	movl	8(%rsp), %esi	# %sfp,
	testl	%esi, %esi	#
	jle	.L221	#,
# main.c:276:     for(int i=0; i<L; i++)
	xorl	%r14d, %r14d	# i
	movl	%ebp, 76(%rsp)	# _112, %sfp
	movq	32(%rsp), %rbx	# %sfp, ivtmp.433
	salq	$3, %r12	#, _19
	vmovsd	.LC2(%rip), %xmm7	#, tmp260
	movl	%r14d, %eax	# i, i
	movl	52(%rsp), %r14d	# %sfp, _116
	vmovsd	%xmm7, (%rsp)	# tmp260, %sfp
	.p2align 4,,10
	.p2align 3
.L219:
	movl	%eax, 48(%rsp)	# i, %sfp
# main.c:217: int main(int argc, char **argv) {
	xorl	%r13d, %r13d	# ivtmp.428
	.p2align 4,,10
	.p2align 3
.L222:
# main.c:278:             A[i][j] = drand(MIN, MAX);
	movq	(%rbx), %rbp	# MEM[(double * *)_207], _33
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	call	rand@PLT	#
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	vxorpd	%xmm1, %xmm1, %xmm1	# tmp335
# main.c:34:     random_double = (random_double * (max - min)) + min;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp337
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	vcvtsi2sdl	%eax, %xmm1, %xmm0	# tmp272, tmp335, tmp279
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	vdivsd	(%rsp), %xmm0, %xmm0	# %sfp, tmp216, random_double
# main.c:34:     random_double = (random_double * (max - min)) + min;
	vaddsd	%xmm3, %xmm0, %xmm0	# tmp337, random_double, random_double
# main.c:278:             A[i][j] = drand(MIN, MAX);
	addq	%r13, %rbp	# ivtmp.428, _33
# main.c:277:         for(int j=0; j<M; j++)
	addq	$8, %r13	#, ivtmp.428
# main.c:278:             A[i][j] = drand(MIN, MAX);
	vmovsd	%xmm0, 0(%rbp)	# random_double, *_33
# main.c:277:         for(int j=0; j<M; j++)
	cmpq	%r13, %r12	# ivtmp.428, _19
	jne	.L222	#,
# main.c:276:     for(int i=0; i<L; i++)
	movl	48(%rsp), %eax	# %sfp, i
# main.c:276:     for(int i=0; i<L; i++)
	addq	$8, %rbx	#, ivtmp.433
# main.c:276:     for(int i=0; i<L; i++)
	addl	$1, %eax	#, i
# main.c:276:     for(int i=0; i<L; i++)
	cmpl	%r14d, %eax	# _116, i
	jl	.L219	#,
	movl	76(%rsp), %ebp	# %sfp, _112
.L221:
	movq	16(%rsp), %rcx	# %sfp, _111
	testl	%ecx, %ecx	# _111
	jle	.L223	#,
	movq	40(%rsp), %rax	# %sfp, B
	vmovsd	.LC2(%rip), %xmm7	#, tmp260
	movq	%rax, %r14	# B, ivtmp.424
	leaq	8(%rax,%r15,8), %r12	#, _133
	leal	-1(%rcx), %eax	#, tmp225
	vmovsd	%xmm7, (%rsp)	# tmp260, %sfp
	leaq	8(,%rax,8), %rbx	#, _48
	.p2align 4,,10
	.p2align 3
.L224:
# main.c:276:     for(int i=0; i<L; i++)
	xorl	%r13d, %r13d	# ivtmp.419
	.p2align 4,,10
	.p2align 3
.L225:
# main.c:282:             B[i][j] = drand(MIN, MAX);
	movq	(%r14), %r15	# MEM[(double * *)_137], _40
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	call	rand@PLT	#
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	vxorpd	%xmm4, %xmm4, %xmm4	# tmp342
# main.c:34:     random_double = (random_double * (max - min)) + min;
	vxorpd	%xmm6, %xmm6, %xmm6	# tmp344
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	vcvtsi2sdl	%eax, %xmm4, %xmm0	# tmp273, tmp342, tmp280
# main.c:33:     double random_double = (double) rand() / RAND_MAX; 
	vdivsd	(%rsp), %xmm0, %xmm0	# %sfp, tmp228, random_double
# main.c:34:     random_double = (random_double * (max - min)) + min;
	vaddsd	%xmm6, %xmm0, %xmm0	# tmp344, random_double, random_double
# main.c:282:             B[i][j] = drand(MIN, MAX);
	addq	%r13, %r15	# ivtmp.419, _40
# main.c:281:         for(int j=0; j<N; j++)
	addq	$8, %r13	#, ivtmp.419
# main.c:282:             B[i][j] = drand(MIN, MAX);
	vmovsd	%xmm0, (%r15)	# random_double, *_40
# main.c:281:         for(int j=0; j<N; j++)
	cmpq	%r13, %rbx	# ivtmp.419, _48
	jne	.L225	#,
# main.c:280:     for(int i=0; i<M; i++)
	addq	$8, %r14	#, ivtmp.424
	cmpq	%r14, %r12	# ivtmp.424, _133
	jne	.L224	#,
.L223:
# main.c:285:     C = aligned_alloc(MEM_ALIGN, L * sizeof(double *));
	movq	56(%rsp), %rsi	# %sfp,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
	movq	%rax, %r15	# tmp274, C
# main.c:286:     if(C == NULL) {
	testq	%rax, %rax	# C
	je	.L230	#,
# main.c:290:     for(int i=0; i<L; i++) {
	movl	8(%rsp), %ecx	# %sfp,
	testl	%ecx, %ecx	#
	jle	.L235	#,
.L228:
	movq	8(%rsp), %rax	# %sfp, _115
# main.c:291:         C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movq	64(%rsp), %r13	# %sfp, _112
	movq	%r15, %rbx	# C, ivtmp.414
	subl	$1, %eax	#, tmp236
	salq	$3, %r13	#, _112
	leaq	8(%r15,%rax,8), %r12	#, _155
# main.c:298:             C[i][j] = 0.0;    
	movq	16(%rsp), %rax	# %sfp, _111
	subl	$1, %eax	#, tmp240
	leaq	8(,%rax,8), %r14	#, _160
	.p2align 4,,10
	.p2align 3
.L232:
# main.c:291:         C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movl	$32, %edi	#,
	movq	%r13, %rsi	# _42,
	call	aligned_alloc@PLT	#
# main.c:291:         C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movq	%rax, (%rbx)	# tmp242, MEM[(double * *)_71]
# main.c:291:         C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movq	%rax, %rdi	# tmp275, tmp242
# main.c:292:         if(C[i] == NULL) {
	testq	%rax, %rax	# tmp242
	je	.L230	#,
# main.c:297:         for(int j=0; j<N; j++){
	testl	%ebp, %ebp	# _112
	jle	.L233	#,
# main.c:298:             C[i][j] = 0.0;    
	movq	%r14, %rdx	# _160,
	xorl	%esi, %esi	#
	call	memset@PLT	#
.L233:
# main.c:290:     for(int i=0; i<L; i++) {
	addq	$8, %rbx	#, ivtmp.414
	cmpq	%r12, %rbx	# _155, ivtmp.414
	jne	.L232	#,
.L235:
# main.c:316:     gettimeofday(&start, NULL);
	leaq	80(%rsp), %rdi	#, tmp247
	xorl	%esi, %esi	#
	leaq	96(%rsp), %rbx	#, tmp248
	call	gettimeofday@PLT	#
# main.c:185:     #pragma omp parallel for
	movl	16(%rsp), %eax	# %sfp, tmp348
	xorl	%ecx, %ecx	#
	xorl	%edx, %edx	#
	movq	%rbx, %rsi	# tmp248,
	leaq	matrix_multiply_combination._omp_fn.0(%rip), %rdi	#, tmp249
	movq	%r15, 112(%rsp)	# C, MEM[(struct .omp_data_s.5 *)_152].C
	movl	%eax, 128(%rsp)	# tmp348, MEM[(struct .omp_data_s.5 *)_152].N
	movl	24(%rsp), %eax	# %sfp, tmp349
	movl	%eax, 124(%rsp)	# tmp349, MEM[(struct .omp_data_s.5 *)_152].M
	movl	8(%rsp), %eax	# %sfp, tmp350
	movl	%eax, 120(%rsp)	# tmp350, MEM[(struct .omp_data_s.5 *)_152].L
	movq	40(%rsp), %rax	# %sfp, B
	movq	%rax, 104(%rsp)	# B, MEM[(struct .omp_data_s.5 *)_152].B
	movq	32(%rsp), %rax	# %sfp, A
	movq	%rax, 96(%rsp)	# A, MEM[(struct .omp_data_s.5 *)_152].A
	call	GOMP_parallel@PLT	#
# main.c:326:     gettimeofday(&stop, NULL);
	xorl	%esi, %esi	#
	movq	%rbx, %rdi	# tmp248,
	call	gettimeofday@PLT	#
# main.c:327:     timersub(&stop, &start, &total);
	movq	96(%rsp), %r9	# MEM[(struct timeval *)_152].tv_sec, MEM[(struct timeval *)_152].tv_sec
	movq	104(%rsp), %rax	# MEM[(struct timeval *)_152].tv_usec, MEM[(struct timeval *)_152].tv_usec
	subq	80(%rsp), %r9	# start.tv_sec, total$tv_sec
	subq	88(%rsp), %rax	# start.tv_usec, total$tv_usec
	jns	.L234	#,
# main.c:327:     timersub(&stop, &start, &total);
	subq	$1, %r9	#, total$tv_sec
	addq	$1000000, %rax	#, total$tv_usec
.L234:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	subq	$8, %rsp	#,
	.cfi_def_cfa_offset 216
	leaq	.LC9(%rip), %rsi	#, tmp253
	movl	$2, %edi	#,
	pushq	%rax	# total$tv_usec
	.cfi_def_cfa_offset 224
	movq	32(%rsp), %r14	# %sfp, _111
	xorl	%eax, %eax	#
	movl	68(%rsp), %ebx	# %sfp, _116
	movl	88(%rsp), %ecx	# %sfp,
	movl	%r14d, %r8d	# _111,
	movl	%ebx, %edx	# _116,
	call	__printf_chk@PLT	#
# main.c:354:     free_matrices(A, B, C, L, M, N);
	movl	40(%rsp), %r8d	# %sfp,
	movq	%r15, %rdx	# C,
	movl	%r14d, %r9d	# _111,
	movq	56(%rsp), %rsi	# %sfp,
	movq	48(%rsp), %rdi	# %sfp,
	movl	%ebx, %ecx	# _116,
	call	free_matrices	#
# main.c:356:     return 0;
	popq	%rax	#
	.cfi_def_cfa_offset 216
	popq	%rdx	#
	.cfi_def_cfa_offset 208
.L210:
# main.c:357: }
	movq	136(%rsp), %rax	# D.41527, tmp283
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp283
	jne	.L278	#,
	addq	$152, %rsp	#,
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax	#
	popq	%rbx	#
	.cfi_def_cfa_offset 48
	popq	%rbp	#
	.cfi_def_cfa_offset 40
	popq	%r12	#
	.cfi_def_cfa_offset 32
	popq	%r13	#
	.cfi_def_cfa_offset 24
	popq	%r14	#
	.cfi_def_cfa_offset 16
	popq	%r15	#
	.cfi_def_cfa_offset 8
	ret	
.L277:
	.cfi_restore_state
# main.c:276:     for(int i=0; i<L; i++)
	cmpl	$0, 8(%rsp)	#, %sfp
	jle	.L279	#,
# main.c:285:     C = aligned_alloc(MEM_ALIGN, L * sizeof(double *));
	movq	56(%rsp), %rsi	# %sfp,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
	movq	%rax, %r15	# tmp277, C
# main.c:286:     if(C == NULL) {
	testq	%rax, %rax	# C
	je	.L230	#,
	movslq	16(%rsp), %rax	# %sfp, _112
	movq	%rax, 64(%rsp)	# _112, %sfp
	jmp	.L228	#
.L279:
# main.c:285:     C = aligned_alloc(MEM_ALIGN, L * sizeof(double *));
	movq	56(%rsp), %rsi	# %sfp,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
	movq	%rax, %r15	# tmp276, C
# main.c:286:     if(C == NULL) {
	testq	%rax, %rax	# C
	jne	.L235	#,
.L230:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC8(%rip), %rdi	#, tmp233
	call	puts@PLT	#
# main.c:288:         return 0;
	jmp	.L210	#
.L278:
# main.c:357: }
	call	__stack_chk_fail@PLT	#
.L208:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC6(%rip), %rdi	#, tmp208
	call	puts@PLT	#
# main.c:266:         return 0;
	jmp	.L210	#
.L206:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC5(%rip), %rdi	#, tmp202
	call	puts@PLT	#
# main.c:252:         return 0;
	jmp	.L210	#
.L237:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC4(%rip), %rdi	#, tmp197
	call	puts@PLT	#
# main.c:239:         print_help_and_exit(argv);
	movq	%rbx, %rdi	# argv,
	call	print_help_and_exit	#
.L276:
# /usr/include/x86_64-linux-gnu/bits/stdio2.h:86:   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, __va_arg_pack ());
	leaq	.LC3(%rip), %rdi	#, tmp184
	call	puts@PLT	#
# main.c:228:         print_help_and_exit(argv);
	movq	%rbx, %rdi	# argv,
	call	print_help_and_exit	#
	.cfi_endproc
.LFE6654:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	-4194304
	.long	1105199103
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
