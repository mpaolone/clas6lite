# clas6lite
A version of the clas6 software package that will build on MacOSX 10.5.3 with gcc-10.  Some generators and utilities have been removed, but a1c, user_ana, recsis, clasEvent, gsim, and gpp have all stuck around.  Some of the sloppy code has been modified to work with modern compilers.  Not everything has been tested, so USE AT YOUR OWN RISK!

Some things you will need (from brew)

  gcc, scons, openmotif, mysql, and maybe other things that I have already installed

You will also need X11 libraries that you can get from xquartz.org.

You will also need cernlib, or the nanocernlib wich can be found at: https://github.com/mpaolone/nanocernlib

# build and install

you will need to use scons to build.  From the main directory you can type

  scons -j[number of cores]
	  
Where [number of cores] is an integer of the number of cores you want to dedicate to compiling (I use 8, typically).
  
NOTE:  The first time you run this you will need to add some options, specifically:

  scons mysqlinc=/usr/local/Cellar/mysql/[VERSION]/include/mysql mysqllib=/usr/local/Cellar/mysql/[VERSION]/lib tcllib=/opt/X11/lib gfortranlib=/usr/local/Cellar/gcc/[VERSION]/lib/gcc/[TAG] -j8
	  

notice that [VERSION] is the version you got from brew, and that [TAG] is the top-level version of gcc (i.e. my gcc has [VERSION]=10.1.0 and [TAG]=10)

you can see all options for scons with "scons -h"  and you can clean your build with "scons --clean".  See the clas6 software documentation for more details
