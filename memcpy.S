		.global		memcpy
memcpy:
	movq		%rdi,		%rax
	movq		%rsi,		%rcx
	movq		%rdi,		%r8
	andq		$0xf,		%rcx
	andq		$0xf,		%r8
	cmp		%rcx,		%r8
	jne		unalignedLoop

	/*	aligned mov could be used	*/
prealign:
	negq		%rcx
	andq		$0xf,		%rcx
rep	movsb
alignedLoop:
	cmpq		$128,		%rdx
	jna		postalign1

	movaps		(%rsi),		%xmm0
	movaps		16(%rsi),	%xmm1
	movaps		32(%rsi),	%xmm2
	movaps		48(%rsi),	%xmm3
	movaps		64(%rsi),	%xmm4
	movaps		80(%rsi),	%xmm5
	movaps		96(%rsi),	%xmm6
	movaps		112(%rsi),	%xmm7

	movaps		%xmm0,		(%rdi)
	movaps		%xmm1,		16(%rdi)
	movaps		%xmm2,		32(%rdi)
	movaps		%xmm3,		48(%rdi)
	movaps		%xmm4,		64(%rdi)
	movaps		%xmm5,		80(%rdi)
	movaps		%xmm6,		96(%rdi)
	movaps		%xmm7,		112(%rdi)

	addq		$128,		%rdi
	addq		$128,		%rsi
	subq		$128,		%rdx
	jmp		alignedLoop
postalign1:
	movq		%rdx,		%rcx
rep	movsb
	ret

unalignedLoop:
	cmpq		$128,		%rdx
	jna		postalign2

	movups		(%rsi),		%xmm0
	movups		16(%rsi),	%xmm1
	movups		32(%rsi),	%xmm2
	movups		48(%rsi),	%xmm3
	movups		64(%rsi),	%xmm4
	movups		80(%rsi),	%xmm5
	movups		96(%rsi),	%xmm6
	movups		112(%rsi),	%xmm7

	movups		%xmm0,		(%rdi)
	movups		%xmm1,		16(%rdi)
	movups		%xmm2,		32(%rdi)
	movups		%xmm3,		48(%rdi)
	movups		%xmm4,		64(%rdi)
	movups		%xmm5,		80(%rdi)
	movups		%xmm6,		96(%rdi)
	movups		%xmm7,		112(%rdi)

	addq		$128,		%rdi
	addq		$128,		%rsi
	subq		$128,		%rdx
	jmp		unalignedLoop
postalign2:
	movq		%rdx,		%rcx
rep	movsb
	ret
