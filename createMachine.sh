
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
   python-virtualenv python-psycopg2
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
   python-devel python-numpy python-numpy-devel \
   python-matplotlib python-Sphinx \
   doxygen dcmtk dcmtk-devel libdcmtk3_6 \
   cblas armadillo-devel glew glew-devel git \
   ace ace-devel fftw3 fftw3-devel hdf5 hdf5-devel \
   libboost_date_time1_68_0 libboost_date_time1_68_0-devel \
   libboost_filesystem1_68_0 libboost_filesystem1_68_0-devel \
   libboost_program_options1_68_0 libboost_program_options1_68_0-devel \
   libboost_python-py2_7-1_68_0 libboost_python-py2_7-1_68_0-devel \
   libboost_python-py3-1_68_0 libboost_python-py3-1_68_0-devel \
   libboost_regex1_68_0 libboost_regex1_68_0-devel \
   libboost_system1_68_0 libboost_system1_68_0-devel \
   libboost_test1_68_0 libboost_test1_68_0-devel \
   libboost_timer1_68_0 libboost_timer1_68_0-devel \
   libboost_thread1_68_0 libboost_thread1_68_0-devel

# For Siemens-ISMRMRD converter:
zypper --gpg-auto-import-keys --non-interactive install \
   xsd libxerces-c-devel libxslt-devel tinyxml-devel libxml2-devel



# Make a few links needed for various software suites.
ln -s  /usr/lib64/libpng16.so.16.8.0  /usr/lib64/libpng.so
ln -s  /lib64/libz.so.1  /lib64/libz.so

