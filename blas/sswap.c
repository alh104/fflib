/* fortran/sswap.f -- translated by f2c (version 20100827).
   You must link the resulting object file with libf2c:
	on Microsoft Windows system, link with libf2c.lib;
	on Linux or Unix systems, link with .../path/to/libf2c.a -lm
	or, if you install libf2c.a in a standard place, with -lf2c -lm
	-- in that order, at the end of the command line, as in
		cc *.o -lf2c -lm
	Source for libf2c is in /netlib/f2c/libf2c.zip, e.g.,

		http://www.netlib.org/f2c/libf2c.zip
*/

#include "f2c.h"

/* Subroutine */ void sswap_(integer *n, real *sx, integer *incx, real *sy, 
	integer *incy)
{
    /* System generated locals */
    integer i__1;

    /* Local variables */
    static integer i__, m, ix, iy, mp1;
    static real stemp;

/*     .. Scalar Arguments .. */
/*     .. */
/*     .. Array Arguments .. */
/*     .. */

/*  Purpose */
/*  ======= */

/*     interchanges two vectors. */
/*     uses unrolled loops for increments equal to 1. */

/*  Further Details */
/*  =============== */

/*     jack dongarra, linpack, 3/11/78. */
/*     modified 12/3/93, array(1) declarations changed to array(*) */

/*  ===================================================================== */

/*     .. Local Scalars .. */
/*     .. */
/*     .. Intrinsic Functions .. */
/*     .. */
    /* Parameter adjustments */
    --sy;
    --sx;

    /* Function Body */
    if (*n <= 0) {
	return;
    }
    if (*incx == 1 && *incy == 1) {

/*       code for both increments equal to 1 */


/*       clean-up loop */

	m = *n % 3;
	if (m != 0) {
	    i__1 = m;
	    for (i__ = 1; i__ <= i__1; ++i__) {
		stemp = sx[i__];
		sx[i__] = sy[i__];
		sy[i__] = stemp;
	    }
	    if (*n < 3) {
		return;
	    }
	}
	mp1 = m + 1;
	i__1 = *n;
	for (i__ = mp1; i__ <= i__1; i__ += 3) {
	    stemp = sx[i__];
	    sx[i__] = sy[i__];
	    sy[i__] = stemp;
	    stemp = sx[i__ + 1];
	    sx[i__ + 1] = sy[i__ + 1];
	    sy[i__ + 1] = stemp;
	    stemp = sx[i__ + 2];
	    sx[i__ + 2] = sy[i__ + 2];
	    sy[i__ + 2] = stemp;
	}
    } else {

/*       code for unequal increments or equal increments not equal */
/*         to 1 */

	ix = 1;
	iy = 1;
	if (*incx < 0) {
	    ix = (-(*n) + 1) * *incx + 1;
	}
	if (*incy < 0) {
	    iy = (-(*n) + 1) * *incy + 1;
	}
	i__1 = *n;
	for (i__ = 1; i__ <= i__1; ++i__) {
	    stemp = sx[ix];
	    sx[ix] = sy[iy];
	    sy[iy] = stemp;
	    ix += *incx;
	    iy += *incy;
	}
    }
    return;
} /* sswap_ */

