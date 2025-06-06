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

//--------------------------------------------------- CODE HERE ------------------------------------------------------------------------------


//-----------------------------------------------
	bl cielo
	bl cieloAnimacion
	bl fondo

	mov x6, 50  //x del auto
	mov x26, 90 //y del auto

	bl auto

	b InfLoop
//----------------------------------------------- AUTO --------------------------------------------------------------------------------------
auto:
	mov x3, x30 

	add x22, x6, 239
    add x23, x26, 87
	bl techo
//-----------------------------------------------
	add x22, x6, 433
    add x23, x26, 104
	bl ventana
//-----------------------------------------------
	add x22, x6, 451
    add x23, x26, 109
	bl ventanita
//-----------------------------------------------
	add x22, x6, 490
    add x23, x26, 207
	bl ruedaTraseraIzq
//-----------------------------------------------
	add x22, x6, 524
    add x23, x26, 168
	bl culoDelAuto
//-----------------------------------------------
	add x22, x6, 446
	add x23, x26, 292
	bl guardabarros
//-----------------------------------------------
	add x22, x6, 336
    add x23, x26, 210
	bl ruedaDelanteraIzq
//------------------------------------------------
    add x22, x6, 20
    add x23, x26, 236
	bl ruedaderecha
//-----------------------------------------------
	add x22, x6, 42
	add x23, x26, 315
	bl paraChoques
//-----------------------------------------------
	add x22, x6, 332
	add x23, x26, 177
	bl esquina
//-----------------------------------------------
	add x22, x6, 445
	add x23, x26, 174
	bl puerta
//------------------------------------------------	
	add x22, x6, 25
	add x23, x26, 216
	bl capoFrente
//-----------------------------------------------
	add x22, x6, 25
	add x23, x26, 258
	bl frenteAuto
//-----------------------------------------------
	add x22, x6, 38
	add x23, x26, 168
	bl capo
//----------------------------------------------
	add x22, x6, 335
	add x23, x26, 178
	bl contornoEsquina
//-----------------------------------------------
	add x22, x6, 76
	add x23, x26, 287
	bl parrilla
//-----------------------------------------------
	add x22, x6, 151
	add x23, x26, 148
	bl espejoDerecho 
//-----------------------------------------------
	add x22, x6, 163
	add x23, x26, 96
	bl parabrisas
//-----------------------------------------------
	add x22, x6, 163
	add x23, x26, 90
	bl contornoParabrisas
//-----------------------------------------------
	add x22, x6, 47
	add x23, x26, 159
	bl faro
	bl profundidadFaro
	mov x5, 7
	bl costadoFaro

	add x22, x6, 270
	bl faro
	bl profundidadFaro
	bl costadoFaro
//-----------------------------------------------
	add x22, x6, 245
	add x23, x26, 239
	bl salidaDeAireDer
//-----------------------------------------------
	add x22, x6, 32
	add x23, x26, 235
	bl salidaDeAireIzq
//-----------------------------------------------
	add x22, x6, 483
	add x23, x26, 151
	bl espejito
//-----------------------------------------------
	add x22, x6, 346
	add x23, x26, 271
	bl luz 
//-----------------------------------------------
	add x22, x6, 140
	add x23, x26, 260
	bl patente
//-----------------------------------------------
	mov x22, 490
	mov x23, 30
	bl sol
//-----------------------------------------------
	add x22, x6, -3
	add x23, x26, -17
	bl nubes
	add x22, x6, 208
	add x23, x26, -76
	bl nubes
	add x22, x6, 453
	add x23, x26, -53
	bl nubes
//-----------------------------------------------

	mov x30, x3


	ret

resetNubes:
	mov x6, 50

InfLoop:

	mov x26, 90
	mov x5, 7
	
	
	//----------------------------------------------- Dibujo para resetear faros correctamente
	mov x22, 97
	mov x23, 249
	bl faro
	bl profundidadFaro
	bl costadoFaro

	mov x22, 320
	bl faro
	bl profundidadFaro
	bl costadoFaro
	
	bl animacionNubes

	//------------------------------ Comenzamos animacion
	bl animacionBajarAmbosFaros

	

/*/////////////////////////////////////////////////////////////////// */


animacionBajarAmbosFaros:

	bl animacionNubes

	//------------ FIGURAS ANTERIORES
	mov x22, 88
	mov x23, 258
	bl capo
	//-----------------------------------------------
	bl parchesPre

	// ---------------- CONFIGURACION ANIMACION
	add x26, x26, 4
	add x5, x5, 4

	cmp x5, 51
	b.gt inicializacionSubeFaroIzquierdo

	cmp x26, 150
	b.gt inicializacionSubeFaroIzquierdo
	//------------------------ ANIMACION FARO 
	mov x22, 320
	add x23, x26, 159
	bl faro
	mov x23, 249
	bl costadoFaro

	mov x22, 97
	add x23, x26, 159
	bl faro
	mov x23, 249
	bl costadoFaro

	//---------------------- FIGURAS POSTERIORES

	bl dibujarFigurasParches

	movz x25, 0x500, lsl 16
	bl delay

	b animacionBajarAmbosFaros


inicializacionSubeFaroIzquierdo:
	mov x26, 134
	mov x5, 51

	b subeFaroIzquierdo

subeFaroIzquierdo:

	bl animacionNubes

	//------------ FIGURAS ANTERIORES
	mov x22, 88
	mov x23, 258
	bl capo
	//-----------------------------------------------
	bl parchesPre
	//----------------------------------------------

	// ---------------- CONFIGURACION ANIMACION
	sub x26, x26, 4
	sub x5, x5, 4

	cmp x5, 7
	b.lt inicializacionBajaFaroIzquierdo

	cmp x26, 90
	b.lt inicializacionBajaFaroIzquierdo
	//------------------------ ANIMACION FARO 
	mov x22, 320
	add x23, x26, 159
	bl faro
	mov x23, 249
	bl costadoFaro

	//---------------------- DIBUJO FARO NO ANIMADO
	mov x22, 97
	mov x23, 293
	bl faro
	bl profundidadFaro

	//---------------------- FIGURAS POSTERIORES

	bl dibujarFigurasParches



	movz x25, 0x500, lsl 16
	bl delay

	b subeFaroIzquierdo


inicializacionBajaFaroIzquierdo:
	mov x26, 90
	mov x5, 7

	b bajaFaroIzquierdo

bajaFaroIzquierdo:

	bl animacionNubes

	//------------ FIGURAS ANTERIORES
	mov x22, 88
	mov x23, 258
	bl capo
	//-----------------------------------------------
	bl parchesPre
	//----------------------------------------------

	// ---------------- CONFIGURACION ANIMACION
	add x26, x26, 4
	add x5, x5, 4

	cmp x5, 51
	b.gt inicializacionSubeFaroDerecho

	cmp x26, 150
	b.gt inicializacionSubeFaroDerecho
	//------------------------ ANIMACION FARO 
	mov x22, 320
	add x23, x26, 159
	bl faro
	mov x23, 249
	bl costadoFaro

	//---------------------- DIBUJO FARO NO ANIMADO
	mov x22, 97
	mov x23, 293
	bl faro
	bl profundidadFaro
	//---------------------- FIGURAS POSTERIORES

	bl dibujarFigurasParches



	movz x25, 0x500, lsl 16
	bl delay

	b bajaFaroIzquierdo


inicializacionSubeFaroDerecho:
	mov x26, 134
	mov x5, 51

	b subeFaroDerecho

subeFaroDerecho:

	bl animacionNubes

	//------------ FIGURAS ANTERIORES
	mov x22, 88
	mov x23, 258
	bl capo
	//-----------------------------------------------
	bl parchesPre
	//----------------------------------------------

	// ---------------- CONFIGURACION ANIMACION
	sub x26, x26, 4
	sub x5, x5, 4

	cmp x5, 7
	b.lt inicializacionBajaFaroDerecho

	cmp x26, 90
	b.lt inicializacionBajaFaroDerecho
	//------------------------ ANIMACION FARO 
	mov x22, 97
	add x23, x26, 159
	bl faro
	mov x23, 249
	bl costadoFaro

	//---------------------- DIBUJO FARO NO ANIMADO
	mov x22, 320
	mov x23, 293
	bl faro
	bl profundidadFaro

	//---------------------- FIGURAS POSTERIORES

	bl dibujarFigurasParches


	movz x25, 0x500, lsl 16
	bl delay

	b subeFaroDerecho

inicializacionBajaFaroDerecho:
	mov x26, 90
	mov x5, 7

	b bajaFaroDerecho

bajaFaroDerecho:

	bl animacionNubes

	//------------ FIGURAS ANTERIORES
	mov x22, 88
	mov x23, 258
	bl capo
	//-----------------------------------------------
	bl parchesPre
	//----------------------------------------------

	// ---------------- CONFIGURACION ANIMACION
	add x26, x26, 4
	add x5, x5, 4

	cmp x5, 51
	b.gt inicializacionSubenAmbosFaros

	cmp x26, 150
	b.gt inicializacionSubenAmbosFaros
	//------------------------ ANIMACION FARO 
	mov x22, 97
	add x23, x26, 159
	bl faro
	mov x23, 249
	bl costadoFaro

	//---------------------- DIBUJO FARO NO ANIMADO
	mov x22, 320
	mov x23, 293
	bl faro
	bl profundidadFaro

	//---------------------- FIGURAS POSTERIORES

	bl dibujarFigurasParches


	movz x25, 0x500, lsl 16
	bl delay

	b bajaFaroDerecho

inicializacionSubenAmbosFaros:
	mov x26, 134
	mov x5, 51

	b animacionSubirAmbosFaros

