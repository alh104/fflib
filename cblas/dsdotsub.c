/* fortran/dsdotsub.f -- translated by f2c (version 20100827).
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

/*     dsdotsub.f */

/*     The program is a fortran wrapper for dsdot. */
/*     Witten by Keita Teranishi.  2/11/1998 */

/* Subroutine */ int dsdotsub_(integer *n, real *x, integer *incx, real *y, 
	integer *incy, doublereal *dot)
{
    extern doublereal dsdot_(integer *, real *, integer *, real *, integer *);



    /* Parameter adjustments */
    --y;
    --x;

    /* Function Body */
    *dot = dsdot_(n, &x[1], incx, &y[1], incy);
    return 0;
} /* dsdotsub_ */

