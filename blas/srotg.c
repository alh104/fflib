/* fortran/srotg.f -- translated by f2c (version 20100827).
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

/* Table of constant values */

static real c_b2 = 1.f;

/* Subroutine */ void srotg_(real *sa, real *sb, real *c__, real *s)
{
    /* System generated locals */
    real r__1, r__2;

    /* Builtin functions */
    double sqrt(doublereal), r_sign(real *, real *);

    /* Local variables */
    static real r__, z__, roe, scale;

/*     .. Scalar Arguments .. */
/*     .. */

/*  Purpose */
/*  ======= */

/*     SROTG construct givens plane rotation. */

/*  Further Details */
/*  =============== */

/*     jack dongarra, linpack, 3/11/78. */

/*  ===================================================================== */

/*     .. Local Scalars .. */
/*     .. */
/*     .. Intrinsic Functions .. */
/*     .. */
    roe = *sb;
    if (dabs(*sa) > dabs(*sb)) {
	roe = *sa;
    }
    scale = dabs(*sa) + dabs(*sb);
    if (scale == 0.f) {
	*c__ = 1.f;
	*s = 0.f;
	r__ = 0.f;
	z__ = 0.f;
    } else {
/* Computing 2nd power */
	r__1 = *sa / scale;
/* Computing 2nd power */
	r__2 = *sb / scale;
	r__ = scale * sqrt(r__1 * r__1 + r__2 * r__2);
	r__ = r_sign(&c_b2, &roe) * r__;
	*c__ = *sa / r__;
	*s = *sb / r__;
	z__ = 1.f;
	if (dabs(*sa) > dabs(*sb)) {
	    z__ = *s;
	}
	if (dabs(*sb) >= dabs(*sa) && *c__ != 0.f) {
	    z__ = 1.f / *c__;
	}
    }
    *sa = r__;
    *sb = z__;
    return;
} /* srotg_ */

