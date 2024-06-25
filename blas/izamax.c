/* fortran/izamax.f -- translated by f2c (version 20100827).
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

integer izamax_(integer *n, doublecomplex *zx, integer *incx)
{
    /* System generated locals */
    integer ret_val, i__1;

    /* Local variables */
    static integer i__, ix;
    static doublereal dmax__;
    extern doublereal dcabs1_(doublecomplex *);

/*     .. Scalar Arguments .. */
/*     .. */
/*     .. Array Arguments .. */
/*     .. */

/*  Purpose */
/*  ======= */

/*     IZAMAX finds the index of element having max. absolute value. */

/*  Further Details */
/*  =============== */

/*     jack dongarra, 1/15/85. */
/*     modified 3/93 to return if incx .le. 0. */
/*     modified 12/3/93, array(1) declarations changed to array(*) */

/*  ===================================================================== */

/*     .. Local Scalars .. */
/*     .. */
/*     .. External Functions .. */
/*     .. */
    /* Parameter adjustments */
    --zx;

    /* Function Body */
    ret_val = 0;
    if (*n < 1 || *incx <= 0) {
	return ret_val;
    }
    ret_val = 1;
    if (*n == 1) {
	return ret_val;
    }
    if (*incx == 1) {

/*        code for increment equal to 1 */

	dmax__ = dcabs1_(&zx[1]);
	i__1 = *n;
	for (i__ = 2; i__ <= i__1; ++i__) {
	    if (dcabs1_(&zx[i__]) > dmax__) {
		ret_val = i__;
		dmax__ = dcabs1_(&zx[i__]);
	    }
	}
    } else {

/*        code for increment not equal to 1 */

	ix = 1;
	dmax__ = dcabs1_(&zx[1]);
	ix += *incx;
	i__1 = *n;
	for (i__ = 2; i__ <= i__1; ++i__) {
	    if (dcabs1_(&zx[ix]) > dmax__) {
		ret_val = i__;
		dmax__ = dcabs1_(&zx[ix]);
	    }
	    ix += *incx;
	}
    }
    return ret_val;
} /* izamax_ */

