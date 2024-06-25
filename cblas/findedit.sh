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
# _TODO_ [[file:::25]]
# [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive nil) (org-toggle-link-display))][hide links]] [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive t) (org-toggle-link-display))][show links]] [[elisp:(alh-1dex-open)][open 1dex]] [[elisp:(alh-1dex-update)][update 1dex]]
#
# [[elisp:(alh-set-keywords)][set keywords]] ([[file:~/alh/bin/headeralh][headeralh]])
# emacs-keywords brief="remove most Fortran string lengths from f2c output" shell start=29/12/21 update=21/06/24

for f in fortran/*.f
do
    ../f2c/f2c -E $f
done

# "#define ADD_" will always be required because of f2c compilation.  Change made directly in [[file:upstream/cblas_f77.h]]
# (uses [[file:~/alh/bin/findedit]] ALHTODO 21/06/24 publish findedit)

cp upstream/cblas_f77.h .
findedit -f 'cblas_f77\.h' -nodive -op 's/#ifdef CRAY/#define ADD_\n#ifdef CRAY/'

# Local Variables:
# eval:(visual-line-mode t)
# mode:shell-script
# coding:utf-8
# eval:(flyspell-prog-mode)
# eval:(outline-minor-mode)
# eval:(org-link-minor-mode)
# End:
# LocalWords: emacs
