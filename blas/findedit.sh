#!/bin/bash
# remove most Fortran string lengths from f2c output
# ==================================================
# 
#
#  ______ ______   _      _____ ____                                                    
# |  ____|  ____| | |    |_   _|  _ \     __ _           _          _ _ _         _     
# | |__  | |__    | |      | | | |_) |   / _(_)_ __   __| | ___  __| (_) |_   ___| |__  
# |  __| |  __|   | |      | | |  _ <   | |_| | '_ \ / _` |/ _ \/ _` | | __| / __| '_ \ 
# | |    | |      | |____ _| |_| |_) |  |  _| | | | | (_| |  __/ (_| | | |_ _\__ \ | | |
# |_|    |_|      |______|_____|____/   |_| |_|_| |_|\__,_|\___|\__,_|_|\__(_)___/_| |_|
#                                                                                       
#                                                                                       
#
# [[http://www.ljll.fr/lehyaric][Antoine Le Hyaric]]
#
# [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive nil) (org-toggle-link-display))][hide links]] [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive t) (org-toggle-link-display))][show links]] [[elisp:(alh-1dex-open)][open 1dex]] [[elisp:(alh-1dex-update)][update 1dex]]
# [[elisp:(alh-set-keywords)][set keywords]] ([[file:~/alh/bin/headeralh][headeralh]])
# emacs-keywords brief="remove most Fortran string lengths from f2c output" shell start=29/12/21 update=20/06/24

for f in fortran/*.f
do
    ../f2c/f2c -E -P $f
done

# [[file:~/alh/bin/findedit]]
findedit -f '\.c$' -nodive -c '/\* Subroutine \*/ int' -op 's/return 0;/return;/g'
findedit -f '\.c$' -nodive -op 's/\/\* Subroutine \*\/ int/\/\* Subroutine \*\/ void/g'
findedit -f '\.c$' -nf xerbla -nodive -op 's/,\h*(\n\h+)?ftnlen((\h*\n)?\h+[a-z]+_len)?//g'
findedit -f '\.c$' -nf xerbla -nodive -op 's/, \((\n\h+)?ftnlen\)(\h*\n\h+)?[16]//g'

# Many BLAS interfaces do not have a string length argument for xerbla, so we replace it with the value 6, the most common length for a
# BLAS routine name.

findedit -f 'xerbla\.c$' -nodive -op 's/, ftnlen srname_len//'
findedit -f 'xerbla\.c$' -nodive -op 's/srname_len/6/g'
findedit -f 'xerbla\.c$' -nodive -op 's/\/\* Subroutine \*\/ void s_stop/\/\* Subroutine \*\/ int s_stop/g'

# Create header file from all the .P files

echo '#include "f2c.h"' > blas.h

echo '#ifdef cplusplus__' >> blas.h
echo 'extern "C"{' >> blas.h
echo '#endif' >> blas.h

cat *.P >> blas.h

echo '#ifdef cplusplus__' >> blas.h
echo '}' >> blas.h
echo '#endif' >> blas.h

# Local Variables:
# eval:(visual-line-mode t)
# mode:shell-script
# coding:utf-8
# eval:(flyspell-prog-mode)
# eval:(outline-minor-mode)
# eval:(org-link-minor-mode)
# End:
# LocalWords: emacs