animacionSubirAmbosFaros:

	bl animacionNubes

	//------------ FIGURAS ANTERIORES
	mov x22, 88
	mov x23, 258
	bl capo
	//-----------------------------------------------
	bl parchesPre

	// ---------------- CONFIGURACION ANIMACION
	sub x26, x26, 4
	sub x5, x5, 4

	cmp x5, 7
	b.lt InfLoop

	cmp x26, 90
	b.lt InfLoop
	//------------------------ ANIMACION FARO 
	mov x22, 320
	add x23, x26, 159
	bl faro
	mov x23, 249
	bl costadoFaro

	mov x22, 97
	add x23, x26, 159
	bl faro
	mov x23, 249
	bl costadoFaro

	//---------------------- FIGURAS POSTERIORES

	bl dibujarFigurasParches

	movz x25, 0x500, lsl 16
	bl delay

	b animacionSubirAmbosFaros




animacionNubes:

	mov x3, x30

	add x6, x6, 2

	bl cieloAnimacion

	mov x22, 490
	mov x23, 30
	bl sol

	add x22, x6, -3
	mov x23, 73
	bl nubes

	add x22, x6, 208
	mov x23, 14
	bl nubes

	add x22, x6, 453
	mov x23, 37
	bl nubes

	mov x30, x3

	ret


dibujarFigurasParches:

	mov x3, x30
	
		bl parches
	//-----------------------------------------------
		mov x22, 295
		mov x23, 329
		bl salidaDeAireDer
	//-----------------------------------------------
		mov x22, 82
		mov x23, 325
		bl salidaDeAireDer
	//-----------------------------------------------
		mov x22, 320
		mov x23, 249
		bl profundidadFaro
	//-----------------------------------------------
	
	mov x30, x3
		
	ret




	






































// ------------------------------------------------- CIELO -----------------------------------------------------------------------------------
cielo:
	movz x2, 0x0a, lsl 16
	movk x2, 0x68c2, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 0, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 4, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x15, lsl 16
	movk x2, 0x6fc5, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 4, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 8, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27

//-----------------------------------------------
	movz x2, 0x1d, lsl 16
	movk x2, 0x75ca, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 8, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 12, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x73, lsl 16
	movk x2, 0xbaff, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 171, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 185, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x88, lsl 16
	movk x2, 0xc4ff, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 185, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 199, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0xa8, lsl 16
	movk x2, 0xd6fd, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 199, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 221, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0xc7, lsl 16
	movk x2, 0xe5ff, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 221, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 240, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
	
	ret

// ------------------------------------------------- CIELO ANIMACION -----------------------------------------------------------------------------------
cieloAnimacion:
	//-----------------------------------------------
	movz x2, 0x25, lsl 16
	movk x2, 0x7acd, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 12, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 16, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x2a, lsl 16
	movk x2, 0x7ed0, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 16, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 20, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x31, lsl 16
	movk x2, 0x83d4, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 20, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 26, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x35, lsl 16
	movk x2, 0x87d9, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 26, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 32, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x29, lsl 16
	movk x2, 0x84de, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 32, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 38, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x16, lsl 16
	movk x2, 0x80e8, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 38, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 45, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x1e, lsl 16
	movk x2, 0x85ea, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 45, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 53, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x4, 0, lsl 48
	movk x4, 53, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 61, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x24, lsl 16
	movk x2, 0x89ec, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 61, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 69, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x30, lsl 16
	movk x2, 0x8fec, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 69, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 77, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x35, lsl 16
	movk x2, 0x92ee, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 77, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 85, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x36, lsl 16
	movk x2, 0x92ed, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 85, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 97, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x25, lsl 16
	movk x2, 0x96fc, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 97, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 109, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x2a, lsl 16
	movk x2, 0x9aff, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 109, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 121, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x34, lsl 16
	movk x2, 0x9efd, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 121, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 133, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x41, lsl 16
	movk x2, 0xa5ff, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 133, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 145, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 
	movz x2, 0x4d, lsl 16
	movk x2, 0xabff, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 145, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 157, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 
	movz x2, 0x56, lsl 16
	movk x2, 0xafff, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 157, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, 171, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27

	ret


// ------------------------------------------------- NUBE -----------------------------------------------------------------------------------
nubes:
///////////////////////////////////////// RELLENO 
	movz x2, 0xd1, lsl 16				
	movk x2, 0xd2d4, lsl 00				

	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 158
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 33
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 145
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 33
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 145
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 40
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 132
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 43
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 66
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 119
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 78
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 145
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
///////////////////////////////////////// BRILLO
	movz x2, 0xff, lsl 16				
	movk x2, 0xffff, lsl 00				

	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 107
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 40
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 48
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 43
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 47
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 61
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 37
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 31
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 66
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 74
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 34
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 41
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

///////////////////////////////////////// SOMBRA
	movz x2, 0xa8, lsl 16				
	movk x2, 0xa9ad, lsl 00				

	add x21, x22, 144
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 152
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 150
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 158
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 125
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 146
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 144
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 66
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 151
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 79
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 137
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 72
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 145
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 98
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 138
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
///////////////////////////////////////// CONTORNO
	movz x2, 0x1c, lsl 16				
	movk x2, 0x1e20, lsl 00				

	add x21, x22, 157
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 165
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 150
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 158
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 144
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 152
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 125
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 145
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 43
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 125
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 132
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 37
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 118
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 127
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 112
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 120
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 106
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 113
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 107
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 66
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 74
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 40
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 60
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 31
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 34
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 29
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 41
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 43
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 9
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 78
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 85
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 145
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 91
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 144
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 78
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 152
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 150
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 72
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 158
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27


ret


// ------------------------------------------------- SOL ----------------------------------------------------------------

sol:

	movz x2, 0xf0, lsl 16				
	movk x2, 0xe900, lsl 00				

	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 76
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 64
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 12
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 70
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 8
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 4
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 63
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 70
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 83
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 87
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 63
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 75
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 79
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 83
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 64
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 87
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27



	ret



// ------------------------------------------------- FONDO -----------------------------------------------------------------------------------
fondo:
	movz x2, 0xE2, lsl 16
	movk x2, 0xCA76, lsl 00	

	movz x4, 0, lsl 48
	movk x4, 240, lsl 32
	movk x4, SCREEN_WIDTH, lsl 16
	movk x4, SCREEN_HEIGH, lsl 00

	mov x27, x30
	bl drawsquare
	mov x30, x27

	mov x21, 0

//----------------------------------------------- ARENA ----------------------------------------------------------------
sandloop:

	movz x4, 520, lsl 48
	movk x4, 240, lsl 32

	add x21, x21, 5
	bfi x4, x21, 16, 16	

	movk x4, SCREEN_HEIGH, lsl 00

	mov x27, x30
	bl drawline
	mov x30, x27

	cmp x21, SCREEN_WIDTH
	b.ne sandloop

	ret

// ------------------------------------------------- OPTICAS --------------------------------------------------------------

// Costado Faro
costadoFaro:
//-----------------------------------------------
		movz x2, 0x3B, lsl 16				// Triangulo gris 
		movk x2, 0x3D49, lsl 00				// Color

		mov x25, x5

	trialoop:
		add x21, x22, 51
		bfi x4, x21, 48, 16					// X0
		add x21, x23, x25
		bfi x4, x21, 32, 16					// Y0
		add x21, x22, 76
		bfi x4, x21, 16, 16					// X1
		add x21, x23, 40
		bfi x4, x21, 0, 16					// Y1

		mov x27, x30
		bl drawline
		mov x30, x27	
//-----------------------------------------------
		add x25, x25, 1
		cmp x25, 51

		b.le trialoop						// Triangulo gris 

		ret

costadoFaroEstatico:
//-----------------------------------------------
		movz x2, 0x3B, lsl 16				// Triangulo gris 
		movk x2, 0x3D49, lsl 00				// Color

		mov x25, 7

	trialoop2:
		add x21, x22, 51
		bfi x4, x21, 48, 16					// X0
		add x21, x23, x25
		bfi x4, x21, 32, 16					// Y0
		add x21, x22, 76
		bfi x4, x21, 16, 16					// X1
		add x21, x23, 40
		bfi x4, x21, 0, 16					// Y1

		mov x27, x30
		bl drawline
		mov x30, x27	
//-----------------------------------------------
		add x25, x25, 1
		cmp x25, 51

		b.le trialoop2						// Triangulo gris 

		ret




profundidadFaro:
//-----------------------------------------------
	movz x2, 0x00, lsl 16				
	movk x2, 0x0000, lsl 00				

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 46
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 8
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 8
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 8
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 46
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	ret

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
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
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
	mov x30, x27						// Carcasa Gris Oscuro 
//-----------------------------------------------
	movz x2, 0xAB, lsl 16				// Carcasa Roja 
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
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
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
	mov x30, x27						// Carcasa Roja 
//-----------------------------------------------

//-----------------------------------------------
	movz x2, 0xD2, lsl 16				// Optica		   
	movk x2, 0xD2D2, lsl 00				// Color1	

	add x21, x22, 28
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 31
	bfi x4, x21, 32, 16					// Y0
	movk x4, 19, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
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
//-----------------------------------------------
	movz x2, 0x51, lsl 16				
	movk x2, 0x6779, lsl 00				// Color4

	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	movk x4, 3, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27						// Optica		   
//-----------------------------------------------
	/*movz x2, 0x96, lsl 16				// Linea Roja 
	movk x2, 0x354E, lsl 00				// Color

	add x21, x22, 52
	bfi x4, x21, 48, 16					// X0
	add x21, x23, x5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27*/

	ret

// ------------------------------------------------- PARRILLA -----------------------------------------------------------------
parrilla:

	movz x2, 0x53, lsl 16				
	movk x2, 0x151d, lsl 00				

	add x21, x22, 15
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 8, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 163
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x44, lsl 16				
	movk x2, 0x050d, lsl 00				

	add x21, x22, 22
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 144
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x0d, lsl 16				
	movk x2, 0x0b0e, lsl 00	

	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	movk x4, 12, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 3
 	bfi x4, x21, 32, 16					// Y0  
	add x21, x22, 166
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	
//-----------------------------------------------
	add x21, x22, 52
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 21
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 164
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 28
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 66
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 28
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 148
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 31
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 163
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	movk x4, 12, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

