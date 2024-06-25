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
# emacs-keywords brief="remove most Fortran string lengths from f2c output" shell start=29/12/21 update=21/06/24

for f in src/*.f util/*.f
do
    ../f2c/f2c -E $f
done

# [[file:~/alh/bin/findedit]]
findedit -f '\.c$' -nodive -c '^/\* Subroutine \*/ int' -m -op 's/return 0;/return;/g'
findedit -f '\.c$' -nodive -op 's/\/\* Subroutine \*\/ int/\/\* Subroutine \*\/ void/g'

findedit -f '[cdsz][ns]aupd\.c$' -nodive -op 's/(do_fio.*?);/uc($1).";"/eg'
findedit -f '[cdisz][mv]out\.c$' -nodive -op 's/(do_fio.*?\)[;,])/uc($1)/egs'
findedit -f '[cdisz][mv]out\.c$' -nodive -op 's/(i_len.*?\)[;,])/uc($1)/egs'
findedit -f '\.c$' -nodive -op 's/(s_copy\(([^()]+?|\(.*?\))+\))/uc($1)/egs'
findedit -f '\.c$' -nodive -op 's/(s_cmp\(([^()]+?|\(.*?\))+\))/uc($1)/egs'

# ??out() functions need complex string formats, so we need to keep the string parameters
findedit -f '\.c$' -nodive -op 's/([cdisz][mv]out_.*?\)[;,\n])/uc($1)/egs'

findedit -f '\.c$' -nodive -op 's/,\h*(\n\h+)?ftnlen((\h*\n)?\h+[a-z]+_len)?//g'
findedit -f '\.c$' -nodive -op 's/,\h*(\n\h*)?\((\h*\n\h*)?ftnlen\)(\h*\n\h*)?[0-9]+//g'
findedit -f '\.c$' -nodive -op 's/, ftnlen//g'

findedit -f '[cdsz][ns]aupd\.c$' -nodive -op 's/(DO_FIO.*?);/lc($1).";"/eg'
findedit -f '[cdisz][mv]out\.c$' -nodive -op 's/(DO_FIO.*?\)[;,])/lc($1)/egs'
findedit -f '[cdisz][mv]out\.c$' -nodive -op 's/(I_LEN.*?\)[;,])/lc($1)/egs'
findedit -f '\.c$' -nodive -op 's/([CDISZ][MV]OUT_.*?\)[;,\n])/lc($1)/egs'
findedit -f '\.c$' -nodive -op 's/(S_COPY\(([^()]+?|\(.*?\))+\))/lc($1)/egs'
findedit -f '\.c$' -nodive -op 's/(S_CMP\(([^()]+?|\(.*?\))+\))/lc($1)/egs'

# Local Variables:
# eval:(visual-line-mode t)
# mode:shell-script
# coding:utf-8
# eval:(flyspell-prog-mode)
# eval:(outline-minor-mode)
# eval:(org-link-minor-mode)
# End:
# LocalWords: emacs
