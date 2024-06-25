# Makefile for f2c based on [[file:makefile.u]]
# =========================================
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
# _links_ [[CC]]
# [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive nil) (org-toggle-link-display))][hide links]] [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive t) (org-toggle-link-display))][show links]] [[elisp:(alh-1dex-open)][open 1dex]] [[elisp:(alh-1dex-update)][update 1dex]]
# 
# [[elisp:(alh-set-keywords)][set keywords]] ([[file:~/alh/bin/headeralh][headeralh]])
# emacs-keywords brief="Makefile for f2c based on [[file:makefile.u]]" freefem make start=15/07/15 univ update=27/05/24 written

.SUFFIXES: .c .o

# <<CC>> always force the use of the native compiler because we need to run f2c locally

override CC = cc
override CFLAGS = -O
override LDFLAGS = -O

.c.o:
	$(CC) -c $(CFLAGS) $*.c

OBJECTS = main.o init.o gram.o lex.o proc.o equiv.o data.o format.o expr.o exec.o intr.o io.o misc.o error.o mem.o names.o output.o	\
	  p1output.o pread.o put.o putpcc.o vax.o formatdata.o parse_args.o niceprintf.o cds.o sysdep.o version.o

all:f2c
f2c: $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o f2c

$(OBJECTS): defs.h ftypes.h defines.h machdefs.h sysdep.h

cds.o: sysdep.h
exec.o: p1defs.h names.h
expr.o: output.h niceprintf.h names.h
format.o: p1defs.h format.h output.h niceprintf.h names.h iob.h
formatdata.o: format.h output.h niceprintf.h names.h
gram.o: p1defs.h
init.o: output.h niceprintf.h iob.h
intr.o: names.h
io.o: names.h iob.h
lex.o : tokdefs.h p1defs.h
main.o: parse.h usignal.h
mem.o: iob.h
names.o: iob.h names.h output.h niceprintf.h
niceprintf.o: defs.h names.h output.h niceprintf.h
output.o: output.h niceprintf.h names.h
p1output.o: p1defs.h output.h niceprintf.h names.h
parse_args.o: parse.h
proc.o: tokdefs.h names.h niceprintf.h output.h p1defs.h
put.o: names.h pccdefs.h p1defs.h
putpcc.o: names.h
vax.o: defs.h output.h pccdefs.h
output.h: niceprintf.h
sysdep.o: sysdep.c sysdep.hd

put.o putpcc.o: pccdefs.h

sysdep.hd:
	if $(CC) sysdeptest.c; then echo '/*OK*/' > sysdep.hd;\
	elif $(CC) -DNO_MKDTEMP sysdeptest.c; then echo '#define NO_MKDTEMP' >sysdep.hd;\
	else echo '#define NO_MKDTEMP' >sysdep.hd; echo '#define NO_MKSTEMP' >>sysdep.hd; fi
	rm -f a.out a.exe

clean:
	rm -f *.o f2c f2c.exe sysdep.hd

# Local Variables:
# mode:makefile
# coding:utf-8
# eval:(flyspell-prog-mode)
# eval:(outline-minor-mode)
# eval:(org-link-minor-mode)
# End:
# LocalWords: headeralh
