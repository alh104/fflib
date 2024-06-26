/* fortran/zdscal.f -- translated by f2c (version 20100827).
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

/* Subroutine */ void zdscal_(integer *n, doublereal *da, doublecomplex *zx, 
	integer *incx)
{
    /* System generated locals */
    integer i__1, i__2, i__3, i__4;
    doublecomplex z__1, z__2;

    /* Local variables */
    static integer i__, nincx;

/*     .. Scalar Arguments .. */
/*     .. */
/*     .. Array Arguments .. */
/*     .. */

/*  Purpose */
/*  ======= */

/*     ZDSCAL scales a vector by a constant. */

/*  Further Details */
/*  =============== */

/*     jack dongarra, 3/11/78. */
/*     modified 3/93 to return if incx .le. 0. */
/*     modified 12/3/93, array(1) declarations changed to array(*) */

/*  ===================================================================== */

/*     .. Local Scalars .. */
/*     .. */
/*     .. Intrinsic Functions .. */
/*     .. */
    /* Parameter adjustments */
    --zx;

    /* Function Body */
    if (*n <= 0 || *incx <= 0) {
	return;
    }
    if (*incx == 1) {

/*        code for increment equal to 1 */

	i__1 = *n;
	for (i__ = 1; i__ <= i__1; ++i__) {
	    i__2 = i__;
	    z__2.r = *da, z__2.i = 0.;
	    i__3 = i__;
	    z__1.r = z__2.r * zx[i__3].r - z__2.i * zx[i__3].i, z__1.i = 
		    z__2.r * zx[i__3].i + z__2.i * zx[i__3].r;
	    zx[i__2].r = z__1.r, zx[i__2].i = z__1.i;
	}
    } else {

/*        code for increment not equal to 1 */

	nincx = *n * *incx;
	i__1 = nincx;
	i__2 = *incx;
	for (i__ = 1; i__2 < 0 ? i__ >= i__1 : i__ <= i__1; i__ += i__2) {
	    i__3 = i__;
	    z__2.r = *da, z__2.i = 0.;
	    i__4 = i__;
	    z__1.r = z__2.r * zx[i__4].r - z__2.i * zx[i__4].i, z__1.i = 
		    z__2.r * zx[i__4].i + z__2.i * zx[i__4].r;
	    zx[i__3].r = z__1.r, zx[i__3].i = z__1.i;
	}
    }
    return;
} /* zdscal_ */

