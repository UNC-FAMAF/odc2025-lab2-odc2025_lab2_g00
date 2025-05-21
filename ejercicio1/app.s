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

	movz x2, 0xFF, lsl 16
	movk x2, 0xFFFF, lsl 00

	movz x4, 400, lsl 48 // X0
	movk x4, 200, lsl 32 // Y0
	movk x4, 100, lsl 16 // X1 (En este caso actua como Radio)

	bl drawcircle

	movz x2, 0xFF, lsl 16
	movk x2, 0x00FF, lsl 00

	movz x4, 100, lsl 48 // X0
	movk x4, 100, lsl 32 // Y0
	movk x4, 300, lsl 16 // X1
	movk x4, 300, lsl 00 // Y1

	bl drawsquare


	movz x4, 0, lsl 48 // X0
	movk x4, 480, lsl 32 // Y0
	movk x4, 640, lsl 16 // X1
	movk x4, 0, lsl 00 // Y1

	bl drawline

	//---------------------------------------------------------------
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

// Dibuja una linea desde la cordenada A a la B utilizando el algorimo de Bresenham
drawline:
	lsr x9, x4, 48 // Guardamos en x9 el valor de X0

	lsl x10, x4, 16 // Guardamos en x10 el valor de Y0
	lsr x10, x10, 48

	lsl x11, x4, 32 // Guardamos en x11 el valor de X1
	lsr x11, x11, 48

	lsl x12, x4, 48 // Guardamos en x12 el valor de Y1
	lsr x12, x12, 48	

	sub x13, x11, x9 // Calculamos las distancias entre los puntos
	sub x14, x12, x10 

	mov x20, x13 // Calculamos los valores absolutos de las distancias
	bl abs
	mov x13, x20 // abs(X1-X0)

	mov x20, x14
	bl abs
	mov x14, x20 // abs(Y1-Y0)

	mov x15, xzr
	sub x14, x15, x14 //-abs(Y1-Y0)
	

	mov x17, 1
	mov x18, -1

	cmp x9, x11
	csel x15, x17, x18, lt // if X0 < X1 then x15 = 1, else -1

	cmp x10, x12
	csel x16, x17, x18, lt // if Y0 < Y1 then x16 = 1, else -1

	add x17, x13, x14 // error = distanciaX + distanciaY

	mov x7, x9 // Seteamos valores iniciales
	mov x8, x10

loopline:
	mov x29, x30 // Guardamos el valor original del RET
	bl drawpixel // Dibujamos el pixel en la coordenada actual (x7, x8)
	mov x30, x29 // Restauramos el valor del RET

	add x18, x17, x17 // e2 = error * 2

	cmp x18, x14 // if e2 >= distanciaY then:
	b.lt lineskip1
	cmp x7, x11 // if X == X1 then break
	b.eq linefinish
	add x17, x17, x14 // error = error + distanciaY
	add x7, x7, x15

lineskip1:

	cmp x18, x13 // if e2 <= distanciaX then:
	b.gt lineskip2
	cmp x8, x12 // if X == X1 then break
	b.eq linefinish
	add x17, x17, x13 // error = error + distanciaX
	add x8, x8, x16

lineskip2:
	b loopline

linefinish: 
	ret

// Dibuja un rectangulo entre las cordenadas A y B en x4
drawsquare:
	lsl x11, x4, 32 // Guardamos en x11 el valor de X1
	lsr x11, x11, 48

	lsl x12, x4, 48 // Guardamos en x12 el valor de Y1
	lsr x12, x12, 48

	lsl x8, x4, 16  // Setea el valor original de la cordenada Y0
	lsr x8, x8, 48

loopsquare1:
	lsr x7, x4, 48  // Setea el valor original de la cordenada X0

loopsquare2:
	mov x29, x30 // Guardamos el valor original del RET
	bl drawpixel // Dibujamos el pixel en la coordenada actual (x7, x8)
	mov x30, x29 // Restauramos el valor del RET
	add x7, x7, 1 // Incrementamos X
	cmp x7, x11
	b.ne loopsquare2 //Verificamos que llego al limite de X
	add x8, x8, 1 // Incrementamos Y
	cmp x8, x12 //Verificamos que llego al limite de Y
	b.ne loopsquare1
	ret

// Dibuja un circulo con centro en la cordenada A con un radio R (X1)
drawcircle:
    lsr x9, x4, 48  // Guardamos la coordenada X del centro

    lsl x10, x4, 16  // Guardamos la coordenada Y del centro
	lsr x10, x10, 48

    lsl x11, x4, 32  // Guardamos el radio
	lsr x11, x11, 48

    mul x12, x11, x11 // Elevamos al cuadrado el radio

    sub x8, x10, x12  // Inicializamos Y en el límite superior del cuadrado (Y0 - r)

	add x15, x9, x11 // Calculamos el límite derecho del cuadrado (X0 + r)

	add x16, x10, x11 // Calculamos el límite inferior del cuadrado (Y0 + r)


loopcircle1:
    sub x7, x9, x12  // Inicializamos X en el límite izquierdo del cuadrado (X0 - r)

loopcircle2:
    // Calculamos la distancia al cuadrado desde el centro del círculo
    sub x13, x7, x9  // Diferencia en X (X - X0)
    sub x14, x8, x10  // Diferencia en Y (Y - Y0)
    mul x13, x13, x13 // (X - X0)^2
    mul x14, x14, x14 // (Y - Y0)^2
    add x13, x13, x14 // (X - X0)^2 + (Y - Y0)^2

    cmp x13, x12      // Comparamos con el radio al cuadrado
    b.gt circuloskip  // Si está fuera del círculo, saltamos

    mov x29, x30      // Guardamos el valor original del RET
    bl drawpixel      // Dibujamos el pixel en la coordenada actual (x7, x8)
    mov x30, x29      // Restauramos el valor del RET

circuloskip:
    add x7, x7, 1     // Incrementamos X
    cmp x7, x15
    b.le loopcircle2   // Continuamos iterando en X si no hemos llegado al límite
    add x8, x8, 1     // Incrementamos Y
    cmp x8, x16
    b.le loopcircle1   // Continuamos iterando en Y si no hemos llegado al límite

    ret


//---------------------------Funciones Matematicas---------------------------//

// Calcula el absoluto del valor en x20
abs: 
	cmp x20, xzr
	b.GE skipabs
	mov x19, xzr
	sub x20, x19, x20

skipabs:
	ret
