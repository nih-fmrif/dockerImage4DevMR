
FROM opensuse:42.3



# Subsume all package installation and system customization
# into a single shell script which can be repurposed for a
# direct / live machine installation.
ENV   MACHINE_BUILD_SCRIPT    createMachine.sh
ADD   $MACHINE_BUILD_SCRIPT   /tmp
RUN   sh                      /tmp/$MACHINE_BUILD_SCRIPT
RUN   rm -f                   /tmp/$MACHINE_BUILD_SCRIPT



# Default start-up command is just a plain ol' shell for now
ENTRYPOINT ["/bin/bash"]

