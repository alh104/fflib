/* fortran/slapy3.f -- translated by f2c (version 20100827).
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

doublereal slapy3_(real *x, real *y, real *z__)
{
    /* System generated locals */
    real ret_val, r__1, r__2, r__3;

    /* Builtin functions */
    double sqrt(doublereal);

    /* Local variables */
    static real w, xabs, yabs, zabs;


/*  -- LAPACK auxiliary routine (version 2.0) -- */
/*     Univ. of Tennessee, Univ. of California Berkeley, NAG Ltd., */
/*     Courant Institute, Argonne National Lab, and Rice University */
/*     October 31, 1992 */

/*     .. Scalar Arguments .. */
/*     .. */

/*  Purpose */
/*  ======= */

/*  SLAPY3 returns sqrt(x**2+y**2+z**2), taking care not to cause */
/*  unnecessary overflow. */

/*  Arguments */
/*  ========= */

/*  X       (input) REAL */
/*  Y       (input) REAL */
/*  Z       (input) REAL */
/*          X, Y and Z specify the values x, y and z. */

/*  ===================================================================== */

/*     .. Parameters .. */
/*     .. */
/*     .. Local Scalars .. */
/*     .. */
/*     .. Intrinsic Functions .. */
/*     .. */
/*     .. Executable Statements .. */

    xabs = dabs(*x);
    yabs = dabs(*y);
    zabs = dabs(*z__);
/* Computing MAX */
    r__1 = max(xabs,yabs);
    w = dmax(r__1,zabs);
    if (w == 0.f) {
	ret_val = 0.f;
    } else {
/* Computing 2nd power */
	r__1 = xabs / w;
/* Computing 2nd power */
	r__2 = yabs / w;
/* Computing 2nd power */
	r__3 = zabs / w;
	ret_val = w * sqrt(r__1 * r__1 + r__2 * r__2 + r__3 * r__3);
    }
    return ret_val;

/*     End of SLAPY3 */

} /* slapy3_ */

