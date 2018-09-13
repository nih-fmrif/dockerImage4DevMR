
FROM opensuse:42.3

RUN zypper ar -f http://download.opensuse.org/update/42.3/ update   &&   \
    zypper ar -f http://ftp.gwdg.de/pub/linux/packman/suse/openSUSE_Leap_42.3/ packman   &&   \
    zypper ar -f http://download.opensuse.org/repositories/Education/openSUSE_Leap_42.3/ education   &&   \
    zypper ar -f http://download.opensuse.org/repositories/devel:/libraries:/ACE:/major/openSUSE_Leap_42.3/ ace



# Install requirements for Orchestra and ESE.  Some, like 'rpm' and 'libz' are
# already in the default image.
RUN zypper --gpg-auto-import-keys --non-interactive install \
         make   imake   rsync   socat   xmessage   xclock   glibc-32bit   libgcc_s1-32bit   emacs   which \
         xorg-x11-fonts   libXpm4-32bit   libXm4-32bit   libUil4-32bit   libMrm4-32bit

# More generic utilities
RUN zypper --gpg-auto-import-keys --non-interactive install \
                                     # texlive-latex texlive-extratools texlive-dvips \
                                     # texlive-beamer texlive-collection-fontsextra \
                                     # texlive-collection-fontsrecommended \
                                     vim vim-data tcsh sudo tar which less xterm wget \
                                     hostname cmake gcc gcc-c++ xeyes postgresql-plpython \
                                     python-virtualenv python-psycopg2

# To buld and install AFNI:
RUN zypper --gpg-auto-import-keys --non-interactive install \
                                     libXft-devel libXp-devel libXpm-devel \
                                     libXmu-devel libpng12-devel libjpeg62 \
                                     zlib-devel libXt-devel libXext-devel \
                                     libXi-devel libexpat-devel netpbm m4 \
                                     libnetpbm-devel libGLU1 motif motif-devel \
                                     gsl-devel glu-devel freeglut-devel \
                                     netcdf netcdf-devel glib2-devel R-base-devel

# Gadgetron and ISMRMRD development:
RUN zypper --gpg-auto-import-keys --non-interactive install \
                                     python-devel python-numpy python-numpy-devel \
                                     python-matplotlib python-Sphinx \
                                     doxygen dcmtk dcmtk-devel libdcmtk3_6 \
                                     armadillo-devel libarmadillo7 glew glew-devel git \
                                     ace ace-devel boost-devel fftw3 fftw3-devel hdf5 hdf5-devel
# For Siemens-ISMRMRD converter:
RUN zypper --gpg-auto-import-keys --non-interactive install \
                                     xsd libxerces-c-devel libxslt-devel tinyxml-devel libxml2-devel



# Make a few links needed for various software suites.
RUN ln -s  /usr/lib64/libpng16.so.16.8.0  /usr/lib64/libpng.so   ;   ln -s  /lib64/libz.so.1  /lib64/libz.so



# Default start-up command is just a plain ol' shell for now
ENTRYPOINT ["/bin/bash"]

