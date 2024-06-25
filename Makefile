# Compiling FF dependencies into one single lib
# =============================================
# 
# 
banner::
	"   ______ ______   _      _____ ____                                          "
	"  |  ____|  ____| | |    |_   _|  _ \    __  __       _         __ _ _        "
	"  | |__  | |__    | |      | | | |_) |  |  \/  | __ _| | _____ / _(_) | ___   "
	"  |  __| |  __|   | |      | | |  _ <   | |\/| |/ _` | |/ / _ \ |_| | |/ _ \  "
	"  | |    | |      | |____ _| |_| |_) |  | |  | | (_| |   <  __/  _| | |  __/  "
	"  |_|    |_|      |______|_____|____/   |_|  |_|\__,_|_|\_\___|_| |_|_|\___|  "
	"                                                                              "
	"                                                                              "
# 
# Written by Antoine Le Hyaric ([[http://www.ljll.fr/lehyaric]])
# 
# Sorbonne Université, CNRS, Laboratoire Jacques-Louis Lions, F-75005, Paris, France
# 
# ----------------------------
# This file is part of FreeFEM
# ----------------------------
# FreeFEM is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as
# published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
# FreeFEM is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.
# You should have received a copy of the GNU Lesser General Public License along with FreeFEM; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
# 
# _references_ [[ARPACK]] [[BLAS]] [[CBLAS]] [[f2c]] [[f2clib]] [[fflib]] [[LAPACK]] [[tetgen]] [[UMFPACK]]
# _links_ [[binary]] [[BINGOAL]] [[BINTAG]] [[libfflib.a]] [[lndiralh]]
# _TODO_ [[file:::237]] [[file:::244]]
# [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive nil) (org-toggle-link-display))][hide links]] [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive t) (org-toggle-link-display))][show links]] [[elisp:(alh-1dex-open)][open 1dex]] [[elisp:(alh-1dex-update)][update 1dex]]
# 
# [[elisp:(alh-set-keywords)][set keywords]] ([[file:~/alh/bin/headeralh][headeralh]])
# emacs-keywords banner brief="Compiling FF dependencies into one single lib" freefem make start=21/02/2015 univ update=25/06/24 written

all:libfflib.a

# The following macros may be changed, and also CC, CXX.  CFLAGS is overwritten by default when called by autoconf, but not FFLIB_CFLAGS

# -DUSE_CLOCK required for f2clib on mingw64

CFLAGS=-O3
FFLIB_CFLAGS=-DUSE_CLOCK -If2c

CXXFLAGS=-O3
FFLIB_CXXFLAGS=-DUSE_CLOCK -If2c

LDFLAGS=

# default value (gmake does not define this in linux)

RANLIB=ranlib

# remove all built-in rules (eg to avoid calling the default Fortran rules that f2c does not understand because of "-c")
.SUFFIXES:

# ====================================== <<f2c>>= [[file:../1dex.org::f2c][(i)]] (obtained from [[http://www.netlib.org/f2c]])

# We make sure that we have a working version of f2c that is compatible with [[libf2c]], but we keep all generated source files because many of
# them are modified by hand.

# Use a specific makefile and compiler to produce a native version of f2c with [[file:f2c/Makefile]]
f2c/f2c:
	cd f2c && $(MAKE) f2c
	touch $@

clean::
	-cd f2c && $(MAKE) clean

# [[man:f2c]]

FFLIBDIR?=$(shell pwd)

# This procedure is usually replaced with one single source conversion from .f to .c with [[file:blas/findedit.sh]]
#
# add -g to have links back to the fortran source when debugging [[file:f2c/f2c.1::-g]]
# add -E to create all commons as extern (to avoid duplicate definitions of symbols in emcc) and then instanciate symbol in [[file:util.c]]
# add -P to extract function prototypes and generate [[f2c_blas.h]]

%.c:%.f
	$(FFLIBDIR)/f2c/f2c -E -P -g $<
%.o:%.c
	$(CC) $(CFLAGS) $(FFLIB_CFLAGS) -c $< -o $@
%.o:%.cpp
	$(CXX) $(CXXFLAGS) $(FFLIB_CXXFLAGS) -c $< -o $@
%.o:%.cxx
	$(CXX) $(CXXFLAGS) $(FFLIB_CXXFLAGS) -c $< -o $@

