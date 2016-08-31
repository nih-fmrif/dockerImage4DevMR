
FROM opensuse:13.1

# Add needed repos:
RUN zypper ar -f http://download.opensuse.org/update/13.1/ update   &&   \
    zypper ar -f http://ftp.gwdg.de/pub/linux/packman/suse/openSUSE_13.1/ packman   &&   \
    zypper ar -f http://download.opensuse.org/repositories/Education/openSUSE_13.1/ education



# Add informix group
RUN groupadd  -f   -g 201   informix

# and sdc user:
RUN useradd   -d /home/sdc   -m   -u 9000   -g 100   -G users,audio,informix   \
              -s /usr/bin/tcsh   -k /dev/null   sdc
# ADD .bashrc                /home/sdc
ADD sdc.tcshrc             /home/sdc/.tcshrc



# Install requirements for Orchestra and ESE.  Some, like 'rpm' and 'libz' are
# already in the default image.
RUN zypper --gpg-auto-import-keys --non-interactive install \
         tcsh   gcc   gcc-c++   make   imake   wget   rsync   vim   less  \
         xorg-x11-fonts   glibc-32bit   libXpm4-32bit   libXm4-32bit  \
         libUil4-32bit   libMrm4-32bit



# If not defined, set SDKTOP here, and set up system for Orchestra.
ENV SDKTOP     /usr/local/devGE/Orchestra
ENV ORCH_CUR   orchestra-sdk-current.os-arch.rpm
RUN mkdir -p   $SDKTOP
ADD $ORCH_CUR  $SDKTOP
RUN rpm -ivh --prefix $SDKTOP $SDKTOP/$ORCH_CUR
RUN ln -s      /lib64/libz.so.1   /lib64/libz.so
RUN rm -f      $SDKTOP/$ORCH_CUR



# Walk through similar steps for ESE
ENV ESETOP     /usr/local/devGE
# ENV WR_CUR     WindRiver_02.tgz
ENV WR_CUR     WindRiver.arch.rpm
ADD $WR_CUR    $ESETOP
ENV ESE_CUR    ese-current.os-arch.rpm
ADD $ESE_CUR   $ESETOP
RUN rpm -ivh   --prefix $ESETOP/WindRiver_02 $ESETOP/$WR_CUR
RUN rpm -ivh   --force --nodeps --nofiledigest --ignorearch --prefix $ESETOP $ESETOP/$ESE_CUR
# Clean up archives copied into container, and break/remove link to any existing/old ESE.
RUN rm -f      $ESETOP/$ESE_CUR   $ESETOP/$WR_CUR   $ESETOP/ESE_current
# This provides a standard name link to the latest installed ESE.  If desired to link to
# another ESE installation, customize as needed, or modify and commit Docker image directly
# yourself.
RUN cd         $ESETOP   ;   ln -s `ls -rt -1 | tail -1` ESE_current
# Link to new ESE.
RUN sed -i '/set _ese = / c\set _ese = '"$ESETOP"'/ESE_current' $ESETOP/ESE_current/psd/config/set_ese_vars
# In new ESE, point to WindRiver installation.
RUN cd         $ESETOP/ESE_current   ;   rm -rf 3p_vxworks os   ;  \
               ln -s ../WindRiver_02/3p_vxworks   ;   ln -s ../WindRiver_02/os



# Now set up default user.
RUN echo   "setenv SDKTOP   $SDKTOP"                     >>   /home/sdc/.tcshrc ; \
    echo   'setenv PATH     {$PATH}:{$SDKTOP}/recon/bin' >>   /home/sdc/.tcshrc ; \
    echo   "alias  setese   'source $ESETOP/ESE_current/psd/config/set_ese_vars'" >> /home/sdc/.tcshrc ; \
    echo   "setese"                                      >>   /home/sdc/.tcshrc ; \
    echo   ""                                            >>   /home/sdc/.tcshrc
RUN chown  -R sdc:users   /home/sdc



# Location for volume from host to be mounted in container
# VOLUME ["/data0"]



# Start up Samba services using default command to run at container startup
ENTRYPOINT ["/bin/bash"]

