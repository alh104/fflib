#!/bin/bash
# ~/ffalh/ffjs/fflib/blas/findedit.sh
# ===================================
# 
#
#       \|||/                                                        
#       (o o)          __ _           _          _ _ _         _     
# ,-ooO--(_)------,   / _(_)_ __   __| | ___  __| (_) |_   ___| |__  
# |    _________  |  | |_| | '_ \ / _` |/ _ \/ _` | | __| / __| '_ \ 
# |   /  _._   /  |  |  _| | | | | (_| |  __/ (_| | | |_ _\__ \ | | |
# |  /________/   |  |_| |_|_| |_|\__,_|\___|\__,_|_|\__(_)___/_| |_|
# '-----------ooO-'                                                  
#
# [[http://www.ljll.math.upmc.fr/lehyaric][Antoine Le Hyaric]]
#
# [[elisp:(org-toggle-link-display)][show links]]
# [[elisp:(alh-set-keywords)][set keywords]] ([[file:~/alh/bin/headeralh][headeralh]])
# emacs-keywords shell start=29/12/21 brief="remove most Fortran string lengths from f2c output"

for f in fortran/*.f
do
    ../f2c/f2c -E $f
done

# [[file:~/alh/bin/findedit]]
findedit -f '\.c$' -nodive -c '^/\* Subroutine \*/ int' -m -op 's/return 0;/return;/g'
findedit -f '\.c$' -nodive -op 's/\/\* Subroutine \*\/ int/\/\* Subroutine \*\/ void/g'
findedit -f '\.c$' -nodive -op 's/xerbla_\((\h*\n\h*)?char \*,( |\h*\n\h*)?integer( |\h*\n\h*)?\*,( |\h*\n\h*)?ftnlen\)/xerbla_(char *, integer *)/'

findedit -f '[ds]lamch\.c$' -nodive -op 's/(do_fio\(.*ftnlen\))/uc($1)/eg'
findedit -f '\.c$' -nodive -op 's/(s_copy\(([^()]+?|\(.*?\))+\))/setaside($1)/egs'
findedit -f '\.c$' -nodive -op 's/(s_cmp\(([^()]+?|\(.*?\))+\))/setaside($1)/egs'

findedit -f '\.c$' -nodive -op 's/,\h*(\n\h+)?ftnlen((\h*\n)?\h+[a-z]+_len)?//g'
findedit -f '\.c$' -nodive -op 's/,\h*(\n\h*)?\((\h*\n\h*)?ftnlen\)(\h*\n\h*)?[0-9]+//g'
findedit -f '\.c$' -nodive -op 's/, ftnlen//g'

findedit -f '[ds]lamch\.c$' -nodive -op 's/(DO_FIO\(.*FTNLEN\))/lc($1)/eg'
findedit -f '\.c$' -nodive -op 's/(s___c_o_p_y_\(([^()]+?|\(.*?\))+\)_)/resetaside($1)/egs'
findedit -f '\.c$' -nodive -op 's/(s___c_m_p_\(([^()]+?|\(.*?\))+\)_)/resetaside($1)/egs'
findedit -f 'ilaenv\.c$' -nodive -op 's/name_len/6/g'

# Local Variables:
# eval:(org-link-minor-mode)
# eval:(visual-line-mode t)
# mode:shell-script
# coding:utf-8
# eval:(flyspell-prog-mode)
# eval:(outline-minor-mode)
# End:
# LocalWords: emacs
