
#!/bin/sh

# Useful external repositories for SuSE.
zypper ar -f http://download.opensuse.org/update/42.3/ update
zypper ar -f http://ftp.gwdg.de/pub/linux/packman/suse/openSUSE_Leap_42.3/ packman
zypper ar -f http://download.opensuse.org/repositories/Education/openSUSE_Leap_42.3/ education
zypper ar -f http://download.opensuse.org/repositories/devel:/libraries:/ACE:/major/openSUSE_Leap_42.3/ ace
zypper ar -f http://download.opensuse.org/repositories/devel:/libraries:/c_c++/openSUSE_Leap_42.3/ cplus



# Install requirements for Orchestra and ESE.  Some, like 'rpm' and 'libz' are
# already in the default image.
zypper --gpg-auto-import-keys --non-interactive install \
   make   imake   rsync   socat   xmessage   xclock   emacs \
   which  xorg-x11-fonts   libXpm4-32bit   libXm4-32bit \
   libUil4-32bit   libMrm4-32bit glibc-32bit   libgcc_s1-32bit   

# More generic utilities
zypper --gpg-auto-import-keys --non-interactive install \
   vim vim-data tcsh sudo tar which less xterm wget \
   hostname cmake gcc gcc-c++ xeyes postgresql-plpython \
   gcc6  gcc6-c++  gcc6-fortran \
   python3-virtualenv python3-psycopg2
   # texlive-latex texlive-extratools texlive-dvips \
   # texlive-beamer texlive-collection-fontsextra \
   # texlive-collection-fontsrecommended

# To buld and install AFNI:
zypper --gpg-auto-import-keys --non-interactive install \
   libXft-devel libXp-devel libXpm-devel \
   libXmu-devel libpng12-devel libjpeg62 \
   zlib-devel libXt-devel libXext-devel \
   libXi-devel libexpat-devel netpbm m4 \
   libnetpbm-devel libGLU1 motif motif-devel \
   gsl-devel glu-devel freeglut-devel \
   netcdf netcdf-devel glib2-devel R-base-devel

# Gadgetron and ISMRMRD development:
zypper --gpg-auto-import-keys --non-interactive install \
   python3-devel python3-numpy python3-numpy-devel \
   python3-matplotlib python3-Sphinx \
   doxygen dcmtk dcmtk-devel libdcmtk3_6 \
   cblas armadillo-devel glew glew-devel git \
   ace ace-devel fftw3 fftw3-devel # hdf5 hdf5-devel \ # SuSE-supplied
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
   # and version 1.69 of the system's boost libraries will allow
   # Gadgetron to successfully build.

zypper --gpg-auto-import-keys --non-interactive install \
   boost-license1_69_0            libboost_headers1_69_0-devel \
   libboost_chrono1_69_0          libboost_chrono1_69_0-devel \
   libboost_container1_69_0       libboost_container1_69_0-devel \
   libboost_date_time1_69_0       libboost_date_time1_69_0-devel \
   libboost_filesystem1_69_0      libboost_filesystem1_69_0-devel \
   libboost_program_options1_69_0 libboost_program_options1_69_0-devel \
   libboost_python3-devel \
   libboost_python-py3-1_69_0     libboost_python-py3-1_69_0-devel \
   libboost_regex1_69_0           libboost_regex1_69_0-devel \
   libboost_system1_69_0          libboost_system1_69_0-devel \
   libboost_thread1_69_0          libboost_thread1_69_0-devel \
   libboost_timer1_69_0           libboost_timer1_69_0-devel \
   libboost_test1_69_0            libboost_test1_69_0-devel

# to try to 'python3-ize' the installation as much as possible
zypper --non-interactive remove python python-base python-devel
zypper --gpg-auto-import-keys --non-interactive install \
   cmake git python3-base python3-devel python3-numpy \
   python3-numpy-devel python3-Cython python3-six \
   python3-pip python3-setuptools python3-virtualenv

# Link to latest gcc for Gadgetron development, per documentation at:
#
#    https://en.opensuse.org/User:Tsu2/gcc_update-alternatives
#
update-alternatives --install   /usr/bin/gcc   gcc   /usr/bin/gcc-6    50
update-alternatives --install   /usr/bin/gcc   gcc   /usr/bin/gcc-4.8  20
update-alternatives --install   /usr/bin/g++   g++   /usr/bin/g++-6    50
update-alternatives --install   /usr/bin/g++   g++   /usr/bin/g++-4.8  20

# For Siemens-ISMRMRD converter:
zypper --gpg-auto-import-keys --non-interactive install \
   xsd libxerces-c-devel libxslt-devel tinyxml-devel libxml2-devel



# Make a few links needed for various software suites.
ln -s  /usr/lib64/libpng16.so.16.8.0  /usr/lib64/libpng.so
ln -s  /lib64/libz.so.1  /lib64/libz.so
# to have libboost link to python3 version
rm /usr/lib64/libboost_python.so ; ln -s /usr/lib64/libboost_python3.so /usr/lib64/libboost_python.so

