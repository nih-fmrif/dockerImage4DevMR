
# Docker container for MR scanner development.

This reposiotry will hold a Docker container build configuration to
facilitate development for FMRIF's MRI platforms.

It will satisfy Linux OS and system requirements. However, users must
obtain any proprietary software from the vendor, and install those
into this container themselves.  This repository provides guidance
and instructions on how to go about doing that, but will not provide
any proprietary software.

To build a GE container, first copy the current Orchestra, ESE, and
WindRiver RPMs (the latter probably obtainable from an older ESE disk)
to this directory.  These items must have specific names (detailed in
Dockerfile). Copying RPMs into the build directory is required as Docker
will not look for, or follow links to files outside of its build context.

To build the container, use a command similar to:

   ```bash
   docker build -t test:devGEContainer .
   ```

and feel free to choose an appropriate repository root and version name.
The container can then be executed with a command like:

   ```bash
   docker run --name devGE -it test:devGEContainer
   ```

If running on a Mac, the XQuartz server must be running, and under the
Preferences - Security tab, both boxes must be checked to allow X11
programs to display on the host, to allow the network to pass through
needed X11 connections for WTools.

If the user would like to mount their home directory (/Users/$USER) within
the container (under /home/$USER), and would prefer to use the Bourne shell,
use a command along the lines of:

   ```bash
   for (( i=0; i<9; ++i )) ; do myIP=$( ipconfig getifaddr en$i ) && break ; done ; docker run --name devGE --user=`id -u` -v /Users:/home --env HOME=/home/$USER --entrypoint "/bin/bash" -e DISPLAY=$myIP:0 -it test:devGEContainer
   ```

Instead of using an IP on a public interface, a private IP can be aliased to
the network loopback device, and the same IP used for the display variable
passed to docker.  X11 connections must also be allowed from that IP, i.e.

   ```bash
   export DOCKER_DISPLAY_IP=192.168.89.144

   sudo ifconfig lo0 alias $DOCKER_DISPLAY_IP

   xhost + $DOCKER_DISPLAY_IP
   ```

Then

   ```bash
   docker run --name devGE --user=$( id -u ) -v /Users:/home --env HOME=/home/$USER --entrypoint "/bin/bash" -e DISPLAY=$DOCKER_DISPLAY_IP:0 -it test:devGEContainer
   ```
.