# ====================================== <<f2clib>>= [[file:../1dex.org::f2clib][(i)]] (obtained from [[http://www.netlib.org/f2c/libf2c.zip]])

# recompiling libf2c is required to get a version of all the Fortran-only intrinsic calls that are missing from libc for the target
# architecture.  This library is fairly stable so we don't need to reinstall the whole f2c package (we just use the "f2c" command from the
# standard Debian package).  list or sources obtained from value of $(OFILES) in original libf2c/makefile.u, then main.c, signal_.c,
# s_paus.c, uninit.c removed. Please note that util.c has been renamed to f2c_util.c to avoid naming conflicts with other packages.

VPATH += libf2c
F2CSRC = f77vers.c i77vers.c s_rnge.c abort_.c exit_.c getarg_.c iargc_.c getenv_.c s_stop.c system_.c cabs.c ctype.c derf_.c derfc_.c	    \
	erf_.c erfc_.c sig_die.c pow_ci.c pow_dd.c pow_di.c pow_hh.c pow_ii.c pow_ri.c pow_zi.c pow_zz.c c_abs.c c_cos.c c_div.c c_exp.c    \
	c_log.c c_sin.c c_sqrt.c z_abs.c z_cos.c z_div.c z_exp.c z_log.c z_sin.c z_sqrt.c r_abs.c r_acos.c r_asin.c r_atan.c r_atn2.c	    \
	r_cnjg.c r_cos.c r_cosh.c r_dim.c r_exp.c r_imag.c r_int.c r_lg10.c r_log.c r_mod.c r_nint.c r_sign.c r_sin.c r_sinh.c r_sqrt.c	    \
	r_tan.c r_tanh.c d_abs.c d_acos.c d_asin.c d_atan.c d_atn2.c d_cnjg.c d_cos.c d_cosh.c d_dim.c d_exp.c d_imag.c d_int.c d_lg10.c    \
	d_log.c d_mod.c d_nint.c d_prod.c d_sign.c d_sin.c d_sinh.c d_sqrt.c d_tan.c d_tanh.c i_abs.c i_dim.c i_dnnt.c i_indx.c i_len.c	    \
	i_mod.c i_nint.c i_sign.c lbitbits.c lbitshft.c h_abs.c h_dim.c h_dnnt.c h_indx.c h_len.c h_mod.c h_nint.c h_sign.c l_ge.c l_gt.c   \
	l_le.c l_lt.c hl_ge.c hl_gt.c hl_le.c hl_lt.c ef1asc_.c ef1cmc_.c f77_aloc.c s_cat.c s_cmp.c s_copy.c backspac.c close.c dfe.c	    \
	dolio.c due.c endfile.c err.c fmt.c fmtlib.c ftell_.c iio.c ilnw.c inquire.c lread.c lwrite.c open.c rdfmt.c rewind.c rsfe.c rsli.c \
	rsne.c sfe.c sue.c typesize.c uio.c wref.c wrtfmt.c wsfe.c wsle.c wsne.c xwsne.c dtime_.c etime_.c f2c_util.c
ALLOBJ += $(F2CSRC:.c=.o)
libf2c.ok:$(F2CSRC:.c=.o)
	touch $@
clean::
	-rm libf2c.ok

# ====================================== <<BLAS>>= [[file:../1dex.org::BLAS][(i)]]

# Some f2c output C files are modified manually to make sure that xerbla_() et s_copy() have coherent declarations for emcc via
# [[file:blas/findedit.sh]]