//-------------------------------------------------- LINEA ---------------------------------------------------------------
	movz x2, 0x26, lsl 16				
	movk x2, 0x2626, lsl 00	

	add x21, x22, 26
	bfi x4, x21, 48, 16					// X0 = 
	add x21, x23, 16
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 154
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 16
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-------------------------------------------------- SONRISA --------------------------------------------------------------
	movz x2, 0xce, lsl 16				
	movk x2, 0x5f70, lsl 00	

	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0 = 76
	add x21, x23, 20
 	bfi x4, x21, 32, 16					// Y0  = 287
	add x21, x22, 23
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0 = 76
	add x21, x23, 32
 	bfi x4, x21, 32, 16					// Y0  = 287
	add x21, x22, 55
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 39
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 55
	bfi x4, x21, 48, 16					// X0 = 76
	add x21, x23, 39
 	bfi x4, x21, 32, 16					// Y0  = 287
	add x21, x22, 133
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 39
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 133
	bfi x4, x21, 48, 16					// X0 = 76
	add x21, x23, 39
 	bfi x4, x21, 32, 16					// Y0  = 287
	add x21, x22, 163
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 30
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 163
	bfi x4, x21, 48, 16					// X0 = 76
	add x21, x23, 30
 	bfi x4, x21, 32, 16					// Y0  = 287
	add x21, x22, 178
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

	ret

// ------------------------------------------------- SALIDAS DE AIRE ------------------------------------------------------
// ------------------------------------------------- IZQUIERDO 
salidaDeAireIzq:
	movz x2, 0x96, lsl 16				
	movk x2, 0x2237, lsl 00

	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ----------------------------------------------
	movz x2, 0x53, lsl 16				
	movk x2, 0x6765, lsl 00

	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 2
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 47
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ----------------------------------------------
	movz x2, 0x96, lsl 16				
	movk x2, 0x2237, lsl 00

	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 15
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 48
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 16
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 1
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 47
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 2
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 0
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 41
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 1
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	movz x2, 0x01, lsl 16				
	movk x2, 0x0505, lsl 00

	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 4
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 46
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 8
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 49
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 12
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 45
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 14
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	movz x2, 0xad, lsl 16				
	movk x2, 0xadad, lsl 00

	add x21, x22, 16
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ----------------------------------------------
	movz x2, 0x77, lsl 16				
	movk x2, 0x3c1a, lsl 00

	add x21, x22, 16
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

// ------------------------------------------------- DERECHO 
salidaDeAireDer:
	movz x2, 0x96, lsl 16				
	movk x2, 0x2237, lsl 00

	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x53, lsl 16				
	movk x2, 0x6765, lsl 00

	add x21, x22, 10
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x96, lsl 16				
	movk x2, 0x2237, lsl 00

	add x21, x22, 10
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 15
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 60
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 16
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 0
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 18
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, -1
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 65
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 0
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x53, lsl 16				
	movk x2, 0x6765, lsl 00
	
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 1
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 68
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//------------------------------------------------
	movz x2, 0x02, lsl 16				
	movk x2, 0x0605, lsl 00
	
	add x21, x22, 10
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 3
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x02, lsl 16				
	movk x2, 0x0605, lsl 00
	
	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0 
	add x21, x23, 7
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 9
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x02, lsl 16				
	movk x2, 0x0605, lsl 00
	
	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0 
	add x21, x23,11
 	bfi x4, x21, 32, 16					// Y0 
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0xb1, lsl 16				
	movk x2, 0xb1b1, lsl 00

	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x77, lsl 16				
	movk x2, 0x3c1a, lsl 00

	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	ret

// ------------------------------------------------- ESPEJITO ----------------------------------------------------------------
espejito:
	movz x2, 0xDF, lsl 16				
	movk x2, 0xABD1, lsl 00				

	add x21, x22, 30
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 13, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 27
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 13, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	movz x2, 0xB4, lsl 16				
	movk x2, 0x0101, lsl 00				

	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 10
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 38
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 34
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 10
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 38
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 31
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 11
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 6
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

//-----------------------------------------------
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 6
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 28
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 27
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	movk x4, 13, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 31
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	movk x4, 12, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

//-----------------------------------------------
	movz x2, 0x1B, lsl 16				
	movk x2, 0x1B1B, lsl 00			

	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 11
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 31
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0xDF, lsl 16				
	movk x2, 0xABD1, lsl 00				

	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 12
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
 //----------------------------------------------
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 15
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
 //----------------------------------------------
	add x21, x22, 10
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 40
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
 //----------------------------------------------
	movz x2, 0xB4, lsl 16				
	movk x2, 0x0101, lsl 00				

	add x21, x22, 28
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 16
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
 //----------------------------------------------
	movz x2, 0x4B, lsl 16				
	movk x2, 0x070B, lsl 00				

	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 20
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 27
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
 //----------------------------------------------
	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 22
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 27
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
 //----------------------------------------------
	add x21, x22, 34
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 38
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	ret
 //----------------------------------------------

// ------------------------------------------------- FRENTE AUTO ----------------------------------------------------------------
frenteAuto:

	movz x2, 0x5f, lsl 16				
	movk x2, 0x0819, lsl 00				

	add x21, x22, 43
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 34
	bfi x4, x21, 32, 16					// Y0
	movk x4, 34, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 323
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 321
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 46
	bfi x4, x21, 32, 16					// Y0
	movk x4, 26, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	movz x2, 0xc4, lsl 16				
	movk x2, 0x2537, lsl 00	

	add x21, x22, 344
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 56
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 358
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 30
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 49
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 336
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 70
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 69
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 322
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 248
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 75
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 39
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 66
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 73
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 126
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 126
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 73
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 223
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 248
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 329
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x89, lsl 16				
	movk x2, 0x1527, lsl 00	

	add x21, x22, 22
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	movk x4, 12, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 359
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 357
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 365
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//-----------------------------------------------
	movz x2, 0xed, lsl 16				
	movk x2, 0x4f65, lsl 00	
	
	add x21, x22, 280
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 366
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 280
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6 
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x50, lsl 16				
	movk x2, 0x0e0c, lsl 00	
	
	add x21, x22, 109
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 316
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-------------------------------------------------- SOMBRA COSTADO IZQUIERDO 
	movz x2, 0x6f, lsl 16				
	movk x2, 0x222c, lsl 00	
	
	add x21, x22, 1
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 19
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 15
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 14
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 34
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 34
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 13
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 39
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 38
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 15
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 43
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 11
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 17
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 47
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 47
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x60, lsl 16				
	movk x2, 0x4649, lsl 00	

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 3
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x60, lsl 16				
	movk x2, 0x4649, lsl 00	

	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 13
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 53
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x60, lsl 16				
	movk x2, 0x4649, lsl 00	

	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 53
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 60
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

	ret

//-------------------------------------------------- RUEDA DERECHA -----------------------------------------------------
ruedaderecha:
	movz x2, 0x04, lsl 16				
	movk x2, 0x090d, lsl 00				// Color

	add x21, x22, 60
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 60
	bfi x4, x21, 32, 16					// Y0
	movk x4, 60, lsl 16					// X1
// radio del circulo (derecha de x4)

	mov x27, x30
	bl drawcircle
	mov x30, x27

	ret

// ------------------------------------------------- PARACHOQUES DELANTERO -------------------------------------------------
paraChoques:
	movz x2, 0x0b, lsl 16				
	movk x2, 0x141b, lsl 00	

	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 30
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x2e, lsl 16				
	movk x2, 0x3339, lsl 00	

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 7
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 1
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 10
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 4
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 14
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x0b, lsl 16				
	movk x2, 0x141b, lsl 00	

	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 295
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 291
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 309
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 30
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 307
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 314
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 311
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 321
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 317
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 326
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 16
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 321
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 324
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 314
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 317
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 308
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 25
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 311
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 28
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 27
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 62
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 288
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 311
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x3f, lsl 16				
	movk x2, 0x5259, lsl 00
	
	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 47
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 18
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 151
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 231
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 47
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 55
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x2e, lsl 16				
	movk x2, 0x3339, lsl 00	

	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x2d, lsl 16				
	movk x2, 0x3446, lsl 00	

	add x21, x22, 96
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	movk x4, 4, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//------------------------------------------------
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 152
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	add x21, x22, 152
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//------------------------------------------------
	movz x2, 0x21, lsl 16				
	movk x2, 0x252e, lsl 00	

	add x21, x22, 265
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 310
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------
	movz x2, 0x00, lsl 16				
	movk x2, 0x0d12, lsl 00	

	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//------------------------------------------------
	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 4, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//------------------------------------------------
	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------	
	add x21, x22, 233
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-------------------------------------------
	add x21, x22, 233
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 267
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//------------------------------------------------	
	add x21, x22, 268
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-------------------------------------------
	movz x2, 0x3f, lsl 16				
	movk x2, 0x5259, lsl 00

	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

//-------------------------------------------------------------------------revisar----------------------------------------
	add x21, x22, 233
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 269
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-------------------------------------------
	add x21, x22, 269
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 277
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-------------------------------------------
	add x21, x22, 277
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 285
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 18
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-------------------------------------------
	add x21, x22, 227
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 233
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

	ret
//--------------------------------------------------------------------------------------------------------------------------
// ------------------------------------------------- PARABRISAS ------------------------------------------------------------
parabrisas:
//------------------------------------------------ relleno
	// rect 128
	movz x2, 0x03, lsl 16				
	movk x2, 0x566e, lsl 00

	add x21, x22, 50
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 61
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 127
	add x21, x22, 49
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 284
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 78
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 129
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 268
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 130
	add x21, x22, 42
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 131
	add x21, x22, 34
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 57
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 36
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 59
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 132
	add x21, x22, 28
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 38
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 30
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
	
	// rect 133
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

    // rect 134
	add x21, x22, 15
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 20
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 135
	add x21, x22, 11
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 15
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 136
	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 63
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 12
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 137
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 66
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 7
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 138
	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 69
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 5
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 139
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 12
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 64
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 140
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 56
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 19
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 59
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 141
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 50
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 21
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27


	// rect 142
	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 29
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 47
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 143
	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 35
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 38
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 144
	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 27
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 43
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 33
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27


	// rect 145
	add x21, x22, 47
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 19
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 50
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

