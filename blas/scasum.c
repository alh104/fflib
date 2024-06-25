/* fortran/scasum.f -- translated by f2c (version 20100827).
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

doublereal scasum_(integer *n, complex *cx, integer *incx)
{
    /* System generated locals */
    integer i__1, i__2, i__3;
    real ret_val, r__1, r__2;

    /* Builtin functions */
    double r_imag(complex *);

    /* Local variables */
    static integer i__, nincx;
    static real stemp;

/*     .. Scalar Arguments .. */
/*     .. */
/*     .. Array Arguments .. */
/*     .. */

/*  Purpose */
/*  ======= */

/*     SCASUM takes the sum of the absolute values of a complex vector and */
/*     returns a single precision result. */

/*  Further Details */
/*  =============== */

/*     jack dongarra, linpack, 3/11/78. */
/*     modified 3/93 to return if incx .le. 0. */
/*     modified 12/3/93, array(1) declarations changed to array(*) */

/*  ===================================================================== */

/*     .. Local Scalars .. */
/*     .. */
/*     .. Intrinsic Functions .. */
/*     .. */
    /* Parameter adjustments */
    --cx;

    /* Function Body */
    ret_val = 0.f;
    stemp = 0.f;
    if (*n <= 0 || *incx <= 0) {
	return ret_val;
    }
    if (*incx == 1) {

/*        code for increment equal to 1 */

	i__1 = *n;
	for (i__ = 1; i__ <= i__1; ++i__) {
	    i__2 = i__;
	    stemp = stemp + (r__1 = cx[i__2].r, dabs(r__1)) + (r__2 = r_imag(&
		    cx[i__]), dabs(r__2));
	}
    } else {

/*        code for increment not equal to 1 */

	nincx = *n * *incx;
	i__1 = nincx;
	i__2 = *incx;
	for (i__ = 1; i__2 < 0 ? i__ >= i__1 : i__ <= i__1; i__ += i__2) {
	    i__3 = i__;
	    stemp = stemp + (r__1 = cx[i__3].r, dabs(r__1)) + (r__2 = r_imag(&
		    cx[i__]), dabs(r__2));
	}
    }
    ret_val = stemp;
    return ret_val;
} /* scasum_ */