VPATH += blas
BLASSRC = caxpy.f ccopy.f cdotc.f cdotu.f cgbmv.f cgemm.f cgemv.f cgerc.f cgeru.f chbmv.f chemm.f chemv.f cher2.f cher2k.f cher.f cherk.f \
	chpmv.f chpr2.f chpr.f crotg.f cscal.f csrot.f csscal.f cswap.f csymm.f csyr2k.f csyrk.f ctbmv.f ctbsv.f ctpmv.f ctpsv.f ctrmm.f  \
	ctrmv.f ctrsm.f ctrsv.f dasum.f daxpy.f dcabs1.f dcopy.f ddot.f dgbmv.f dgemm.f dgemv.f dger.f dnrm2.f drot.f drotg.f drotm.f	  \
	drotmg.f dsbmv.f dscal.f dsdot.f dspmv.f dspr2.f dspr.f dswap.f dsymm.f dsymv.f dsyr2.f dsyr2k.f dsyr.f dsyrk.f dtbmv.f dtbsv.f	  \
	dtpmv.f dtpsv.f dtrmm.f dtrmv.f dtrsm.f dtrsv.f dzasum.f dznrm2.f icamax.f idamax.f isamax.f izamax.f lsame.f sasum.f saxpy.f	  \
	scabs1.f scasum.f scnrm2.f scopy.f sdot.f sdsdot.f sgbmv.f sgemm.f sgemv.f sger.f snrm2.f srot.f srotg.f srotm.f srotmg.f ssbmv.f \
	sscal.f sspmv.f sspr2.f sspr.f sswap.f ssymm.f ssymv.f ssyr2.f ssyr2k.f ssyr.f ssyrk.f stbmv.f stbsv.f stpmv.f stpsv.f strmm.f	  \
	strmv.f strsm.f strsv.f xerbla.f zaxpy.f zcopy.f zdotc.f zdotu.f zdrot.f zdscal.f zgbmv.f zgemm.f zgemv.f zgerc.f zgeru.f zhbmv.f \
	zhemm.f zhemv.f zher2.f zher2k.f zher.f zherk.f zhpmv.f zhpr2.f zhpr.f zrotg.f zscal.f zswap.f zsymm.f zsyr2k.f zsyrk.f ztbmv.f	  \
	ztbsv.f ztpmv.f ztpsv.f ztrmm.f ztrmv.f ztrsm.f ztrsv.f
ALLOBJ += $(BLASSRC:.f=.o)
blas.ok:$(BLASSRC:.f=.o)
	cp blas/blas.h .
	cp f2c/f2c.h .
	touch $@

# keep blas/*.c to avoid regenerating it every time