//------------------------------------------------ reflejo 1
	// rect 15
	movz x2, 0xa3, lsl 16				
	movk x2, 0xbdd0, lsl 00

	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 58
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 14
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 18
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 63
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 13
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 9
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 12
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 62
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 21
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 11
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 29
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 10
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 51
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 29
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 9
	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 54
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 8
	add x21, x22, 26
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 40
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 38
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 7
	add x21, x22, 31
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 46
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 6
	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 48
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 5
	add x21, x22, 40
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 25
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 52
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 35
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 4
	add x21, x22, 43
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 55
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 31
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 3
	add x21, x22, 48
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 65
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 27
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 2
	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 1
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 78
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 21
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// ----------------------------------------------- reflejo 2
	// rect 154
	movz x2, 0x6c, lsl 16				
	movk x2, 0x88a0, lsl 00

	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 107
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 147
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 103
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 148
	add x21, x22, 60
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 27
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 149
	add x21, x22, 52
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 36
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 150
	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 74
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 46
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 151
	add x21, x22, 35
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 56
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 152
	add x21, x22, 29
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 53
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 53
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 153
	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 62
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 53
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 75
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// ----------------------------------------------- reflejo 3
	// rect 158
	movz x2, 0x6c, lsl 16				
	movk x2, 0x88a0, lsl 00

	add x21, x22, 253
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 73
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 260
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 157
	add x21, x22, 259
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 65
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 269
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
	
	// rect 156
	add x21, x22, 266
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 278
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 82
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 155
	add x21, x22, 273
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 51
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 284
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 81
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 161
	movz x2, 0xff, lsl 16				
	movk x2, 0xffff, lsl 00

	add x21, x22, 262
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 74
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 272
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	// rect 160
	add x21, x22, 268
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 69
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 277
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
    
	// rect 159
	add x21, x22, 275
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 60
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 284
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 81
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	ret

// ------------------------------------------------- CAPO FRENTE ------------------------------------------------------

capoFrente:
	movz x2, 0xe0, lsl 16				
	movk x2, 0x7d92, lsl 00	

	add x21, x22, 311
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 330
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 314
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 327
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 28
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// --------------------------------------------------------------- mover
	add x21, x22, 290
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 312
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 302
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 310
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------

	add x21, x22, 304
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 311
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 310
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 330
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
// ---------------------------------------------------------------
	movz x2, 0x8a, lsl 16				
	movk x2, 0x293d, lsl 00	

	add x21, x22, 310
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 324
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 319
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 333
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 34
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ---------------------------------------------------------------
	movz x2, 0x99, lsl 16				
	movk x2, 0x1523, lsl 00	

	add x21, x22, 10
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 8
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 14
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 35
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	movz x2, 0xff, lsl 16				
	movk x2, 0xabb3, lsl 00	

	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 330
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 330
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 343
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
// ----------------------------------------------
	movz x2, 0x3f, lsl 16				
	movk x2, 0x010f, lsl 00	

	add x21, x22, 1
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 6
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 38
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 11
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 41
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	movz x2, 0xa0, lsl 16				
	movk x2, 0x152c, lsl 00	

	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 46
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 37
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 48
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 47
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 280
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 46
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 340
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	movz x2, 0xe5, lsl 16				
	movk x2, 0x96a9, lsl 00	

	add x21, x22, 27
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	movk x4, 15, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ---------------------------------------------------------------
	movz x2, 0xfc, lsl 16				
	movk x2, 0x3e58, lsl 00	

	add x21, x22, 22
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 253
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 34
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	movz x2, 0xc3, lsl 16				
	movk x2, 0x2537, lsl 00	

	add x21, x22, 135
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	movk x4, 12, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ---------------------------------------------------------------
	add x21, x22, 131
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 301
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 28
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------
	movz x2, 0xc3, lsl 16				
	movk x2, 0x2537, lsl 00	
	add x21, x22, 43
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------------------------

	ret

// ------------------------------------------------- CONTORNO PARABRISAS ----------------------------------------------------------
contornoParabrisas:
// ---------------------------------------------- CONTORNO CLARO
	movz x2, 0xff, lsl 16				
	movk x2, 0xafb3, lsl 00	

	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 84
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 93
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 102
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 9
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 99
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 125
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 103
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 188
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 222
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 259
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 235
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 245
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 255
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 269
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 9
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 268
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 276
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 275
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 282
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 279
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 286
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 283
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 290
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 285
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 290
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 289
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 292
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 291
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 295
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 127
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 236
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	movz x2, 0xd3, lsl 16				
	movk x2, 0x7995, lsl 00	

	add x21, x22, 124
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 223
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 163
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 222
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- CONTORNO LATERAL
	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 47
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 22
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 49
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 55
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------


	add x21, x22, 52
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 60
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	movz x2, 0xd3, lsl 16				
	movk x2, 0x7995, lsl 00	

	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- CONTORNO ROJO
	movz x2, 0xf9, lsl 16				
	movk x2, 0x3962, lsl 00	

	add x21, x22, 282
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 286
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 279
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 284
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 273
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 279
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 16
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 276
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 281
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 18
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 241
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 255
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 250
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 268
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 263
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 268
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 221
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 245
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 9
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 84
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 14
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 60
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 90
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 102
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 268
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 275
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	
/*  ----------------------------------------------
	add x21, x22, 280
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 38
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 283
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 87
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
*/
// ---------------------------------------------- CONTORNO INTERNO
	movz x2, 0x00, lsl 16				
	movk x2, 0x3333, lsl 00	

	add x21, x22, 280
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 25
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 283
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 88
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 278
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 280
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 28
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 266
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 278
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 232
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 270
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 163
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 234
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 124
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 164
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 126
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 43
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 61
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 18
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 64
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 29
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 15
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 62
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 77
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 52
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 83
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 49			
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 112
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 83
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 112
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 167
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 83
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 167
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 236
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 83
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 236
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 282
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 87
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- CONTORNO EXTERNO
	movz x2, 0x33, lsl 16
	movk x2, 0x3333, lsl 00

	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 103
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 1
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 
	add x21, x22, 100
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 145
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 0
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 
	add x21, x22, 144
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 235
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 0
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 
	add x21, x22, 235
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 270
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 
	add x21, x22, 269
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 289
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 
	add x21, x22, 289
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 297
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 21
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
	
	ret


// ------------------------------------------------- ESQUINA ----------------------------------------------------------

esquina:
	movz x2, 0xe6, lsl 16				
	movk x2, 0x6675, lsl 00	

	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 50
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 30
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 11
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 34
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 53
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 18
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 27
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 42
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 41
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 25
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 19
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 48
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 57
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 68
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 9
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 80
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 114
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	movz x2, 0xc4, lsl 16				
	movk x2, 0x2537, lsl 00	

	add x21, x22, 114
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 127
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 114
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 124
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 49
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 52
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 49
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 67
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 60
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 69
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 62
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 60
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 67
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 105
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 116
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 9
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 62
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 85
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 26
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 52
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 33
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 40
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 58
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 40
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 27
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 126
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	movz x2, 0xf3, lsl 16				
	movk x2, 0x4357, lsl 00	

	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 64
	bfi x4, x21, 32, 16					// Y0
	movk x4, 3, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 45
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 55
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 55
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 64
	bfi x4, x21, 32, 16					// Y0
	movk x4, 3, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ----------------------------------------------
	movz x2, 0xf5, lsl 16				
	movk x2, 0xd7e3, lsl 00	

	add x21, x22, 112
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 127
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 105
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 114
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 99
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 107
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	movz x2, 0xe6, lsl 16				
	movk x2, 0x6675, lsl 00	

	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 114
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 74
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 18
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 45
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 37
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 41
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 55
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 74
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 52
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 57
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 53
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 41
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 46
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 42
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 49
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 53
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 52
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 74
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 57
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 58
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	movz x2, 0x63, lsl 16				
	movk x2, 0x151b, lsl 00	

	add x21, x22, 121
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	movk x4, 22, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 43
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 40
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 101
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 124
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 129
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 18
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 127
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 131
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 20
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 33
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 62
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 45
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 81
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 63
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 83
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 64
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 81
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 77
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 65
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 79
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 74
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 66
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 77
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 68
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 69
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 76
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 67
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 65
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 68
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 66
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 81
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 52
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 78
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 47
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 111
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 52
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 138
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 114
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 74
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 138
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 91
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 116
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 91
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 136
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 103
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 118
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 103
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 133
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 107
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 119
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 107
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 132
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 111
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 119
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 111
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 126
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 125
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 125
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 110
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 130
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 117
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 125
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 117
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 129
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 122
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	movz x2, 0x7d, lsl 16				
	movk x2, 0x2d33, lsl 00	

	add x21, x22, 119
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 129
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 125
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 133
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ----------------------------------------------
	add x21, x22, 119
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 125
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 126
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 129
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0xf3, lsl 16				
	movk x2, 0x4357, lsl 00					

	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 46
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 43
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 38
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 34
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 31
	bfi x4, x21, 32, 16					// Y0
	movk x4, 6, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x2f, lsl 16				
	movk x2, 0x050b, lsl 00					

	add x21, x22, 111
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 75
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 114
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 82
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 109
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 112
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 75
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 107
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 60
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 110
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 105
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 55
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 108
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 59
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 100
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 52
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 54
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 47
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 101
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 51
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	movz x2, 0x7d, lsl 16				
	movk x2, 0x2533, lsl 00					

	add x21, x22, 114
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 75
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 120
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 87
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 112
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 66
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 117
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 75
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 110
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 60
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 115
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 108
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 111
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 60
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 105
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 51
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 109
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 101
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 106
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 52
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 45
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 103
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27


	ret

