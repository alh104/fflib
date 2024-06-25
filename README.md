<!-- 
   - README.md
   - =========
   - 
   - [[http://www.ljll.fr/lehyaric][Antoine Le Hyaric]]
   - 
   - Sorbonne Université, CNRS, Laboratoire Jacques-Louis Lions, F-75005, Paris, France
   - 
   - ----------------------------
   - This file is part of FreeFEM
   - ----------------------------
   - FreeFEM is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as
   - published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
   - FreeFEM is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
   - MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public License for more details.
   - You should have received a copy of the GNU Lesser General Public License along with FreeFEM; if not, write to the Free Software
   - Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
   - 
   - [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive nil) (org-toggle-link-display))][hide links]] [[elisp:(progn (org-link-minor-mode) (setq org-link-descriptive t) (org-toggle-link-display))][show links]] [[elisp:(alh-1dex-open)][open 1dex]] [[elisp:(alh-1dex-update)][update 1dex]]
   - [[elisp:(alh-set-keywords)][set keywords]] ([[file:~/alh/bin/headeralh][headeralh]])
   - emacs-keywords freefem markdown start=11/06/24 univ update=25/06/24
   -->

<!-- [[https://docs.github.com/fr/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax]] -->

## Numerical libraries package for [FreeFEM](https://www.freefem.org)

***Version 24.1***

Contains well-known numerical libraries compiled in Javascript for FreeFEM. Generating Javascript output requires cross-compiling, which is
not usually provided in the building procedure of these libraries. This `Makefile` generates the required cross-compilation directives and
produces a single Javascript lib.

The main target is [emscripten](https://emscripten.org), but other compilers can be used by setting `$(CXX)` and `$(CXXFLAGS)`.  The three
main binary output formats are **dev** (development version), **min** (optimized for speed and minimum size) and **native**. Please refer to
[ffjs](https://www.ljll.fr/lehyaric/ffjs) for more details.  Optimized options are available (mainly "-Os"), but without compromising on
portability.

With many thanks to the projects used in this library:

+ [f2c](https://www.netlib.org/f2c/)
+ [BLAS](https://www.netlib.org/blas/)
+ [CBLAS](https://www.netlib.org/blas/#_cblas)
+ [LAPACK](https://www.netlib.org/lapack/)
+ [ARPACK](https://www.arpack.org/)
+ [SuiteSparse](https://people.engr.tamu.edu/davis/suitesparse.html)
+ [TetGen](https://wias-berlin.de/software/index.jsp?id=TetGen&lang=1)

More libraries may be added, depending on the needs for FreeFEM.

This project ([web page](https://www.ljll.fr/lehyaric/ffcs/fflib.htm), [github](https://github.com/alh104/fflib)) has been initiated as a
tool for the [ffjs](https://www.ljll.fr/lehyaric/ffjs) project but it can be used standalone.

Questions, comments and patches are welcome on the [FreeFEM forum](https://community.freefem.org).

### Build commands

Building the default (native) binary version (result in `bin_default/libfflib.a`):

```
make -j binary
```

Creating binaries for any architecture (result in `bin_[arch]/libfflib.a`):

```
make -j BINTAG=[arch] BINGOAL=all
```

Please refer to the [ffjs](https://www.ljll.fr/lehyaric/ffjs) project for Javascript configuration.

All usual make variables (CXX, CXXFLAGS, etc) are available.

<!-- 
   - Local Variables:
   - mode:markdown
   - indent-tabs-mode:nil
   - eval:(visual-line-mode t)
   - coding:utf-8
   - eval:(flyspell-mode)
   - eval:(outline-minor-mode)
   - eval:(org-link-minor-mode)
   - End:
   -->
<!-- LocalWords: emacs
   -->
