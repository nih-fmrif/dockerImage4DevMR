
FROM opensuse:42.3

RUN zypper ar -f http://download.opensuse.org/update/42.3/ update   &&   \
    zypper ar -f http://ftp.gwdg.de/pub/linux/packman/suse/openSUSE_Leap_42.3/ packman   &&   \
    zypper ar -f http://download.opensuse.org/repositories/Education/openSUSE_Leap_42.3/ education   &&   \
    zypper ar -f http://download.opensuse.org/repositories/devel:/languages:/python/openSUSE_Leap_42.3/ obsPython && \
    zypper ar -f http://download.opensuse.org/repositories/devel:/libraries:/ACE:/major/openSUSE_Leap_42.3/ ace



# Add informix group
RUN groupadd  -f   -g 201   informix

# and sdc user:
RUN useradd   -d /home/sdc   -m   -u 9000   -g 100   -G users,audio,informix   \
              -s /usr/bin/tcsh   -k /dev/null   sdc
ADD sdc.tcshrc             /home/sdc/.tcshrc



# Install requirements for Orchestra and ESE.  Some, like 'rpm' and 'libz' are
# already in the default image.
RUN zypper --gpg-auto-import-keys --non-interactive install \
         make   imake   rsync   xmessage   xclock   glibc-32bit   emacs   which \
         xorg-x11-fonts   libXpm4-32bit   libXm4-32bit   libUil4-32bit   libMrm4-32bit \



# More generic utilities
RUN zypper --gpg-auto-import-keys --non-interactive install \
                                     # texlive-latex texlive-extratools texlive-dvips \
                                     # texlive-beamer texlive-collection-fontsextra \
                                     # texlive-collection-fontsrecommended \
                                     vim vim-data tcsh sudo tar which less xterm wget \
                                     hostname cmake gcc gcc-c++ xeyes postgresql-plpython \
                                     python-conda python-psycopg2

# To buld and install AFNI:
RUN zypper --gpg-auto-import-keys --non-interactive install \
                                     libXft-devel libXp-devel libXpm-devel \
                                     libXmu-devel libpng12-devel libjpeg62 \
                                     zlib-devel libXt-devel libXext-devel \
                                     libXi-devel libexpat-devel netpbm m4 \
                                     libnetpbm-devel libGLU1 motif motif-devel \
                                     gsl-devel glu-devel freeglut-devel \
                                     netcdf netcdf-devel glib2-devel R-base-devel

RUN ln -s /usr/lib64/libjpeg.so.62.1.0 /usr/lib64/libjpeg.so ; ln -s /usr/lib64/libpng16.so.16.8.0 /usr/lib64/libpng.so

# Gadgetron and ISMRMRD development:
RUN zypper --gpg-auto-import-keys --non-interactive install \
                                     python-devel python-numpy python-numpy-devel \
                                     python-matplotlib python-Sphinx \
                                     doxygen python-dicom dcmtk dcmtk-devel libdcmtk3_6 \
                                     armadillo-devel libarmadillo7 glew glew-devel git \
                                     ace ace-devel boost-devel fftw3 fftw3-devel hdf5 hdf5-devel
# For Siemens-ISMRMRD converter:
RUN zypper --gpg-auto-import-keys --non-interactive install \
                                     xsd libxerces-c-devel libxslt-devel tinyxml-devel libxml2-devel



# Walk through similar steps for ESE
ENV ESEHOME       /usr/local/devGE
RUN mkdir -p      $ESEHOME
ENV WR_CUR        WindRiver.arch.rpm
ADD $WR_CUR       $ESEHOME
ENV ESE_CUR       ESE-current.os-arch.rpm
ADD $ESE_CUR      $ESEHOME
ENV ESE_3P_CUR    ESE-current.3p.rpm
ADD $ESE_3P_CUR   $ESEHOME
RUN rpm -ivh      --prefix $ESEHOME/WindRiver_02 $ESEHOME/$WR_CUR
RUN rpm -ivh      --force --nodeps --nofiledigest --ignorearch --prefix $ESEHOME $ESEHOME/$ESE_CUR
RUN rpm -ivh      --force --nodeps --nofiledigest --ignorearch --prefix $ESEHOME $ESEHOME/$ESE_3P_CUR
# Clean up archives copied into container, and break/remove link to any existing/old ESE.
RUN rm -f         $ESEHOME/$ESE_CUR   $ESEHOME/$ESE_3P_CUR   $ESEHOME/$WR_CUR   $ESEHOME/ESE_current
# This provides a standard name link to the latest installed ESE.  If desired to link to
# another ESE installation, customize as needed, or modify and commit Docker image directly
# yourself.
RUN cd            $ESEHOME   ;   ln -s `ls -rt -1 | tail -1` ESE_current
# Link to new ESE.
RUN sed -i       's/set _ese = /&$ESEHOME/' $ESEHOME/ESE_current/psd/config/set_ese_vars
RUN sed -i       's/_ese=/&$ESEHOME/'       $ESEHOME/ESE_current/psd/config/set_ese_vars_bash
# In new ESE, point to WindRiver installation.
RUN cd            $ESEHOME/ESE_current   ;   rm -rf 3p_vxworks os   ;  \
                  ln -s ../WindRiver_02/3p_vxworks   ;   ln -s ../WindRiver_02/os



# If not defined, set SDKTOP here, and set up system for Orchestra.
ENV SDKTOP     /usr/local/devGE/Orchestra/
ENV ORCH_CUR   Orchestra-sdk-current.os-arch.tgz
ADD $ORCH_CUR  /usr/local/devGE/
RUN ln -s      /usr/local/devGE/orchestra-* /usr/local/devGE/Orchestra
RUN ln -s      /lib64/libz.so.1   /lib64/libz.so



# Now set up default user.
RUN echo   "setenv SDKTOP   $SDKTOP"                     >>   /home/sdc/.tcshrc ; \
    echo   'setenv PATH     {$PATH}:{$SDKTOP}/recon/bin' >>   /home/sdc/.tcshrc ; \
    echo   "alias  setese   'source $ESEHOME/ESE_current/psd/config/set_ese_vars'" >> /home/sdc/.tcshrc ; \
    echo   "setese"                                      >>   /home/sdc/.tcshrc ; \
    echo   ""                                            >>   /home/sdc/.tcshrc
RUN chown  -R sdc:users   /home/sdc



# Default start-up command is just a plain ol' shell for now
# ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["/usr/bin/tcsh"]