// ------------------------------------------------- PUERTA ----------------------------------------------------------------
puerta:
//----------------------------------------------- 749
	movz x2, 0x79, lsl 16				
	movk x2, 0x1017, lsl 00					

	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 750
	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 38
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 751
	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 38
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 95
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 43
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 752
	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 51
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 753
	add x21, x22, 25
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 50
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 99
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 754
	add x21, x22, 25
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 755
	add x21, x22, 25
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 72
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 768
	add x21, x22, 37
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 113
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 119
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 769
	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 113
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 62
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 123
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 770
	add x21, x22, 18
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 119
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 38
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 126
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 771
	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 92
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 29
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 115
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 756
	add x21, x22, 26
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 80
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 116
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 772
	add x21, x22, 22
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 101
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 25
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 119
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 773
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 106
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 24
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 120
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 774
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 115
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 24
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 127
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 775
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 18
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 128
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 776
	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 34
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 127
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 777
	add x21, x22, 35
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 121
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 46
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 126
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 778
	add x21, x22, 61
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 118
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 121
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 779
	add x21, x22, 15
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 126
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 25
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 87
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 757
	add x21, x22, 25
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 74
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 759
	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 24
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 33
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 792
	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 781
	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 793
	add x21, x22, 84
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 794
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 795
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 796
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 797
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 782
	add x21, x22, 92
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 95
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 39
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 783
	add x21, x22, 93
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 43
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 734
	movz x2, 0x73, lsl 16				
	movk x2, 0x0c21, lsl 00					

	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 116
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 119
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 735
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 118
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 122
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 736
	add x21, x22, 60
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 120
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 122
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 737
	add x21, x22, 54
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 122
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 124
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 738
	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 123
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 58
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 126
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 739
	add x21, x22, 37
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 47
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 127
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 740
	add x21, x22, 29
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 126
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 38
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 129
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 741
	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 127
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 131
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 742
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 127
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 20
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 788
	movz x2, 0xc9, lsl 16				
	movk x2, 0x041f, lsl 00					

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 8
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 789
	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 12
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 790
	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 706
	add x21, x22, 15
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 709
	add x21, x22, 16
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 34
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 710
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 18
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 711
	add x21, x22, 18
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 21
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 712
	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 29
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 713
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 25
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 707
	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 19
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 708
	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 15
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 804
	movz x2, 0x63, lsl 16				
	movk x2, 0x151b, lsl 00					

	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 118
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 65
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 122
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 803
	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 115
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 69
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 121
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 802
	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 109
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 74
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 121
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 801
	add x21, x22, 74
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 103
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 121
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 800
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 94
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 118
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 799
	add x21, x22, 84
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 88
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 117
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 798
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 116
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 714
	movz x2, 0xff, lsl 16				
	movk x2, 0xe7e3, lsl 00					

	add x21, x22, 34
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 42
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 715
	add x21, x22, 34
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 38
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 716
	add x21, x22, 49
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 54
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 717
	add x21, x22, 50
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 718
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 73
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 719
	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 720
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 723
	movz x2, 0x53, lsl 16				
	movk x2, 0x5155, lsl 00					

	add x21, x22, 18
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 43
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 724
	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 43
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 791
	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 45
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

//----------------------------------------------- 729
	movz x2, 0x4f, lsl 16				
	movk x2, 0x6563, lsl 00					

	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 27
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 727
	movz x2, 0xe3, lsl 16				
	movk x2, 0xffff, lsl 00					

	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 25
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 728
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 27
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 733
	movz x2, 0x63, lsl 16				
	movk x2, 0x151b, lsl 00					

	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 130
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 117
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 730
	movz x2, 0xad, lsl 16				
	movk x2, 0x4549, lsl 00					

	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 113
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 70
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 760
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 761
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 14
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 762
	add x21, x22, 87
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 763
	add x21, x22, 92
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 22
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 95
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 30
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 764
	add x21, x22, 93
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 42
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 765
	add x21, x22, 96
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 40
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 100
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 54
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 766
	add x21, x22, 98
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 53
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 99
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 767
	add x21, x22, 97
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 64
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 100
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

	ret

// ------------------------------------------------- RUEDA DELANTERA IZQUIERDA -----------------------------------------------------------------
ruedaDelanteraIzq:
// ---------------------------------------------- 978
	movz x2, 0x00, lsl 16			 
	movk x2, 0x0000, lsl 00			

	add x21, x22, 63
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 118
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 77
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 946
	movz x2, 0x1f, lsl 16				
	movk x2, 0x2124, lsl 00					

	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 72
	bfi x4, x21, 32, 16					// Y0
	movk x4, 57, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 946
	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 102
	bfi x4, x21, 32, 16					// Y0
	movk x4, 57, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 948
	add x21, x22, 110
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 73
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 116
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 98
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1079
	movz x2, 0x00, lsl 16			 
	movk x2, 0x0000, lsl 00	

	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 69
	bfi x4, x21, 32, 16					// Y0
	movk x4, 27, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 1079
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 95
	bfi x4, x21, 32, 16					// Y0
	movk x4, 31, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 1079
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 122
	bfi x4, x21, 32, 16					// Y0
	movk x4, 17, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
// ---------------------------------------------- 1064
	movz x2, 0x22, lsl 16			 
	movk x2, 0x2327, lsl 00			

	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 72
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 84
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1065
	movz x2, 0x42, lsl 16			 
	movk x2, 0x4240, lsl 00			

	add x21, x22, 92
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 84
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 95
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1069
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 98
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 111
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1068
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 94
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 104
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1070
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 110
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 115
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1071
	add x21, x22, 87
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 112
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 115
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1072
	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 115
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 118
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1073
	add x21, x22, 84
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 118
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 126
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1074
	add x21, x22, 80
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 125
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 128
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1075
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 127
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 81
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 130
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1076
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 129
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1067
	movz x2, 0x12, lsl 16			 
	movk x2, 0x1214, lsl 00			

	add x21, x22, 92
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 86
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 90
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1036
	add x21, x22, 97
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 76
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 102
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 91
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1051
	add x21, x22, 96
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 101
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 82
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1052
	add x21, x22, 90
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 100
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1053
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 99
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1054
	add x21, x22, 87
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 57
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 63
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1055
	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 95
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 59
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1056
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 50
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1057
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 47
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1058
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1059
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 46
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1060
	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 44
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1061
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1037
	add x21, x22, 97
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 91
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 102
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 98
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1038
	add x21, x22, 96
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 96
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 101
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 104
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1039
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 104
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 100
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 108
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1040
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 108
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 99
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 112
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1041
	add x21, x22, 93
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 111
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 116
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1042
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 115
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 119
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1043
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 117
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 122
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1044
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 119
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 124
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1045
	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1046
	add x21, x22, 83
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 126
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 129
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1047
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 128
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 131
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1048
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 130
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1049
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 130
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 133
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1050
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 132
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 134
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 979
	movz x2, 0x84, lsl 16			 
	movk x2, 0x8486, lsl 00			

	add x21, x22, 102
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 90
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 106
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 103
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 980
	add x21, x22, 101
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 98
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 106
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 981
	add x21, x22, 100
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 104
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 104
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 110
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 982
	add x21, x22, 99
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 109
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 103
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 114
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 983
	add x21, x22, 98
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 122
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 102
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 126
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 984
	add x21, x22, 97
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 114
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 101
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 119
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 985
	add x21, x22, 96
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 116
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 100
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 121
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 986
	add x21, x22, 95
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 119
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 99
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 123
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 987
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 121
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 125
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 988
	add x21, x22, 93
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 122
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 126
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 989
	add x21, x22, 92
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 128
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 990
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 125
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 129
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 991
	add x21, x22, 90
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 126
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 94
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 130
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 992
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 127
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 131
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 993
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 128
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 994
	add x21, x22, 87
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 129
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 133
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 995
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 130
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 134
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 996
	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 131
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 135
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 997
	movz x2, 0x70, lsl 16			 
	movk x2, 0x7176, lsl 00			

	add x21, x22, 84
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 132
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 87
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 136
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 998
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 132
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 137
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 999
	add x21, x22, 80
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 133
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 138
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1000
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 134
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 138
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1001
	movz x2, 0x4b, lsl 16			 
	movk x2, 0x4f52, lsl 00		

	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 128
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1002
	add x21, x22, 68
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 132
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 73
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 137
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1003
	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 130
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 136
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1004
	add x21, x22, 60
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 130
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 64
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 135
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1005
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 129
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 63
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 133
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1006
	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 127
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 61
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 131
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1007
	add x21, x22, 55
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 125
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 59
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 129
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1008
	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 123
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 57
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 127
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1009
	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 105
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 56
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 124
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ---------------------------------------------- 1010
	add x21, x22, 45
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 106
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 55
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 124
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ---------------------------------------------- 1011
	add x21, x22, 45
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 108
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 54
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 125
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ---------------------------------------------- 1012
	add x21, x22, 44
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 95
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 47
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 109
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ---------------------------------------------- 1010
	add x21, x22, 44
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 86
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 45
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 97
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1015
	movz x2, 0x34, lsl 16			 
	movk x2, 0x3436, lsl 00		

	add x21, x22, 102
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 82
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 106
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 90
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1016
	add x21, x22, 102
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 90
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 106
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 103
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1017
	add x21, x22, 101
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 70
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1018
	add x21, x22, 100
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 104
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1019
	add x21, x22, 99
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 65
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 104
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1020
	add x21, x22, 99
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 62
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 103
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1021
	add x21, x22, 98
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 59
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 103
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 62
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1022
	add x21, x22, 97
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 56
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 101
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 59
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1023
	add x21, x22, 95
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 54
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 100
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 56
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1024
	add x21, x22, 93
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 51
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 54
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1025
	add x21, x22, 92
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 49
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 51
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1026
	add x21, x22, 90
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 47
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 95
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1027
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 47
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1028
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1029
	add x21, x22, 83
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 40
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 43
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1030
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 38
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 41
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1031
	add x21, x22, 64
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1032
	add x21, x22, 63
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 41
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1033
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 35
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 36
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 934
	movz x2, 0x2f, lsl 16			 
	movk x2, 0x2d32, lsl 00		

	add x21, x22, 63
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 81
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 75
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 935
	add x21, x22, 66
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 68
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 936
	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 73
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 68
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 937
	add x21, x22, 61
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 99
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 105
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 938
	add x21, x22, 67
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 105
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 108
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 939
	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 84
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 65
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 95
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 940
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 86
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 91
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 958
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 95
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 98
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 959
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 96
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 101
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 954
	movz x2, 0x0f, lsl 16			 
	movk x2, 0x181f, lsl 00		

	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 80
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 955
	add x21, x22, 64
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 93
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 918
	movz x2, 0x4c, lsl 16				
	movk x2, 0x4a4f, lsl 00					

	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 68
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 931
	add x21, x22, 56
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 86
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 60
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 78
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 933
	add x21, x22, 56
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 83
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 60
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 101
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 920
	add x21, x22, 80
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 77
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 91
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 921
	add x21, x22, 78
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 70
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 75
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 922
	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 65
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 923
	add x21, x22, 64
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 71
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 924
	add x21, x22, 80
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 75
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 92
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 925
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 97
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 90
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 926
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 106
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 107
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 927
	add x21, x22, 80
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 97
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 97
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 928
	add x21, x22, 74
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 107
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 81
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 97
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 929
	add x21, x22, 63
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 103
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 73
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 109
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 930
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 100
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 63
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 105
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
// ---------------------------------------------- 943
	movz x2, 0x2a, lsl 16			 
	movk x2, 0x1319, lsl 00		

	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 75
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 944
	add x21, x22, 64
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 75
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 951
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 91
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 78
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 100
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 946
	movz x2, 0x12, lsl 16			 
	movk x2, 0x0001, lsl 00		

	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 75
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 63
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 85
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 948
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 95
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 66
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 101
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 949
	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 92
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 100
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 950
	add x21, x22, 78
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 91
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 96
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 951
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 91
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 78
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 100
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 947
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 62
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 84
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 861
	movz x2, 0x00, lsl 16			 
	movk x2, 0x0000, lsl 00		

	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 151
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 68
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 157
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 862
	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 148
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 58
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 151
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 863
	add x21, x22, 50
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 144
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 53
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 148
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 864
	add x21, x22, 44
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 138
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 145
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 865
	add x21, x22, 40
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 132
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 138
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 866
	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 129
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 40
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 867
	add x21, x22, 37
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 126
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 38
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 129
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
// ---------------------------------------------- 852
	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 151
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 58
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 157
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 849
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 127
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 37
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 136
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 864
	add x21, x22, 11
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 132
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 40
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 138
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 865
	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 138
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 141
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 866
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 141
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 144
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 867
	add x21, x22, 16
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 144
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 50
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 148
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 868
	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 148
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 53
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 152
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 869
	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 152
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 53
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 155
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 870
	add x21, x22, 23
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 155
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 53
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 157
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 857
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 129
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 38
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 858
	add x21, x22, 12
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 125
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 37
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 129
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 859
	add x21, x22, 16
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 123
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 36
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 126
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 860
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 119
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 36
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 123
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 861
	add x21, x22, 16
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 110
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 120
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 916
	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 155
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 157
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 961
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 153
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 156
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1093
	add x21, x22, 87
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 150
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 152
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1094
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 148
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 150
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 1095
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 145
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 95
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 148
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 961
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 150
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 155
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 960
	add x21, x22, 26
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 156
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 159
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
// ---------------------------------------------- 872
	add x21, x22, 84
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 154
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 144
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 875
	movz x2, 0x11, lsl 16			 
	movk x2, 0x1111, lsl 00		

	add x21, x22, 64
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 38
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 33
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 876
	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 33
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 36
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 877
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 34
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 99
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 51
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 878
	add x21, x22, 97
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 49
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 879
	add x21, x22, 103
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 63
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 108
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 79
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 880
	add x21, x22, 106
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 78
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 107
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 102
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27	
//----------------------------------------------- 881
	add x21, x22, 102
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 114
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 107
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 102
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 885
	movz x2, 0x44, lsl 16			 
	movk x2, 0x4444, lsl 00		

	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 133
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 141
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 886
	add x21, x22, 65
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 139
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 143
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 887
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 143
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 142
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 888
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 139
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1084
	add x21, x22, 42
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 130
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 52
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 142
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1085
	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 117
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 132
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1086
	add x21, x22, 35
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 103
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 40
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 119
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 889
	add x21, x22, 100
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 128
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 120
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 890
	add x21, x22, 103
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 122
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 108
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 112
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1087
	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 31
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1088
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 35
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1089
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 33
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 97
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 42
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 891
	add x21, x22, 102
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 130
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 107
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 121
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1090
	add x21, x22, 94
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 102
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 41
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1091
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 95
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 33
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1092
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 962
	movz x2, 0x1b, lsl 16			 
	movk x2, 0x1c21, lsl 00		

	add x21, x22, 55
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 125
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 66
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 134
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 963
	add x21, x22, 64
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 132
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 73
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 137
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 964
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 136
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 137
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline

	mov x30, x27
