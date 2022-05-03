	.syntax			unified
	.cpu			cortex-m4
	.text

/* float __attribute__((weak)) Discriminant(float a, float b, float c) */
	.global			Discriminant
	.thumb_func
	.align
Discriminant:
    // S0=a, S1=b, S2=c
    VMUL.F32        S0,S0,S2        // S0 <- a*c
    VMOV            S2,4.0          // S2 <- 4.0
    VMUL.F32        S0,S0,S2        // S0 <- 4.0*a*c
    VMUL.F32        S1,S1,S1        // S1 <- b*b
    VSUB.F32        S0,S1,S0        // S0 <- b*b - 4.0*a*c

    BX              LR

/* float __attribute__((weak)) Quadratic(float x, float a, float b, float c) */
	.global			Quadratic
	.thumb_func
	.align
Quadratic:
    // S0=x, S1=a, S2=b, S3=c

    VMUL.F32        S1,S1,S0        // S1 <- a*x
    VADD.F32        S1,S2,S1        // S1 <- b+a*x
    VMUL.F32        S0,S0,S1        // S0 <- x*(b+a*x)
    VADD.F32        S0,S0,S3        // S0 <- c+x*(b+a*x)

    BX              LR

/* float __attribute__((weak)) Root1(float a, float b, float c) */
	.global			Root1
	.thumb_func
	.align
Root1:
    PUSH            {LR}

    VPUSH           {S16-S18}
    VMOV            S16,S0          // S16 <- a
    VMOV            S17,S1          // S17 <- b
    VMOV            S18,S2          // S18 <- c

    BL              Discriminant    // calling Discriminant
    VSQRT.F32       S0,S0           // sqrt(dscrt)
    VNEG.F32        S17,S17         // S17 <- b = -b
    VADD.F32        S0,S17,S0       // S0 <- -b + sqrt(dscrt)
    VMOV            S1,2.0
    VMUL.F32        S16,S1,S16      // S16 = 2.0*a
    VDIV.F32        S0,S0,S16       // S0 <- S0/S16 = -b + sqrt(dscrt)) / 2.0*a
    VPOP            {S16-S18}

    POP             {PC}

/* loat __attribute__((weak)) Root2(float a, float b, float c) */
	.global			Root2
	.thumb_func
	.align
Root2:
    PUSH            {LR}

    VPUSH           {S16-S18}
    VMOV            S16,S0          // S16 <- a
    VMOV            S17,S1          // S17 <- b
    VMOV            S18,S2          // S18 <- c

    BL              Discriminant    // calling Discriminant
    VSQRT.F32       S0,S0           // sqrt(dscrt)
    VNEG.F32        S17,S17         // S17 <- b = -b
    VSUB.F32        S0,S17,S0       // S0 <- -b - sqrt(dscrt)
    VMOV            S1,2
    VMUL.F32        S16,S1,S16      // S16 <- 2.0*a
    VDIV.F32        S0,S0,S16		// S0 = S0/S16 => (-b - sqrt(dscrt)) / 2*a
    VPOP            {S16-S18}

    POP             {PC}

    .end