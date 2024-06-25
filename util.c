/* 
 * ~/ffalh/fflib/util.c
 * ====================
 * 
 * 
 *  ______ ______   _      _____ ____                         
 * |  ____|  ____| | |    |_   _|  _ \          _   _ _       
 * | |__  | |__    | |      | | | |_) |   _   _| |_(_) |  ___ 
 * |  __| |  __|   | |      | | |  _ <   | | | | __| | | / __|
 * | |    | |      | |____ _| |_| |_) |  | |_| | |_| | || (__ 
 * |_|    |_|      |______|_____|____/    \__,_|\__|_|_(_)___|
 *                                                            
 *                                                            
 * 
 * Written by Antoine Le Hyaric ([[http://www.ljll.fr/lehyaric]])
 * 
 * Sorbonne Université, CNRS, Laboratoire Jacques-Louis Lions, F-75005, Paris, France
 * 
 * ----------------------------
 * This file is part of FreeFEM
 * ----------------------------
 * FreeFEM is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
 * FreeFEM is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.
 * You should have received a copy of the GNU Lesser General Public License along with FreeFEM; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
 * 
 * [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive nil) (org-toggle-link-display))][hide links]] [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive t) (org-toggle-link-display))][show links]] [[elisp:(alh-1dex-open)][open 1dex]] [[elisp:(alh-1dex-update)][update 1dex]]
 * [[elisp:(alh-set-keywords)][set keywords]] ([[file:~/alh/bin/headeralh][headeralh]])
 * emacs-keywords c freefem start=27/12/2021 univ update=21/06/24 written
 */

/* ARPACK common block declarations for LAPACK that f2c can only create as extern or not extern everywhere (which emcc sees as duplicate
   definitions) */

#include "f2c.h"

struct {
    integer logfil, ndigit, mgetv0, msaupd, msaup2, msaitr, mseigt, msapps, 
	    msgets, mseupd, mnaupd, mnaup2, mnaitr, mneigh, mnapps, mngets, 
	    mneupd, mcaupd, mcaup2, mcaitr, mceigh, mcapps, mcgets, mceupd;
} debug_;

struct {
    integer nopx, nbx, nrorth, nitref, nrstrt;
    real tsaupd, tsaup2, tsaitr, tseigt, tsgets, tsapps, tsconv, tnaupd, 
	    tnaup2, tnaitr, tneigh, tngets, tnapps, tnconv, tcaupd, tcaup2, 
	    tcaitr, tceigh, tcgets, tcapps, tcconv, tmvopx, tmvbx, tgetv0, 
	    titref, trvec;
} timing_;

/* 
 * Local Variables:
 * mode:c
 * c-basic-offset:2
 * eval:(visual-line-mode t)
 * coding:utf-8
 * eval:(flyspell-prog-mode)
 * eval:(outline-minor-mode)
 * eval:(org-link-minor-mode)
 * End:
 */
/* LocalWords: emacs
 */
