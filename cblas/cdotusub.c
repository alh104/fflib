/* fortran/cdotusub.f -- translated by f2c (version 20100827).
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

/*     cdotusub.f */

/*     The program is a fortran wrapper for cdotu. */
/*     Witten by Keita Teranishi.  2/11/1998 */

/* Subroutine */ int cdotusub_(integer *n, complex *x, integer *incx, complex 
	*y, integer *incy, complex *dotu)
{
    /* System generated locals */
    complex q__1;

    /* Local variables */
    extern /* Complex */ VOID cdotu_(complex *, integer *, complex *, integer 
	    *, complex *, integer *);



    /* Parameter adjustments */
    --y;
    --x;

    /* Function Body */
    cdotu_(&q__1, n, &x[1], incx, &y[1], incy);
    dotu->r = q__1.r, dotu->i = q__1.i;
    return 0;
} /* cdotusub_ */