clean::
	-rm blas.ok
	-rm blas/*.P

# ====================================== <<CBLAS>>= [[file:../1dex.org::CBLAS][(i)]]

# CBLAS is not used in ffkernel but it is useful for other C++ programs like [[ffile:../ffapi/regcpp.cpp]] because calling the fortran BLAS
# drectly does not always work (eg the 'real' type creates a conflict between f2c.h and the C++ standard library).

VPATH += cblas

CBLASCSRC=cblas_caxpy.c cblas_cscal.c cblas_dgemm.c cblas_dsyr.c cblas_scasum.c cblas_sswap.c cblas_zdotu_sub.c cblas_zsymm.c cblas_ccopy.c \
	cblas_csscal.c cblas_dgemv.c cblas_dsyrk.c cblas_scnrm2.c cblas_ssymm.c cblas_zdscal.c cblas_zsyr2k.c cblas_cdotc_sub.c		    \
	cblas_cswap.c cblas_dger.c cblas_dtbmv.c cblas_scopy.c cblas_ssymv.c cblas_zgbmv.c cblas_zsyrk.c cblas_cdotu_sub.c cblas_csymm.c    \
	cblas_dnrm2.c cblas_dtbsv.c cblas_sdot.c cblas_ssyr2.c cblas_zgemm.c cblas_ztbmv.c cblas_cgbmv.c cblas_csyr2k.c cblas_drot.c	    \
	cblas_dtpmv.c cblas_sdsdot.c cblas_ssyr2k.c cblas_zgemv.c cblas_ztbsv.c cblas_cgemm.c cblas_csyrk.c cblas_drotg.c cblas_dtpsv.c	    \
	cblas_sgbmv.c cblas_ssyr.c cblas_zgerc.c cblas_ztpmv.c cblas_cgemv.c cblas_ctbmv.c cblas_drotm.c cblas_dtrmm.c cblas_sgemm.c	    \
	cblas_ssyrk.c cblas_zgeru.c cblas_ztpsv.c cblas_cgerc.c cblas_ctbsv.c cblas_drotmg.c cblas_dtrmv.c cblas_sgemv.c cblas_stbmv.c	    \
	cblas_zhbmv.c cblas_ztrmm.c cblas_cgeru.c cblas_ctpmv.c cblas_dsbmv.c cblas_dtrsm.c cblas_sger.c cblas_stbsv.c cblas_zhemm.c	    \
	cblas_ztrmv.c cblas_chbmv.c cblas_ctpsv.c cblas_dscal.c cblas_dtrsv.c cblas_snrm2.c cblas_stpmv.c cblas_zhemv.c cblas_ztrsm.c	    \
	cblas_chemm.c cblas_ctrmm.c cblas_dsdot.c cblas_dzasum.c cblas_srot.c cblas_stpsv.c cblas_zher2.c cblas_ztrsv.c cblas_chemv.c	    \
	cblas_ctrmv.c cblas_dspmv.c cblas_dznrm2.c cblas_srotg.c cblas_strmm.c cblas_zher2k.c xerbla.c cblas_cher2.c cblas_ctrsm.c	    \
	cblas_dspr2.c cblas_globals.c cblas_srotm.c cblas_strmv.c cblas_zher.c cblas_cher2k.c cblas_ctrsv.c cblas_dspr.c cblas_icamax.c	    \
	cblas_srotmg.c cblas_strsm.c cblas_zherk.c cblas_cher.c cblas_dasum.c cblas_dswap.c cblas_idamax.c cblas_ssbmv.c cblas_strsv.c	    \
	cblas_zhpmv.c cblas_cherk.c cblas_daxpy.c cblas_dsymm.c cblas_isamax.c cblas_sscal.c cblas_xerbla.c cblas_zhpr2.c cblas_chpmv.c	    \
	cblas_dcopy.c cblas_dsymv.c cblas_izamax.c cblas_sspmv.c cblas_zaxpy.c cblas_zhpr.c cblas_chpr2.c cblas_ddot.c cblas_dsyr2.c	    \
	cblas_sasum.c cblas_sspr2.c cblas_zcopy.c cblas_zscal.c cblas_chpr.c cblas_dgbmv.c cblas_dsyr2k.c cblas_saxpy.c cblas_sspr.c	    \
	cblas_zdotc_sub.c cblas_zswap.c

CBLASFSRC=cdotcsub.f dasumsub.f dnrm2sub.f dzasumsub.f icamaxsub.f isamaxsub.f sasumsub.f scnrm2sub.f sdsdotsub.f zdotcsub.f cdotusub.f	\
	ddotsub.f dsdotsub.f dznrm2sub.f idamaxsub.f izamaxsub.f scasumsub.f sdotsub.f snrm2sub.f zdotusub.f

ALLOBJ += $(CBLASCSRC:.c=.o)
ALLOBJ += $(CBLASFSRC:.f=.o)
cblas.ok:$(CBLASCSRC:.c=.o) $(CBLASFSRC:.f=.o)
	cp cblas/cblas.h .
	cp cblas/cblas_f77.h .
	touch $@

clean::
	-rm cblas.ok

# ====================================== <<LAPACK>>= [[file:../1dex.org::LAPACK][(i)]]

VPATH += lapack

# Not all the LAPACK subroutines are included, only those that are required to link the final executable successfully.  And some are even
# duplicated from the [[BLAS]] (eg xerbla, lsame).

LAPACKSRC = cgbtf2.f cgbtrf.f cgbtrs.f cgeqr2.f cgttrf.f cgttrs.f clacgv.f clacon.f clacpy.f cladiv.f clahqr.f clange.f clanhs.f clarf.f    \
	clarfg.f clarnv.f clartg.f clascl.f claset.f classq.f claswp.f clatrs.f cmach.f crot.f ctrevc.f ctrexc.f ctrsen.f ctrsyl.f cunm2r.f \
	dgbtf2.f dgbtrf.f dgbtrs.f dgeqr2.f dgttrf.f dgttrs.f dlabad.f dlacon.f dlacpy.f dladiv.f dlae2.f dlaev2.f dlaexc.f dlagtm.f	    \
	dlahqr.f dlaln2.f dlamch.f dlange.f dlanhs.f dlanst.f dlanv2.f dlaptm.f dlapy2.f dlapy3.f dlaran.f dlarf.f dlarfg.f dlarfx.f	    \
	dlarnd.f dlarnv.f dlartg.f dlaruv.f dlascl.f dlaset.f dlasr.f dlasrt.f dlassq.f dlaswp.f dlasy2.f dorm2r.f dpttrf.f dpttrs.f	    \
	dsteqr.f dtrevc.f dtrexc.f dtrsen.f dtrsyl.f dzsum1.f icmax1.f ilaenv.f izmax1.f scsum1.f sgbtf2.f sgbtrf.f sgbtrs.f sgeqr2.f	    \
	sgttrf.f sgttrs.f slabad.f slacon.f slacpy.f sladiv.f slae2.f slaev2.f slaexc.f slagtm.f slahqr.f slaln2.f slamch.f slange.f	    \
	slanhs.f slanst.f slanv2.f slaptm.f slapy2.f slapy3.f slaran.f slarf.f slarfg.f slarfx.f slarnd.f slarnv.f slartg.f slaruv.f	    \
	slascl.f slaset.f slasr.f slasrt.f slassq.f slaswp.f slasy2.f sorm2r.f spttrf.f spttrs.f ssteqr.f strevc.f strexc.f strsen.f	    \
	strsyl.f xlaenv.f zgbtf2.f zgbtrf.f zgbtrs.f zgeqr2.f zgttrf.f zgttrs.f zlacgv.f zlacon.f zlacpy.f zladiv.f zlahqr.f zlange.f	    \
	zlanhs.f zlarf.f zlarfg.f zlarnv.f zlartg.f zlascl.f zlaset.f zlassq.f zlaswp.f zlatrs.f zmach.f zrot.f ztrevc.f ztrexc.f ztrsen.f  \
	ztrsyl.f zunm2r.f dpotrf.f zpotrf.f dpotf2.f zpotf2.f disnan.f dlaisnan.f
ALLOBJ += $(LAPACKSRC:.f=.o)
lapack.ok:$(LAPACKSRC:.f=.o)
	touch $@
clean::
	-rm lapack.ok

# ====================================== <<ARPACK>>= [[file:../1dex.org::ARPACK][(i)]]

VPATH += arpack
ARPACKSRC = cgetv0.f cnaitr.f cnapps.f cnaup2.f cnaupd.f cneigh.f cneupd.f cngets.f csortc.f cstatn.f dgetv0.f dlaqrb.f dnaitr.f dnapps.f \
	dnaup2.f dnaupd.f dnaupe.f dnconv.f dneigh.f dneupd.f dngets.f dsaitr.f dsapps.f dsaup2.f dsaupd.f dsconv.f dseigt.f dsesrt.f	  \
	dseupd.f dsgets.f dsortc.f dsortr.f dstatn.f dstats.f dstqrb.f sgetv0.f slaqrb.f snaitr.f snapps.f snaup2.f snaupd.f snaupe.f	  \
	snconv.f sneigh.f sneupd.f sngets.f ssaitr.f ssapps.f ssaup2.f ssaupd.f ssconv.f sseigt.f ssesrt.f sseupd.f ssgets.f ssortc.f	  \
	ssortr.f sstatn.f sstats.f sstqrb.f zgetv0.f znaitr.f znapps.f znaup2.f znaupd.f zneigh.f zneupd.f zngets.f zsortc.f zstatn.f	  \
	cmout.f cvout.f dmout.f dvout.f icnteq.f icopy.f iset.f iswap.f ivout.f second.f smout.f svout.f zmout.f zvout.f
ALLOBJ += $(ARPACKSRC:.f=.o) util.o
arpack.ok:$(ARPACKSRC:.f=.o) util.o
	touch $@
clean::
	-rm arpack.ok

# ====================================== <<UMFPACK>>= [[file:../1dex.org::UMFPACK][(i)]]

# Download rather than copy in place because some (unused) files in the archive are under GPL licence instead of LGPL, and the directory
# tree is too detailed to copy files from it in a reproductible way.  Download address copied from [[ff:download/getall::SuiteSparse]].  Do not
# put archive in binary directory, it may be difficult to get back if the directory is cleaned up.

SuiteSparse.tar.gz:
	wget --output-document=$@ http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-4.4.4.tar.gz

# use intermediate goal "dir.ok" because directory date is changed every time

SuiteSparse/dir.ok:SuiteSparse.tar.gz
	tar xvzf $<
	touch $@
clean::
	-rm -r SuiteSparse

# --- Same UMFPACK configuration options as [[ff:download/umfpack/SuiteSparse_config.mk.in]].

# list of options copied from [[ff:download/umfpack/SuiteSparse_config.mk.in::UMFPACK_CONFIG]]
# [[ff:download/umfpack/SuiteSparse_config.mk.in::CHOLMOD_CONFIG]]
# [[ff:download/umfpack/SuiteSparse_config.mk.in::SPQR_CONFIG]].  Produces
# [[file:SuiteSparse/SuiteSparse_config/SuiteSparse_config.mk]]

SuiteSparse/SuiteSparse_config/SuiteSparse_config.mk:SuiteSparse/dir.ok Makefile
	echo CC = $(CC) > $@
	echo CFLAGS = -DNTIMERS $(OPTIMFLAGS) >> $@
#
#	ALHTODO alhideas1 08/07/15 check what TARGET_ARCH is for
#
	echo CF = '$$(CFLAGS) $$(CPPFLAGS) $$(TARGET_ARCH)' >> $@
	echo CHOLMOD_CONFIG = -DNPARTITION -DNGPL >> $@
#
#	[[http://matrixprogramming.com/2008/03/umfpack#Compiling]] skip BLAS calls that seem to generate segfaults.

# 	ALHTODO alhideas1 calling the real BLAS will only be useful when we have an optimized version of the BLAS attached to fflib.
#
	echo UMFPACK_CONFIG = -DNBLAS >> $@

# --- SuiteSparse_config (cf SuiteSparse/SuiteSparse_config/Makefile::libsuitesparseconfig.a).  Produces
#     [[file:SuiteSparse/SuiteSparse_config/Makefile_fflib]]

SuiteSparse/SuiteSparse_config/Makefile_fflib:SuiteSparse/dir.ok Makefile
	sed -e 's/\.o/.o/g' SuiteSparse/SuiteSparse_config/Makefile > $@
	echo '%.o:%.c' >> $@
	echo '	$$(CC) $$(CFLAGS) -c $$< -o $$@' >> $@
	echo 'fflib.done:SuiteSparse_config.o' >> $@
	echo '	touch $$@' >> $@

SuiteSparse/SuiteSparse_config/fflib.done:SuiteSparse/SuiteSparse_config/Makefile_fflib	\
	SuiteSparse/SuiteSparse_config/SuiteSparse_config.mk
	cd SuiteSparse/SuiteSparse_config && $(MAKE) -f Makefile_fflib fflib.done

ALLOBJ += SuiteSparse/SuiteSparse_config/*.o

# --- CAMD part [[file:SuiteSparse/CAMD/Lib/GNUmakefile]]

SuiteSparse/CAMD/Lib/GNUmakefile_fflib:SuiteSparse/dir.ok Makefile
	sed -e 's/\.o/.o/g' SuiteSparse/CAMD/Lib/GNUmakefile > $@
	echo 'fflib.done:$$(CAMDI) $$(CAMDL)' >> $@
	echo '	touch $$@' >> $@

SuiteSparse/CAMD/Lib/fflib.done:SuiteSparse/CAMD/Lib/GNUmakefile_fflib
	cd SuiteSparse/CAMD/Lib && $(MAKE) -f GNUmakefile_fflib CC=$(CC) fflib.done

ALLOBJ += SuiteSparse/CAMD/Lib/*.o

# --- AMD part [[file:SuiteSparse/AMD/Lib/GNUmakefile]]

SuiteSparse/AMD/Lib/GNUmakefile_fflib:SuiteSparse/dir.ok Makefile
	sed -e 's/-o amd\.o//' -e 's/-o amdbar\.o//' -e 's/amd\.o/amd\.c/' -e 's/amdbar\.o/amdbar\.c/' \
		-e 's/\.o/.o/g' SuiteSparse/AMD/Lib/GNUmakefile > $@
	echo '%.o:%.c' >> $@
	echo '	$$(CC) $$(CFLAGS) -c $$< -o $$@' >> $@
	echo 'fflib.done:$$(AMDI) $$(AMDL) $$(AMDF77)' >> $@
	echo '	touch $$@' >> $@

SuiteSparse/AMD/Lib/fflib.done:SuiteSparse/AMD/Lib/GNUmakefile_fflib
	cd SuiteSparse/AMD/Lib && $(MAKE) -f GNUmakefile_fflib CC=$(CC) F77=$(F77) fflib.done

ALLOBJ += SuiteSparse/AMD/Lib/*.o

# --- CHOLMOD [[file:SuiteSparse/CHOLMOD/Lib/Makefile]]

SuiteSparse/CHOLMOD/Lib/Makefile_fflib:SuiteSparse/dir.ok Makefile
	sed -e 's/\.o/.o/g' -e 's/\$$<$$/$$< -o $$@/g' SuiteSparse/CHOLMOD/Lib/Makefile > $@
	echo 'fflib.done:$$(OBJ)' >> $@
	echo '	touch $$@' >> $@

SuiteSparse/CHOLMOD/Lib/fflib.done:SuiteSparse/CHOLMOD/Lib/Makefile_fflib
	cd SuiteSparse/CHOLMOD/Lib && $(MAKE) -f Makefile_fflib CC=$(CC) fflib.done

ALLOBJ += SuiteSparse/CHOLMOD/Lib/*.o

# --- CCOLAMD [[file:SuiteSparse/CCOLAMD/Lib/Makefile]]

SuiteSparse/CCOLAMD/Lib/Makefile_fflib:SuiteSparse/dir.ok Makefile
	cp SuiteSparse/CCOLAMD/Lib/Makefile $@
	echo 'fflib.done:' >> $@
	echo '	$$(CC) $$(CF) $$(I) -c ../Source/ccolamd.c -o colamd.o' >> $@
	echo '	$$(CC) $$(CF) $$(I) -c ../Source/ccolamd.c -DDLONG -o colamd_l.o' >> $@
	echo '	touch $$@' >> $@

SuiteSparse/CCOLAMD/Lib/fflib.done:SuiteSparse/CCOLAMD/Lib/Makefile_fflib
	cd SuiteSparse/CCOLAMD/Lib && $(MAKE) -f Makefile_fflib CC=$(CC) fflib.done

ALLOBJ += SuiteSparse/CCOLAMD/Lib/*.o

# --- COLAMD

SuiteSparse/COLAMD/Lib/Makefile_fflib:SuiteSparse/dir.ok Makefile
	cp SuiteSparse/COLAMD/Lib/Makefile $@
	echo 'fflib.done:' >> $@
	echo '	$$(CC) $$(CF) $$(I) -c ../Source/colamd.c -o colamd.o' >> $@
	echo '	$$(CC) $$(CF) $$(I) -c ../Source/colamd.c -DDLONG -o colamd_l.o' >> $@
	echo '	touch $$@' >> $@

SuiteSparse/COLAMD/Lib/fflib.done:SuiteSparse/COLAMD/Lib/Makefile_fflib
	cd SuiteSparse/COLAMD/Lib && $(MAKE) -f Makefile_fflib CC=$(CC) fflib.done

ALLOBJ += SuiteSparse/COLAMD/Lib/*.o

# --- UMFPACK part using modified [[file:SuiteSparse/UMFPACK/Lib/GNUmakefile]]

SuiteSparse/UMFPACK/Lib/GNUmakefile_fflib:SuiteSparse/dir.ok Makefile
	sed -e 's/\.o/.o/g' SuiteSparse/UMFPACK/Lib/GNUmakefile > $@
	echo 'fflib.done:$$(II) $$(LL) $$(GN) $$(DI) $$(DL) $$(ZI) $$(ZL)' >> $@
	echo '	touch $$@' >> $@

SuiteSparse/UMFPACK/Lib/fflib.done:SuiteSparse/UMFPACK/Lib/GNUmakefile_fflib
	cd SuiteSparse/UMFPACK/Lib && $(MAKE) -f GNUmakefile_fflib CC=$(CC) fflib.done

ALLOBJ += SuiteSparse/UMFPACK/Lib/*.o

umfpack.ok:SuiteSparse/SuiteSparse_config/fflib.done SuiteSparse/CAMD/Lib/fflib.done SuiteSparse/CAMD/Lib/fflib.done	\
	SuiteSparse/AMD/Lib/fflib.done SuiteSparse/CAMD/Lib/fflib.done SuiteSparse/CHOLMOD/Lib/fflib.done		\
	SuiteSparse/CCOLAMD/Lib/fflib.done SuiteSparse/COLAMD/Lib/fflib.done SuiteSparse/UMFPACK/Lib/fflib.done
#
#	Copy all headers in the same location for ease of use (list of all headers found with "grep INSTALL_INCLUDE
#	SuiteSparse/*/Makefile|grep CP")
#
	cp SuiteSparse/AMD/Include/amd.h .
	cp SuiteSparse/BTF/Include/btf.h .
	cp SuiteSparse/CAMD/Include/camd.h .
	cp SuiteSparse/CCOLAMD/Include/ccolamd.h .
	cp SuiteSparse/CHOLMOD/Include/cholmod*.h .
	cp SuiteSparse/COLAMD/Include/colamd.h .
	cp SuiteSparse/CXSparse/Include/cs.h .
	cp SuiteSparse/CXSparse_newfiles/Include/cs.h .
	cp SuiteSparse/KLU/Include/klu.h .
	cp SuiteSparse/LDL/Include/ldl.h .
	cp SuiteSparse/RBio/Include/RBio.h .
	cp SuiteSparse/SPQR/Include/SuiteSparseQR.hpp .
	cp SuiteSparse/SPQR/Include/SuiteSparseQR_C.h .
	cp SuiteSparse/SPQR/Include/SuiteSparseQR_definitions.h .
	cp SuiteSparse/SPQR/Include/spqr.hpp .
	cp SuiteSparse/SuiteSparse_config/SuiteSparse_config.h .
	cp SuiteSparse/UMFPACK/Include/*.h .
	touch $@
clean::
	-rm umfpack.ok
	-rm *.h
	-rm *.hpp

# ====================================== <<tetgen>>= [[file:../1dex.org::tetgen][(i)]]

# Use the same version as FF in [[ff:3rdparty/getall::TetGen]]

TETGENVER=tetgen1.5.1-beta1
VPATH += $(TETGENVER)
$(TETGENVER).tar.gz:
	wget --output-document=$@ http://www.tetgen.org/1.5/src/tetgen1.5.1-beta1.tar.gz
#
#	Sometimes the download fails with no error code and an empty file is created
#
	test -s $@

$(TETGENVER).tar:$(TETGENVER).tar.gz
	gzip -d $<
TETGENSRC=predicates.cxx tetgen.cxx
ALLOBJ += $(TETGENSRC:.cxx=.o)
$(TETGENVER)/dir.ok:$(TETGENVER).tar
	tar xvf $(TETGENVER).tar
	touch $@

tetgen.ok:
	$(MAKE) $(TETGENVER)/dir.ok
#
#	Compilation options are a bit tricky so we just issue the compilation commands directly.  Uses the same switches as in
#	[[ff:3rdparty/tetgen/Makefile::FAIT]]
#
	$(CXX) -c $(CFLAGS) -DSELF_CHECK -DNDEBUG -DTETLIBRARY $(TETGENVER)/tetgen.cxx -o tetgen.o
	$(CXX) -c $(CFLAGS) -O0 $(TETGENVER)/predicates.cxx -o predicates.o
#
#	Copy tetgen.h here to simplify path in -I
#
	cp $(TETGENVER)/tetgen.h .
	touch $@

clean::
	-rm tetgen.ok
	-rm tetgen.h
	-rm $(TETGENVER).tar
	-rm -r $(TETGENVER)

# ====================================== <<fflib>>= [[file:../1dex.org::fflib][(i)]]

echo_libobj:
	@echo $(addprefix $(DIR)/,$(ALLOBJ))

# <<libfflib.a>> [[file:../1dex.org::libfflib.a][(i)]] The extra goals are required to make sure that all the libraries which depend on each other are built sequentially.

libfflib.a:
	$(MAKE) f2c/f2c
	$(MAKE) libf2c.ok
#
#	Parallel compiles of independant libraries
#
	$(MAKE) blas.ok cblas.ok
	$(MAKE) lapack.ok arpack.ok umfpack.ok tetgen.ok
#
#	hide long command string (because of $(ALLOBJ))
#
	@echo updating $@...
	@$(AR) ruU $@ $(ALLOBJ)
	$(RANLIB) $@

libobj.mak:
	echo FFLIBOBJ=$(ALLOBJ) >$@

clean::
	-rm $(ALLOBJ)
	-rm libfflib.a
	-rm libobj.mak

# <<lndiralh>> Make sure perl tools are part of the archive

lndiralh:$(HOME)/alh/bin/lndiralh
	perlpack -i $< -o $@

# <<binary>> Creating a separate directory for each build.  <<BINTAG>> and <<BINGOAL>> need to be defined.

BINTAG=default
BINGOAL=all
binary:lndiralh
	./lndiralh -ignore '^bin_.*,.*\.o,.*\.a,\.hg(\/.*)?' -to bin_$(BINTAG)
	cd bin_$(BINTAG) && $(MAKE) $(BINGOAL)

clean::
	-rm -r bin_*

# Local Variables:
# mode:makefile
# coding:utf-8
# eval:(flyspell-prog-mode)
# eval:(outline-minor-mode)
# eval:(org-link-minor-mode)
# End:
# LocalWords: Freefem bitrot ffref