//----------------------------------------------- 965
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 137
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 131
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 966
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 133
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 123
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 967
	add x21, x22, 95
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 102
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 112
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 968
	add x21, x22, 100
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 123
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 104
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 111
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 969
	add x21, x22, 102
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 104
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 94
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 970
	add x21, x22, 103
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 104
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 95
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 971
	add x21, x22, 100
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 60
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 104
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 972
	add x21, x22, 96
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 52
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 102
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 62
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 973
	add x21, x22, 90
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 45
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 98
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 54
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 974
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 47
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 893
	movz x2, 0x5e, lsl 16			 
	movk x2, 0x5c5f, lsl 00		

	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 68
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 894
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 51
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 63
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 895
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 72
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 62
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 896
	add x21, x22, 80
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 76
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 68
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 897
	add x21, x22, 87
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 91
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 898
	add x21, x22, 83
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 96
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 108
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 899
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 106
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 122
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 900
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 108
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 121
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 901
	add x21, x22, 67
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 131
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 120
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 902
	add x21, x22, 59
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 116
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 64
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 102
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 903
	add x21, x22, 56
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 61
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 114
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 904
	add x21, x22, 52
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 105
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 61
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 99
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 905
	add x21, x22, 47
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 106
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 54
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 103
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 906
	add x21, x22, 42
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 87
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 58
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 83
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 907
	add x21, x22, 54
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 72
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 61
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 80
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 908
	add x21, x22, 50
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 56
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 74
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 909
	add x21, x22, 61
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 70
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 910
	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 52
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 63
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 60
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

	ret

// --------------------------------------------- GUARADABARROS ------------------------------------------------------------
/*  add x22, x6, 446
	add x23, x26, 292
	bl grupo54
*/	
guardabarros: 
// Rectangulo 1103
	movz x2, 0x0f, lsl 16				
	movk x2, 0x0a10, lsl 00	

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 19
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 33
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 1102
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 31
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 30
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 1101
	add x21, x22, 27
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 28
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 1100
	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 58
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 1099
	add x21, x22, 50
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 1098
	add x21, x22, 60
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 1104
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// FORMA 1105 (triangulo)
	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 96
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 1
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27

	ret

// ------------------------------------------------ LUZ -------------------------------------------------------------------
/*	add x22, x6, 346
	add x23, x26, 271
	bl luz */
luz: 
// Elipse 11
	movz x2, 0x70, lsl 16				
	movk x2, 0x3815, lsl 00	

	add x21, x22, 5
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

// Rectangulo 18
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 18
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 18
	movz x2, 0x9f, lsl 16				
	movk x2, 0x5015, lsl 00	

	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 23
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Elipse 11
	add x21, x22, 21 
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6 
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

// Forma 14
	movz x2, 0x62, lsl 16				
	movk x2, 0x1714, lsl 00	

	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 2
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	

// Forma 14
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 24
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	

// Forma 14
	movz x2, 0xb8, lsl 16				
	movk x2, 0x6b63, lsl 00	

	add x21, x22, 1
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	
	

	ret

// -------------------------------------- ESPEJO RETROVISOR DERECHO -------------------------------------------------------
espejoDerecho:
/*	add x22, x6, 151
	add x23, x26, 148
	bl espejoDerecho */

// Rectangulo 89
	movz x2, 0xea, lsl 16				
	movk x2, 0x3c53, lsl 00		

	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Elipse 25
	movz x2, 0xef, lsl 16				
	movk x2, 0x5a6d, lsl 00				// Color

	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12 
	bfi x4, x21, 32, 16					// Y0
	movk x4, 12, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

// Rectangulo 90
	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 7
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 83
	movz x2, 0xe8, lsl 16				
	movk x2, 0xb1ae, lsl 00	

	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 9
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 84
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 13
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 85
	movz x2, 0xa8, lsl 16				
	movk x2, 0x2336, lsl 00	

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 9
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
	
// Rectangulo 86
	add x21, x22, 1
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 12
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

// Rectangulo 87
	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 15
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
	
// Rectangulo 88
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 19
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	ret

// ------------------------------------------------- CULO DEL AUTO ----------------------------------------------------------------
culoDelAuto:
//----------------------------------------------- 823
	movz x2, 0x79, lsl 16			 
	movk x2, 0x1017, lsl 00		

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 37
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 840
	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 44
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 841
	add x21, x22, 42
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 48
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 44
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 842
	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 51
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 44
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 824
	movz x2, 0xa6, lsl 16			 
	movk x2, 0x2730, lsl 00		

	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 37
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 825
	add x21, x22, 4
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
//----------------------------------------------- 826
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 26
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 827
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 20
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 3
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 828
	movz x2, 0x64, lsl 16			 
	movk x2, 0x151b, lsl 00		

	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 41
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 829
	add x21, x22, 41
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 43
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 21
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 831
	add x21, x22, 40
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 49
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 31
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 832
	add x21, x22, 49
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 26
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 52
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 39
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 833
	add x21, x22, 51
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 54
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 834
	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 45
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 55
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 835
	add x21, x22, 54
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 47
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 56
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 810
	movz x2, 0x64, lsl 16			 
	movk x2, 0x151b, lsl 00		

	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 79
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 810
	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 79
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 809
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 43
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 82
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 819
	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 43
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 36
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 820
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 26
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 30
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 36
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 821
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 27
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 822
	add x21, x22, 8
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 19
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 22
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 823
	add x21, x22, 13
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 35
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 844
	add x21, x22, 33
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 77
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 36
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 813
	movz x2, 0xa6, lsl 16			 
	movk x2, 0x2730, lsl 00		
	
	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 64
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 46
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 812
	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 46
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 814
	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 43
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 815
	add x21, x22, 37
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 42
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 36
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

