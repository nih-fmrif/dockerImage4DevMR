
#!/bin/sh

# Useful external repositories for SuSE.
zypper ar -f http://download.opensuse.org/update/leap/$VERSION_SUSE/ update    | echo 'a'
zypper ar -f http://ftp.gwdg.de/pub/linux/packman/suse/openSUSE_Leap_$VERSION_SUSE/ packman    | echo 'a'
zypper ar -f http://download.opensuse.org/repositories/Education/openSUSE_Leap_$VERSION_SUSE/ education    | echo 'a'
zypper ar -f http://download.opensuse.org/repositories/devel:/libraries:/c_c++/openSUSE_Leap_$VERSION_SUSE/ cplus    | echo 'a'

zypper refresh
zypper --non-interactive update
zypper clean



# Install requirements for Orchestra and ESE.  Some, like 'rpm' and 'libz' are
# already in the default image.
zypper --non-interactive --gpg-auto-import-keys install \
   make   imake   rsync   socat   xmessage   xclock   emacs \
   which  gzip   xorg-x11-fonts   libXpm4-32bit   libXm4-32bit \
   libUil4-32bit   libMrm4-32bit glibc-32bit   libgcc_s1-32bit \
   zlib-devel

zypper clean

# More generic utilities
zypper --non-interactive --gpg-auto-import-keys install \
   vim vim-data tcsh sudo tar which less xterm wget zsh \
   hostname cmake gcc gcc-c++ xeyes postgresql-plpython \
   gcc8  gcc8-c++  gcc8-fortran python3-psycopg2 doxygen \
   xfig # texlive-latex texlive-extratools texlive-dvips \
   # texlive-beamer texlive-collection-fontsextra \
   # texlive-collection-fontsrecommended

zypper clean

# To buld and install AFNI:
zypper --non-interactive --gpg-auto-import-keys install \
   libXft-devel libXp-devel libXpm-devel \
   libXmu-devel libpng12-devel libjpeg62 \
   libXt-devel libXext-devel \
   libXi-devel libexpat-devel netpbm m4 \
   libnetpbm-devel libGLU1 motif motif-devel \
   gsl-devel glu-devel freeglut-devel \
   netcdf netcdf-devel glib2-devel R-base-devel

# zypper clean

# Gadgetron and ISMRMRD development:
zypper --non-interactive --gpg-auto-import-keys install \
   python3-devel python3-numpy python3-numpy-devel \
   python3-matplotlib python3-Sphinx python3-Cython \
   python3-six python3-virtualenv libpython2_7-1_0 \
   dcmtk dcmtk-devel libdcmtk3_6 \
   cblas armadillo-devel glew glew-devel git \
   fftw3-devel lapacke-devel pugixml-devel \
   openmpi-devel  libopenblas_openmp-devel \
   libqt4-devel plplot-devel plplotcxx-devel
   python3-torch-devel
   hdf5 hdf5-devel \ # SuSE-supplied HDF version not
   # compatible with Orchestra development environment.
   # Use libraries supplied with that environment instead
   # to build GE-ISMRMRD converter.  Use this version for
   # gadgetron.

zypper clean

zypper --non-interactive --gpg-auto-import-keys install \
   boost-license1_66_0                  \
   libboost_chrono1_66_0-devel          \
   libboost_container1_66_0-devel       \
   libboost_date_time1_66_0-devel       \
   libboost_filesystem1_66_0-devel      \
   libboost_math1_66_0-devel            \
   libboost_numpy-py3-1_66_0-devel      \
   libboost_program_options1_66_0-devel \
   libboost_python-py2_7-1_66_0-devel   \
   libboost_python-py3-1_66_0-devel     \
   libboost_regex1_66_0-devel           \
   libboost_serialization1_66_0-devel   \
   libboost_signals1_66_0-devel         \
   libboost_system1_66_0-devel          \
   libboost_thread1_66_0-devel          \
   libboost_timer1_66_0-devel           \
   libboost_test1_66_0-devel            \
   libboost_random1_66_0-devel

zypper clean

# For Siemens-ISMRMRD converter:
zypper --non-interactive --gpg-auto-import-keys install \
   xsd libxerces-c-devel libxslt-devel tinyxml-devel libxml2-devel

zypper clean

