
FROM roopchansinghv/dockerimage4devmr:latest



# Set up installation directory and temporary workspace for this installer
# Users can substitute default file names here for their own files, and
# these should get progated into the machine customization script.
ENV   ESEHOME                    /usr/local/devGE
RUN   mkdir -p                   $ESEHOME/tmp

ENV   WR_CUR                     WindRiver.arch.rpm
ENV   ESE_CUR                    ESE-current.os-arch.rpm
ENV   ESE_3P_CUR                 ESE-current.3p.rpm
ENV   MACHINE_CUSTOMIZE_SCRIPT   customizeMachine.sh

ADD   $WR_CUR   $ESE_CUR   $ESE_3P_CUR   $MACHINE_CUSTOMIZE_SCRIPT   $ESEHOME/tmp/

# For user configuration
ADD   sdc.tcshrc                 $ESEHOME/tmp



# Adding a .tgz file to a building docker container seems to already unpack
# it in the location it is added to, so we should just have to go through
# the following steps to "install" Orchestra.
ENV   ORCH_CUR                   Orchestra-sdk-current.os-arch.tgz
ADD   $ORCH_CUR                  /usr/local/devGE/
# Remove / unlink existing Orchestra installation
RUN   rm -f                      /usr/local/devGE/Orchestra
RUN   ln -s                      /usr/local/devGE/orchestra-* /usr/local/devGE/Orchestra



# More involved installation and system customization now subsumed into this
# shell script.
RUN   sh                         $ESEHOME/tmp/$MACHINE_CUSTOMIZE_SCRIPT



# Clean up archives copied into container
RUN   rm -rf                     $ESEHOME/tmp



# Default start-up command is just a plain ol' shell for now
ENTRYPOINT ["/bin/tcsh"]

