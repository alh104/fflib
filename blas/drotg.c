/* fortran/drotg.f -- translated by f2c (version 20100827).
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

static doublereal c_b2 = 1.;

/* Subroutine */ void drotg_(doublereal *da, doublereal *db, doublereal *c__, 
	doublereal *s)
{
    /* System generated locals */
    doublereal d__1, d__2;

    /* Builtin functions */
    double sqrt(doublereal), d_sign(doublereal *, doublereal *);

    /* Local variables */
    static doublereal r__, z__, roe, scale;

/*     .. Scalar Arguments .. */
/*     .. */

/*  Purpose */
/*  ======= */

/*     DROTG construct givens plane rotation. */

/*  Further Details */
/*  =============== */

/*     jack dongarra, linpack, 3/11/78. */

/*  ===================================================================== */

/*     .. Local Scalars .. */
/*     .. */
/*     .. Intrinsic Functions .. */
/*     .. */
    roe = *db;
    if (abs(*da) > abs(*db)) {
	roe = *da;
    }
    scale = abs(*da) + abs(*db);
    if (scale == 0.) {
	*c__ = 1.;
	*s = 0.;
	r__ = 0.;
	z__ = 0.;
    } else {
/* Computing 2nd power */
	d__1 = *da / scale;
/* Computing 2nd power */
	d__2 = *db / scale;
	r__ = scale * sqrt(d__1 * d__1 + d__2 * d__2);
	r__ = d_sign(&c_b2, &roe) * r__;
	*c__ = *da / r__;
	*s = *db / r__;
	z__ = 1.;
	if (abs(*da) > abs(*db)) {
	    z__ = *s;
	}
	if (abs(*db) >= abs(*da) && *c__ != 0.) {
	    z__ = 1. / *c__;
	}
    }
    *da = r__;
    *db = z__;
    return;
} /* drotg_ */

