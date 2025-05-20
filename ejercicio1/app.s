	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

	.equ GPIO_BASE,      0x3f200000
	.equ GPIO_GPFSEL0,   0x00
	.equ GPIO_GPLEV0,    0x34

	.globl main

main:
	// x0 contiene la direccion base del framebuffer
 	mov x20, x0							// Guarda la dirección base del framebuffer en x20
	//---------------- CODE HERE ------------------------------------

	movz x2, 0xFF, lsl 16
	movk x2, 0xFFFF, lsl 00

	movz x4, 400, lsl 48 				// X0
	movk x4, 200, lsl 32 				// Y0
	movk x4, 100, lsl 16 				// X1 (En este caso actua como Radio)

	bl drawcircle

	movz x2, 0xFF, lsl 16
	movk x2, 0x00FF, lsl 00

	movz x4, 100, lsl 48 				// X0
	movk x4, 100, lsl 32 				// Y0
	movk x4, 300, lsl 16 				// X1
	movk x4, 300, lsl 00 				// Y1

	bl drawsquare

	//-------------------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop

//------------------------------Funciones de dibujo--------------------------//

// Dibuja pixel en las cordenadas almacenadas en los registros x7(X) y x8(Y)
drawpixel: 
    mov x1, 640
    mul x1, x8, x1
    add x1, x1, x7
    lsl x1, x1, 2
    add x1, x1, x0
	stur x2,[x1]
    ret

// Dibuja un rectangulo entre las cordenadas A y B en x4
drawsquare:
	lsl x11, x4, 32 					//Guardamos en x11 el valor de X1
	lsr x11, x11, 48

	lsl x12, x4, 48 					//Guardamos en x12 el valor de Y1
	lsr x12, x12, 48

	lsl x8, x4, 16  					// Setea el valor original de la cordenada Y0
	lsr x8, x8, 48

loopsquare1:
	lsr x7, x4, 48  					// Setea el valor original de la cordenada X0

loopsquare2:
	mov x29, x30 						// Guardamos el valor original del RET
	bl drawpixel 						// Dibujamos el pixel en la coordenada actual (x7, x8)
	mov x30, x29 						// Restauramos el valor del RET
	add x7, x7, 1 						// Incrementamos X
	cmp x7, x11
	b.ne loopsquare2 					//Verificamos que llego al limite de X
	add x8, x8, 1 						// Incrementamos Y
	cmp x8, x12 						//Verificamos que llego al limite de Y
	b.ne loopsquare1
	ret

// Dibuja un circulo con centro en la cordenada A con un radio R (X1)
drawcircle:
    lsr x9, x4, 48  					// Guardamos la coordenada X del centro

    lsl x10, x4, 16  					// Guardamos la coordenada Y del centro
	lsr x10, x10, 48

    lsl x11, x4, 32  					// Guardamos el radio
	lsr x11, x11, 48

    mul x12, x11, x11 					// Elevamos al cuadrado el radio

    sub x8, x10, x12  					// Inicializamos Y en el límite superior del cuadrado (Y0 - r)

	add x15, x9, x11 					// Calculamos el límite derecho del cuadrado (X0 + r)

	add x16, x10, x11 					// Calculamos el límite inferior del cuadrado (Y0 + r)


loopcircle1:
    sub x7, x9, x12  					// Inicializamos X en el límite izquierdo del cuadrado (X0 - r)


// Calculamos la distancia al cuadrado desde el centro del círculo
loopcircle2:
    sub x13, x7, x9  					// Diferencia en X (X - X0)
    sub x14, x8, x10  					// Diferencia en Y (Y - Y0)
    mul x13, x13, x13 					// (X - X0)^2
    mul x14, x14, x14 					// (Y - Y0)^2
    add x13, x13, x14 					// (X - X0)^2 + (Y - Y0)^2

    cmp x13, x12      					// Comparamos con el radio al cuadrado
    b.gt circuloskip  					// Si está fuera del círculo, saltamos

    mov x29, x30      					// Guardamos el valor original del RET
    bl drawpixel      					// Dibujamos el pixel en la coordenada actual (x7, x8)
    mov x30, x29      					// Restauramos el valor del RET

circuloskip:
    add x7, x7, 1     					// Incrementamos X
    cmp x7, x15
    b.le loopcircle2   					// Continuamos iterando en X si no hemos llegado al límite
    add x8, x8, 1     					// Incrementamos Y
    cmp x8, x16
    b.le loopcircle1   					// Continuamos iterando en Y si no hemos llegado al límite

    ret


