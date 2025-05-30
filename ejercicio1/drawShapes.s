	.equ SCREEN_WIDTH, 		640
	.equ SCREEN_HEIGH, 		480
	.equ BITS_PER_PIXEL,  	32

    .globl drawpixel
    .globl drawline
    .globl drawsquare
    .globl drawcircle
    .globl drawtriangle
	.globl drawHorizontalLine

//----------------------------------------------- FUNCIONES DE DIBUJO ----------------------------------------------------

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
	lsr x9, x4, 48 						// Guardamos en x9 el valor de X0

	lsl x10, x4, 16 					// Guardamos en x10 el valor de Y0
	lsr x10, x10, 48

	lsl x11, x4, 32 					// Guardamos en x11 el valor de X1
	lsr x11, x11, 48

	lsl x12, x4, 48 					// Guardamos en x12 el valor de Y1
	lsr x12, x12, 48	

	sub x13, x11, x9 					// Calculamos las distancias entre los puntos
	sub x14, x12, x10 

	mov x20, x13 						// Calculamos los valores absolutos de las distancias
	mov x28, x30
	bl abs
	mov x30, x28
	mov x13, x20 						// abs(X1-X0)

	mov x20, x14
	mov x28, x30
	bl abs
	mov x30, x28
	mov x14, x20 						// abs(Y1-Y0)

	cmp x13, x14
	csel x19, x13, x14, gt
	add x19, x19, 1

	mov x15, xzr
	sub x14, x15, x14 					//-abs(Y1-Y0)
	
	mov x17, 1
	mov x18, -1

	cmp x9, x11
	csel x15, x17, x18, lt 				// if X0 < X1 then x15 = 1, else -1

	cmp x10, x12
	csel x16, x17, x18, lt 				// if Y0 < Y1 then x16 = 1, else -1

	add x17, x13, x14 					// error = distanciaX + distanciaY

	mov x7, x9 							// Seteamos valores iniciales
	mov x8, x10

	mov x29, x30 						// Guardamos el valor original del RET


loopline:
	bl drawpixel 						// Dibujamos el pixel en la coordenada actual (x7, x8)
	
	sub x19, x19, 1

	add x18, x17, x17 					// e2 = error * 2

	cmp x18, x14 						// if e2 >= distanciaY then:
	b.lt lineskip1
	add x17, x17, x14 					// error = error + distanciaY
	add x7, x7, x15

lineskip1:

	cmp x18, x13 						// if e2 <= distanciaX then:
	b.gt lineskip2
	add x17, x17, x13 					// error = error + distanciaX
	add x8, x8, x16

lineskip2: 
	cbnz x19, loopline 
	mov x30, x29 						// Restauramos el valor del RET
	ret

// Dibuja un rectangulo entre las cordenadas A y B en x4
drawsquare:
	lsl x11, x4, 32 					// Guardamos en x11 el valor de X1
	lsr x11, x11, 48

	lsl x12, x4, 48 					// Guardamos en x12 el valor de Y1
	lsr x12, x12, 48

	lsl x8, x4, 16  					// Setea el valor original de la cordenada Y0
	lsr x8, x8, 48

	mov x29, x30 						// Guardamos el valor original del RET

loopsquare1:
	lsr x7, x4, 48  					// Setea el valor original de la cordenada X0

loopsquare2:
	bl drawpixel 						// Dibujamos el pixel en la coordenada actual (x7, x8)
	add x7, x7, 1 						// Incrementamos X
	cmp x7, x11
	b.ne loopsquare2 					//Verificamos que llego al limite de X
	add x8, x8, 1 						// Incrementamos Y
	cmp x8, x12 						//Verificamos que llego al limite de Y
	b.ne loopsquare1
	mov x30, x29 						// Restauramos el valor del RET
	ret

// Dibuja un circulo con centro en la cordenada A con un radio R (X1)
drawcircle:
    lsr x9, x4, 48  					// Guardamos la coordenada X0 del centro

    lsl x10, x4, 16  					// Guardamos la coordenada Y0 del centro
	lsr x10, x10, 48

    lsl x11, x4, 32  					// Guardamos el radio
	lsr x11, x11, 48

    mul x12, x11, x11 					// Elevamos al cuadrado el radio

    sub x8, x10, x12  					// Inicializamos Y en el límite superior del cuadrado (Y0 - r)

	add x15, x9, x11 					// Calculamos el límite derecho del cuadrado (X0 + r)

	add x16, x10, x11 					// Calculamos el límite inferior del cuadrado (Y0 + r)

    mov x29, x30      					// Guardamos el valor original del RET

