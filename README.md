
# Docker container for MR scanner development.

This reposiotry will hold a Docker container build configuration to
facilitate development for FMRIF's MRI platforms.

It will satisfy Linux OS and system requirements. However, users must
obtain any proprietary software from the vendor, and install those
into this container themselves.  This repository provides guidance
and instructions on how to go about doing that, but will not provide
any proprietary software.

To build the container, first copy the current Orchestra RPM to this
directory, remove the empty file 'orchestra-sdk-current.os-arch.rpm',
make a soft link to the Orchestra RPM just copied with the same name,
'orchestra-sdk-current.os-arch.rpm'.  Copying the RPM into the build
directory is required as Docker will not look for, or follow links to
files outside of its build context.

To build the container, use a command similar to:

   ```bash
   docker build -t test:devGE .
   ```

and run with a command like:

   ```bash
   docker run --name devGE -it test:devGE
   ```

