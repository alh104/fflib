/* fortran/dzasumsub.f -- translated by f2c (version 20100827).
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

/*     dzasumsub.f */

/*     The program is a fortran wrapper for dzasum. */
/*     Witten by Keita Teranishi.  2/11/1998 */

/* Subroutine */ int dzasumsub_(integer *n, doublecomplex *x, integer *incx, 
	doublereal *asum)
{
    extern doublereal dzasum_(integer *, doublecomplex *, integer *);



    /* Parameter adjustments */
    --x;

    /* Function Body */
    *asum = dzasum_(n, &x[1], incx);
    return 0;
} /* dzasumsub_ */