loopcircle1:
    sub x7, x9, x12  					// Inicializamos X en el límite izquierdo del cuadrado (X0 - r)

loopcircle2:
    sub x13, x7, x9  					// Diferencia en X (X - X0)
    sub x14, x8, x10  					// Diferencia en Y (Y - Y0)
    mul x13, x13, x13 					// (X - X0)^2
    mul x14, x14, x14 					// (Y - Y0)^2
    add x13, x13, x14 					// (X - X0)^2 + (Y - Y0)^2

    cmp x13, x12      					// Comparamos con el radio al cuadrado
    b.gt circuloskip  					// Si está fuera del círculo, saltamos

    bl drawpixel      					// Dibujamos el pixel en la coordenada actual (x7, x8)

circuloskip:
    add x7, x7, 1     					// Incrementamos X
    cmp x7, x15
    b.le loopcircle2   					// Continuamos iterando en X si no hemos llegado al límite
    add x8, x8, 1     					// Incrementamos Y
    cmp x8, x16
    b.le loopcircle1   					// Continuamos iterando en Y si no hemos llegado al límite
    mov x30, x29      					// Restauramos el valor del RET
    ret


// Dibuja un triangulo desde la cordenada A a la B utilizando el algorimo de Bresenham
drawtriangle:
	lsr x9, x4, 48 						// Guardamos en x9 el valor de X0

	lsl x10, x4, 16 					// Guardamos en x10 el valor de Y0
	lsr x10, x10, 48

	lsl x11, x4, 32 					// Guardamos en x11 el valor de X1
	lsr x11, x11, 48

	lsl x12, x4, 48 					// Guardamos en x12 el valor de Y1
	lsr x12, x12, 48	

	sub x13, x11, x9 					// Calculamos las distancias entre los puntos
	sub x14, x12, x10 

	mov x20, x13 						// Calculamos los valores absolutos de las distancias
	mov x28, x30
	bl abs
	mov x30, x28
	mov x13, x20 						// abs(X1-X0)

	mov x20, x14
	mov x28, x30
	bl abs
	mov x30, x28
	mov x14, x20 						// abs(Y1-Y0)

	cmp x13, x14
	csel x19, x13, x14, gt
	add x19, x19, 1

	mov x15, xzr
	sub x14, x15, x14 					//-abs(Y1-Y0)
	
	mov x17, 1
	mov x18, -1

	cmp x9, x11
	csel x15, x17, x18, lt 				// if X0 < X1 then x15 = 1, else -1

	cmp x10, x12
	csel x16, x17, x18, lt 				// if Y0 < Y1 then x16 = 1, else -1

	add x17, x13, x14 					// error = distanciaX + distanciaY

	mov x7, x9 							// Seteamos valores iniciales
	mov x8, x10

	mov x28, x30

looptriangle1:

	mov x21, x9
	mov x20, x8
	mov x5, x7
	bl drawHorizontalLine

	cmp x5, x11						// Si la posicion actual = x11 (x1), llegue al final y corto el programa
	b.eq endtriangle

	sub x19, x19, 1
	add x18, x17, x17 					// e2 = error * 2
	cmp x18, x14 						// if e2 >= distanciaY then:
	b.lt triangleskip1
	add x17, x17, x14 					// error = error + distanciaY
	add x7, x7, x15	


triangleskip1:
	cmp x18, x13 						// if e2 <= distanciaX then:
	b.gt triangleskip2
	add x17, x17, x13 					// error = error + distanciaX
	add x8, x8, x16

triangleskip2: 
	cbnz x19, looptriangle1
	mov x30, x28 						// Restauramos el valor del RET
	ret

endtriangle:
	mov x30, x28            			// Restauramos x30
    ret


// ------------------------------------------------------------------------------------------

drawHorizontalLine:

	cmp x21, x5
	csel x24, x21, x5, le

	cmp x21, x5
	csel x25, x5, x21, le
	mov x8, x20

	mov x29, x30            			// Guardamos x30 (RET)
	
drawHorizontalLine_loop:
	mov x7, x24						    // Guardo en x7, la posicion actual
	bl drawpixel					    // Dibujo

	add x24, x24, 1 					// Avanzamos o retrocedemos en la linea
	cmp x24, x25					
	b.le  drawHorizontalLine_loop
	
	mov x30, x29            			// Restauramos x30
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

