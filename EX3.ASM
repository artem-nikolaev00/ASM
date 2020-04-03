.model small
.stack 100h
.data
.486
	Rows	equ	3
	Colomns	equ	3
	len	dw	Rows*Colomns
	matrix	dw	0,1,0
		dw	0,0,0	
		dw	1,1,0
	max	dw	0
	min	dw	0
	maxrow	dw	0
	minrow	dw	0
.code
	mov	ax, @data
	mov	ds, ax
	mov	si, 0;	displacement
	mov	cx, len;
@lp1:
	inc	si
	inc 	si
	loop	@lp1
	dec	si
	dec	si

	mov	dx, 0;		zero counter
	mov	cx, Rows; 	counter of rows
@cyclrows:
	mov	bx, cx
	mov	cx, Colomns;	coter of colomns
@cyclcolomns:
	cmp	[matrix+si], 0
	jne	@one
	inc	dx
@one:
	dec	si
	dec	si
	loop	@cyclcolomns
	push	dx
	mov	dx, 0
	mov	cx, bx
	loop	@cyclrows

	xor	ax, ax
	xor	bx, bx
	xor	cx, cx
	xor	dx, dx
	xor	si, si
	
	mov	ax, Rows
	pop	bx
	mov	min, bx
	mov	max, bx
	mov	minrow, ax
	mov	maxrow, ax
	dec	ax

	mov	cx, ax
@m1:
	pop	bx
	cmp	bx, min
	jg @max
	mov	min, bx
	mov	minrow, ax
	jmp @m2
@max:
	cmp	bx, max
	jl @m2
	mov	max, bx
	mov	maxrow, cx
@m2:
	loop	@m1
;displacement 1
	mov	ax, Rows
	mov	bx, minrow
	mul	bx; displacement 1 -> ax;--------------------
	sub	ax, Rows
	mov	di, ax
;displacement 2
	xor	ax, ax
	mov	ax, Rows
	mov	bx, maxrow
	mul	bx; displacement 2-> ax;--------------------
	sub	ax, Rows
	mov	si, ax

	mov	cx, Rows
@m3:
	dec	cx
	mov	ax, [matrix+di]
	mov	bx, [matrix+si]
	mov	[matrix+di], bx
	mov	[matrix+si], ax
	inc	di
	inc	si
	cmp	cx, 0
	jne @m3

;output
	xor	ax, ax
	mov	cx, len
	mov	si, 0
cyclout:
	mov	ax, [matrix + si]
	inc	si
	inc	si
	loop 	cyclout

	mov	ax, 4c00h
	int	21h
end
	


	



	






