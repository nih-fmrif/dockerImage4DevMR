
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
   docker build -t test:devContainerGE .
   ```

and feel free to choose an appropriate repository root and version name.
The container can then be executed with a command like:

   ```bash
   docker run --name devGE -it test:devContainerGE
   ```

