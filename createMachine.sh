
#!/bin/sh

# Useful external repositories for SuSE.
zypper ar -f http://download.opensuse.org/update/leap/$VERSION_SUSE/ update    | echo 'a'
zypper ar -f http://ftp.gwdg.de/pub/linux/packman/suse/openSUSE_Leap_$VERSION_SUSE/ packman    | echo 'a'
# zypper ar -f http://download.opensuse.org/repositories/Education/openSUSE_Leap_$VERSION_SUSE/ education    | echo 'a'
# zypper ar -f http://download.opensuse.org/repositories/devel:/libraries:/ACE:/major/openSUSE_Leap_$VERSION_SUSE/ ace    | echo 'a'
zypper ar -f http://download.opensuse.org/repositories/devel:/libraries:/c_c++/openSUSE_Leap_$VERSION_SUSE/ cplus    | echo 'a'

zypper refresh



# Install requirements for Orchestra and ESE.  Some, like 'rpm' and 'libz' are
# already in the default image.
zypper --non-interactive --gpg-auto-import-keys install \
   make   imake   rsync   socat   xmessage   xclock   emacs \
   which  xorg-x11-fonts   libXpm4-32bit   libXm4-32bit \
   libUil4-32bit   libMrm4-32bit glibc-32bit   libgcc_s1-32bit   

zypper clean

# More generic utilities
zypper --non-interactive --gpg-auto-import-keys install \
   vim vim-data tcsh sudo tar which less xterm wget \
   hostname cmake gcc gcc-c++ xeyes postgresql-plpython \
   gcc8  gcc8-c++  gcc8-fortran python3-psycopg2 doxygen \
   texlive-latex texlive-extratools texlive-dvips \
   texlive-beamer texlive-collection-fontsextra \
   texlive-collection-fontsrecommended

zypper clean

# To buld and install AFNI:
zypper --non-interactive --gpg-auto-import-keys install \
   libXft-devel libXp-devel libXpm-devel \
   libXmu-devel libpng12-devel libjpeg62 \
   zlib-devel libXt-devel libXext-devel \
   libXi-devel libexpat-devel netpbm m4 \
   libnetpbm-devel libGLU1 motif motif-devel \
   gsl-devel glu-devel freeglut-devel \
   netcdf netcdf-devel glib2-devel R-base-devel

zypper clean

# Gadgetron and ISMRMRD development:
zypper --non-interactive --gpg-auto-import-keys install \
   python3-devel python3-numpy python3-numpy-devel \
   python3-matplotlib python3-Sphinx python3-Cython \
   python3-six python3-virtualenv libpython2_7-1_0 \
   dcmtk dcmtk-devel libdcmtk3_6 \
   cblas armadillo-devel glew glew-devel git \
   fftw3-devel # ace ace-devel hdf5 hdf5-devel \ # SuSE-supplied
   # HDF version not compatible with Orchestra development environment.
   # Use libraries supplied with that environment instead.
   #
   #
   #
   # The distributed version (1.68) of boost libraries originally
   # distributed with openSUSE 42.3 were NOT built with the C++ 14
   # standard, so when used to build the Gadgetron, there were
   # linking errors.  To work around this, a current version of 
   # Boost was downloaded and built with the appropriate flags and
   # for Gadgetron compilation, the variables and values:
   #
   #    CMAKE_C_COMPILER=/usr/bin/gcc-6, 
   #    CMAKE_CXX_COMPILER=/usr/bin/g++-6
   #    Boost_INCLUDE_DIR=$HOME/my_root/boost/include
   #
   # were used as part of the cmake command line.
   #
   #
   #
   # As of January 2019, building with openSUSE's gcc-6 and g++-6
   # and version 1.61 of the system's boost libraries will allow
   # Gadgetron to successfully build.

zypper clean

zypper --non-interactive --gpg-auto-import-keys install \
   boost-license1_66_0                  \
   libboost_chrono1_66_0-devel          \
   libboost_container1_66_0-devel       \
   libboost_date_time1_66_0-devel       \
   libboost_filesystem1_66_0-devel      \
   libboost_program_options1_66_0-devel \
   libboost_python-py2_7-1_66_0-devel   \
   libboost_python-py3-1_66_0-devel     \
   libboost_regex1_66_0-devel           \
   libboost_system1_66_0-devel          \
   libboost_thread1_66_0-devel          \
   libboost_timer1_66_0-devel           \
   libboost_test1_66_0-devel

zypper clean

# For Siemens-ISMRMRD converter:
zypper --non-interactive --gpg-auto-import-keys install \
   xsd libxerces-c-devel libxslt-devel tinyxml-devel libxml2-devel

zypper clean