ret

// ------------------------------------------------- RUEDA IZQUIERDA TRASERA ----------------------------------------------------------------
ruedaTraseraIzq:
//----------------------------------------------- 1202
	movz x2, 0x00, lsl 16			 
	movk x2, 0x0000, lsl 00		

	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 27
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1205
	movz x2, 0x2b, lsl 16			 
	movk x2, 0x1008, lsl 00	

	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1206
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 40
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1178
	movz x2, 0x16, lsl 16			 
	movk x2, 0x1718, lsl 00	

	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 46
	bfi x4, x21, 32, 16					// Y0
	movk x4, 46, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 1179
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 50
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 104
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1179
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 50
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 104
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1180
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 103
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 113
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1181
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 105
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 115
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1182
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 115
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 123
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1183
	add x21, x22, 83
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 113
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 87
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 119
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1184	
	add x21, x22, 83
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 117
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 122
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1185
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 50
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 100
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1186
	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 85
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 78
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 125
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1187
	add x21, x22, 74
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 121
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 127
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1157
	movz x2, 0x04, lsl 16			 
	movk x2, 0x0509, lsl 00	

	add x21, x22, 68
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 41
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1158
	add x21, x22, 72
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 74
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 41
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1159
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1160
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 46
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1161
	add x21, x22, 69
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 45
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 57
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1163
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 73
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 103
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1177
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 66
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1164
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 96
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 102
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1165
	add x21, x22, 74
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 84
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 95
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1166
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 34
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 55
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1167
	add x21, x22, 74
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 34
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1168
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 46
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1169
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1170
	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1171
	movz x2, 0x0b, lsl 16			 
	movk x2, 0x1216, lsl 00	

	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 85
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 64
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1172
	add x21, x22, 80
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 64
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 67
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1173
	add x21, x22, 84
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 69
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1174
	add x21, x22, 68
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 65
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 73
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 76
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1175
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 82
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 88
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1137
	movz x2, 0x22, lsl 16			 
	movk x2, 0x2220, lsl 00	

	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 55
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1138
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 60
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1139
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 66
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 75
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1141
	movz x2, 0x42, lsl 16			 
	movk x2, 0x4043, lsl 00	

	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 70
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 85
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1140
	add x21, x22, 88
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 73
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 92
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1142
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 85
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 92
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1143
	add x21, x22, 85
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 92
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 97
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1144
	add x21, x22, 83
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 95
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 89
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 103
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1145
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 99
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 87
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 104
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1146
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 102
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 108
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1148
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 103
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 107
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1147
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 104
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 109
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1151
	movz x2, 0x1e, lsl 16			 
	movk x2, 0x1d22, lsl 00	

	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 88
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 87
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 92
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1152
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 92
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 95
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1153
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 95
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 98
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1154
	add x21, x22, 77
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 98
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 81
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 103
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1109
	movz x2, 0x00, lsl 16			 
	movk x2, 0x0106, lsl 00	

	add x21, x22, 30
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 63
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 60
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 101
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1110
	add x21, x22, 31
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 98
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 64
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 108
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1111
	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 108
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 113
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1112
	add x21, x22, 34
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 112
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 69
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 118
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1113
	add x21, x22, 36
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 117
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 72
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 122
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1114
	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 121
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 74
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 125
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1115
	add x21, x22, 39
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 124
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 128
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1116
	add x21, x22, 60
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 64
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 99
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 1117
	add x21, x22, 64
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 99
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 67
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 108
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 1118
	add x21, x22, 67
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 108
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 78
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 129
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1207
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 126
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 128
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1121
	movz x2, 0x4c, lsl 16			 
	movk x2, 0x4a4f, lsl 00	

	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 34
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 78
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 47
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1122
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 46
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 53
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1123
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 56
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 52
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1124
	add x21, x22, 76
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 56
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 81
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1125
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 74
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1126
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 86
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 73
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 92
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1127
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 101
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 73
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 92
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1129
	movz x2, 0x38, lsl 16			 
	movk x2, 0x1a24, lsl 00	

	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 55
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1130
	add x21, x22, 68
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 59
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1131
	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 64
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 80
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 69
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1132
	add x21, x22, 73
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 84
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 73
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1133
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 69
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 86
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 75
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1134
	movz x2, 0x0f, lsl 16			 
	movk x2, 0x0005, lsl 00	

	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 77
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 81
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 81
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1194
	movz x2, 0x11, lsl 16			 
	movk x2, 0x1111, lsl 00	

	add x21, x22, 78
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 25
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 82
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1195
	add x21, x22, 81
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 88
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 37
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1196
	add x21, x22, 86
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 35
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1197
	add x21, x22, 89
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 47
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 93
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 1198
	add x21, x22, 91
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 55
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 91
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 78
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27


	ret

// ------------------------------------------------- VENTANA ----------------------------------------------------------------

ventana:
// ------------------------------------------------ RELLENO
//----------------------------------------------- 546
	movz x2, 0x1b, lsl 16			 
	movk x2, 0x1b1b, lsl 00	

	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 40
	bfi x4, x21, 32, 16					// Y0
	movk x4, 37, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 547
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 45
	bfi x4, x21, 32, 16					// Y0
	movk x4, 8, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 548
	movz x2, 0x44, lsl 16			 
	movk x2, 0x4444, lsl 00	

	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 549
	add x21, x22, 68
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 22
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 550
	add x21, x22, 58
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 69
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 551
	add x21, x22, 67
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 552
	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 69
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 27
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 553
	add x21, x22, 66
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 76
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

// ------------------------------------------------ CONTORNO
//----------------------------------------------- 111
	movz x2, 0x33, lsl 16			 
	movk x2, 0x3333, lsl 00	

	add x21, x22, 24
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 3
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 112
	add x21, x22, 33
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 45
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 3
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 502
	add x21, x22, 45
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 62
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 503
	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 71
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 504
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 34
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 505
	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 34
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 79
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 44
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 506
	add x21, x22, 79
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 77
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

	ret

// ------------------------------------------------- VENTANITA DERECHA -----------------------------------------------------------------
ventanita:
//----------------------------------------------- 162
	movz x2, 0x03, lsl 16			 
	movk x2, 0x566e, lsl 00		
	
	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 11
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 70
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 163
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 19
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 164
	add x21, x22, 10
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 19
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 45
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 165
	add x21, x22, 10
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 34
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 166
	add x21, x22, 18
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 47
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 21
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 167
	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 24
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 71
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 108
	add x21, x22, 10
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 23
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 59
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

//----------------------------------------------- 110
	movz x2, 0x9b, lsl 16			 
	movk x2, 0xaebd, lsl 00		
	
	add x21, x22, 2
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 4
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 41
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 170
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 11
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 12
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 171
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 9
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 172
	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 12
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 173
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 8
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 174
	add x21, x22, 11
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 16
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 101
	movz x2, 0x31, lsl 16			 
	movk x2, 0x3131, lsl 00		
	
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 9
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 0
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 102
	add x21, x22, 1
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 5
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 3
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 103
	add x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 69
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 3
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 104
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 67
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 32
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 105
	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 17
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 106
	add x21, x22, 14
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 22
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 21
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 107
	add x21, x22, 20
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 45
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 25
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 72
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

ret
// ------------------------------------------------- TECHO ----------------------------------------------------------------
techo:
//----------------------------------------------- 556
	movz x2, 0x51, lsl 16			 
	movk x2, 0x6c7d, lsl 00		
	
	add x21, x22, 82
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 184
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 3
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 576
	add x21, x22, 68
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 83
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 577
	add x21, x22, 44
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 69
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 557
	add x21, x22, 160
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 210
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 558
	add x21, x22, 176
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 223
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 559
	add x21, x22, 194
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 232
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 575
	add x21, x22, 231
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 240
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 564
	add x21, x22, 232
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 243
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 566
	add x21, x22, 246
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 250
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 21
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 568
	add x21, x22, 251
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 19
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 255
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 568
	add x21, x22, 251
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 19
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 255
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 560
	add x21, x22, 214
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 247
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 561
	add x21, x22, 215
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 227
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 21
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 574
	add x21, x22, 217
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 252
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 569
	add x21, x22, 254
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 22
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 266
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 37
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 570
	add x21, x22, 264
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 271
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 50
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 571
	add x21, x22, 270
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 274
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 59
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 578
	add x21, x22, 22
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 2
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 579
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 24
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 572
	movz x2, 0x2f, lsl 16			 
	movk x2, 0x3c44, lsl 00		
	
	add x21, x22, 272
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 276
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 65
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 573
	add x21, x22, 275
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 279
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 66
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 580
	movz x2, 0x3d, lsl 16			 
	movk x2, 0x505c, lsl 00		
	
	add x21, x22, 287
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 290
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 581
	add x21, x22, 289
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 79
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 295
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 82
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 582
	add x21, x22, 289
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 81
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 294
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 85
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

ret

// ------------------------------------------------- CAPO ----------------------------------------------------------------
capo:
//----------------------------------------------- 31
	movz x2, 0xc4, lsl 16			 
	movk x2, 0x2537, lsl 00	

	add x21, x22, 75
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 114
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 49
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 30
	add x21, x22, 113
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 121
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 51
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 29
	add x21, x22, 119
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 2
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 289
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 54
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

//----------------------------------------------- 1200
	movz x2, 0xc4, lsl 16			 
	movk x2, 0x2537, lsl 00	
	
	add x21, x22, 288
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 317
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 34
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//-----------------------------------------------
	add x21, x22, 289
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 57
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 321
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 34
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 1201
	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 38
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 64
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 52
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1202
	add x21, x22, 29
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 39
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1203
	add x21, x22, 54
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1204
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 29
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 43
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 39
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1205
	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 43
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 30
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1206
	add x21, x22, 46
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 54
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 35
	movz x2, 0xff, lsl 16			 
	movk x2, 0x8d9b, lsl 00	

	add x21, x22, 361
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 394
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 23
	add x21, x22, 361
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 383
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawtriangle
	mov x30, x27
