	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
	// Para mayor organizacion, usaremos los registros de la siguiente manera: https://docs.google.com/spreadsheets/d/1SuxA6J6tJd5geir0w2ndczHOmU239FzZQ2teHOsjGkk/edit?usp=sharing

	//---------------- CODE HERE ------------------------------------

	mov x22, 100
	mov x23, 200

	bl faro

	mov x22, 324

	bl faro

InfLoop:
	b InfLoop

//Faro (86x60 pixeles) x = x22, y = x23 (Entre faro y faro tiene que haber 224 pixeles)
faro:
	movz x2, 0x27, lsl 16				// Carcasa Gris Oscuro----------------------------
	movk x2, 0x2729, lsl 00				// Color

	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 46
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 46
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 45
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 32
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 28
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 50
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 52
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27						// Carcasa Gris Oscuro ---------------------------

	movz x2, 0xAB, lsl 16				// Carcasa Roja ----------------------------------
	movk x2, 0x3D5B, lsl 00				// Color

	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 2
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	

	add x21, x22, 16
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 36
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	

	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 47
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	

	add x21, x22, 45
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27						// Carcasa Roja ----------------------------------

	movz x2, 0x3B, lsl 16				// Triangulo gris --------------------------------
	movk x2, 0x3D49, lsl 00				// Color

	mov x24, 51

trialoop:
	add x21, x22, 51
	bfi x4, x21, 48, 16					// X0
	add x21, x23, x24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27	

	sub x24, x24, 1
	cmp x24, 7

	b.gt trialoop						// Triangulo gris --------------------------------

	movz x2, 0x0E, lsl 16				// Circulos Negros -------------------------------
	movk x2, 0x0E0F, lsl 00				// Color

	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 35
	bfi x4, x21, 32, 16					// Y0
	movk x4, 1, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27	

	add x21, x22, 55
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	movk x4, 1, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27	

	add x21, x22, 28
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 31
	bfi x4, x21, 32, 16					// Y0
	movk x4, 21, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27						// Circulos Negros -------------------------------

	movz x2, 0xD2, lsl 16				// Optica		   -------------------------------
	movk x2, 0xD2D2, lsl 00				// Color1	

	add x21, x22, 28
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 31
	bfi x4, x21, 32, 16					// Y0
	movk x4, 19, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	movz x2, 0x85, lsl 16				
	movk x2, 0x959D, lsl 00				// Color2	

	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 29
	bfi x4, x21, 32, 16					// Y0
	movk x4, 8, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 33
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 40
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 38
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27


	movz x2, 0xFF, lsl 16				
	movk x2, 0xFFFF, lsl 00				// Color3

	add x21, x22, 28
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 31
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 15
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 27
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 25
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 18
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 30
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 40
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 40
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27


	movz x2, 0x51, lsl 16				
	movk x2, 0x6779, lsl 00				// Color4

	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	movk x4, 3, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27						// Optica		   -------------------------------

	movz x2, 0x96, lsl 16				// Linea Roja --------------------------------
	movk x2, 0x354E, lsl 00				// Color

	add x21, x22, 52
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

	ret