//----------------------------------------------- 36
	add x21, x22, 360
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 378
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 20
	movz x2, 0x40, lsl 16			 
	movk x2, 0x020f, lsl 00	

	add x21, x22, 104
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 124
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 1
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 21
	add x21, x22, 71
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 106
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 22
	add x21, x22, 83
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 105
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 7
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 33
	movz x2, 0x86, lsl 16			 
	movk x2, 0x343e, lsl 00	

	add x21, x22, 111
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 7
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 113
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 32
	add x21, x22, 105
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 8
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 113
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 10
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 37
	movz x2, 0xc4, lsl 16				
	movk x2, 0x2537, lsl 00

	add x21, x22, 57
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 90
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 51
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 38
	movz x2, 0xb8, lsl 16			 
	movk x2, 0x192b, lsl 00

	add x21, x22, 9
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 36
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 44
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1207
	add x21, x22, 17
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 29
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 35
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 36
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1208
	add x21, x22, 29
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 36
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 1209
	add x21, x22, 21
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 24
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 29
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 38
	add x21, x22, 6
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 40
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 12
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 38
	add x21, x22, 4
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 44
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 29
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 52
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 38
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 6
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 52
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	movz x2, 0xff, lsl 16			 
	movk x2, 0xa39b, lsl 00

	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 100
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	add x21, x22, 166
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 194
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 21
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	add x21, x22, 38
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 100
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	add x21, x22, 170
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 16
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 202
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	add x21, x22, 177
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 15
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 211
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 18
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	add x21, x22, 183
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 14
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 217
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	add x21, x22, 184
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 12
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 223
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 15
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	add x21, x22, 223
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 231
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 14
	add x21, x22, 125
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 6
	bfi x4, x21, 32, 16					// Y0
	movk x4, 3, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27
//----------------------------------------------- 17
	add x21, x22, 99
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 22
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 138
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 16
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 22
	movz x2, 0xff, lsl 16			 
	movk x2, 0xe1e9, lsl 00

	add x21, x22, 240
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 289
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 23
	add x21, x22, 155
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 171
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 6
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 23
	movz x2, 0xff, lsl 16			 
	movk x2, 0xbcd6, lsl 00

	add x21, x22, 163
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 172
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 8
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 25
	movz x2, 0xfc, lsl 16			 
	movk x2, 0xb7c1, lsl 00

	add x21, x22, 187
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 21
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 236
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 26
	add x21, x22, 144
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 26
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 242
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 35
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 26
	add x21, x22, 109
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 32
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 140
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 35
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 26
	add x21, x22, 126
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 30
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 157
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 35
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 26
	add x21, x22, 144
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 26
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 242
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 35
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 2
	movz x2, 0xfc, lsl 16			 
	movk x2, 0x8d96, lsl 00

	add x21, x22, 99
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 35
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 224
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 39
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 28
	add x21, x22, 288
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 337
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 26
	movz x2, 0xff, lsl 16			 
	movk x2, 0x485f, lsl 00
	
	add x21, x22, 67
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 48
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 235
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 51
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 26
	movz x2, 0xff, lsl 16			 
	movk x2, 0x7b89, lsl 00
	
	add x21, x22, 78
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 39
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 243
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 48
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 21
	movz x2, 0xff, lsl 16			 
	movk x2, 0xa39b, lsl 00
	
	add x21, x22, 223
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 10
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 231
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 13
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 28
	movz x2, 0xf4, lsl 16			 
	movk x2, 0x5470, lsl 00
	
	add x21, x22, 289
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 3
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 361
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 14
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 28
	movz x2, 0xdf, lsl 16			 
	movk x2, 0x6d86, lsl 00
	
	add x21, x22, 338
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 362
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 19
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 27 - 1
	movz x2, 0xf7, lsl 16			 
	movk x2, 0xe2e1, lsl 00
	
	add x21, x22, 308
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 23
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 333
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 27
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 27 - 2
	add x21, x22, 312
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 25
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 328
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 29
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 27 - 3
	add x21, x22, 315
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 28
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 323
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 32
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 27 - 4
	add x21, x22, 328
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 339
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 24
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 27 - 5

	
	add x21, x22, 333
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 18
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 346
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 22
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27

	ret

// ------------------------------------------------- CONTORNO ESQUINA  --------------------------------------------------------------------
contornoEsquina:

//-----------------------------------------------
	movz x2, 0x74, lsl 16			//
	movk x2, 0x1223, lsl 00
	
	add x21, x22, 18
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 26
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 44
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 19
	add x21, x22, 42
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 66
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 4
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 583
	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 49
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 13
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 59
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 584
	add x21, x22, 11
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 58
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 21
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 70
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 585
	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 69
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 33
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 586
	add x21, x22, 32
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 86
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 58
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 587
	add x21, x22, 111
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 122
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 5
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 588
	add x21, x22, 122
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 126
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 11
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 589
	add x21, x22, 126
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 11
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 132
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 26
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 590
	add x21, x22, 132
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 26
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 135
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 42
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 591
	add x21, x22, 135
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 42
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 135
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 61
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 592
	add x21, x22, 135
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 61
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 136
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27
//----------------------------------------------- 593
	add x21, x22, 132
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 102
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 135
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 86
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27
//----------------------------------------------- 594
	add x21, x22, 122
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 125
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 132
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 102
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27

	ret

// ------------------------------------------------- PATENTE  --------------------------------------------------------------------
patente:
	movz x2, 0xCC, lsl 16
	movk x2, 0xCCCC, lsl 00	

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 0
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	sub x21, x22, 3
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 75
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	

	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 5
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 70
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 20
	bfi x4, x21, 32, 16					// Y0
	movk x4, 5, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	movz x2, 0x00, lsl 16
	movk x2, 0x0000, lsl 00	

	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 9, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 27
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 9, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 47
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 9, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	movz x2, 0xCC, lsl 16
	movk x2, 0xCCCC, lsl 00	

	add x21, x22, 7
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 27
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 51
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 13
	bfi x4, x21, 32, 16					// Y0
	movk x4, 7, lsl 16					// X1

	mov x27, x30
	bl drawcircle
	mov x30, x27

	add x21, x22, 53
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 0
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 58
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	

	movz x2, 0x00, lsl 16
	movk x2, 0x0000, lsl 00	

	add x21, x22, 19
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 4
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 26
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 23
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawsquare
	mov x30, x27	

	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 1
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 9
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27	

	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 1
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27	

	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 9
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27	

	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 9
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27	

	add x21, x22, 62
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 17
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 66
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 25
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27	

	add x21, x22, 66
	bfi x4, x21, 48, 16					// X0
	add x21, x23, 25
	bfi x4, x21, 32, 16					// Y0
	add x21, x22, 70
	bfi x4, x21, 16, 16					// X1
	add x21, x23, 17
	bfi x4, x21, 0, 16					// Y1

	mov x27, x30
	bl drawline
	mov x30, x27	


	ret

// ------------------------------------------------- PARCHES ----------------------------------------------------------------
parches:
//------- PARCHE CAPO
	movz x2, 0xc4, lsl 16				
	movk x2, 0x2537, lsl 00

	movz x4, 320, lsl 48
	movk x4, 300, lsl 32
	movk x4, 371, lsl 16
	movk x4, 340, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	

	movz x2, 0xfc, lsl 16				
	movk x2, 0x3e58, lsl 00

	movz x4, 102, lsl 48
	movk x4, 300, lsl 32
	movk x4, 148, lsl 16
	movk x4, 325, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27

	movz x2, 0xc4, lsl 16				
	movk x2, 0x2537, lsl 00

	movz x4, 102, lsl 48
	movk x4, 300, lsl 32
	movk x4, 148, lsl 16
	movk x4, 305, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27


	movz x2, 0xff, lsl 16				
	movk x2, 0xabb3, lsl 00

	movz x4, 102, lsl 48
	movk x4, 338, lsl 32
	movk x4, 148, lsl 16
	movk x4, 345, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27

	movz x4, 340, lsl 48
	movk x4, 338, lsl 32
	movk x4, 382, lsl 16
	movk x4, 346, lsl 0


	mov x27, x30
	bl drawsquare
	mov x30, x27
	

	ret

// ------------------------------------------------- PARCHES PRE ----------------------------------------------------------------
parchesPre:
	//------- PARCHE PARABRISAS
	movz x2, 0x03, lsl 16				
	movk x2, 0x566e, lsl 00

	movz x4, 321, lsl 48
	movk x4, 240, lsl 32
	movk x4, 381, lsl 16
	movk x4, 260, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	


//------- PARCHE ARENA
 	movz x2, 0xE2, lsl 16
	movk x2, 0xCA76, lsl 00	

	movz x4, 94, lsl 48
	movk x4, 298, lsl 32
	movk x4, 98, lsl 16
	movk x4, 302, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	
//----------------------
	movz x4, 94, lsl 48
	movk x4, 268, lsl 32
	movk x4, 105, lsl 16
	movk x4, 298, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	
//----------------------
	movz x4, 105, lsl 48
	movk x4, 282, lsl 32
	movk x4, 109, lsl 16
	movk x4, 287, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	
//----------------------
	movz x4, 105, lsl 48
	movk x4, 276, lsl 32
	movk x4, 117, lsl 16
	movk x4, 282, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	
//----------------------
	movz x4, 105, lsl 48
	movk x4, 273, lsl 32
	movk x4, 134, lsl 16
	movk x4, 276, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	
//----------------------
	movz x4, 104, lsl 48
	movk x4, 270, lsl 32
	movk x4, 142, lsl 16
	movk x4, 273, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	
//----------------------
	movz x4, 104, lsl 48
	movk x4, 267, lsl 32
	movk x4, 163, lsl 16
	movk x4, 270, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27	
//----------------------
	movz x4, 94, lsl 48
	movk x4, 246, lsl 32
	movk x4, 172, lsl 16
	movk x4, 268, lsl 0

	mov x27, x30
	bl drawsquare
	mov x30, x27


	

	ret


