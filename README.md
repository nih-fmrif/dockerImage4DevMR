
# Docker container for MR scanner development.

This reposiotry will hold a Docker container build configuration to
facilitate development for FMRIF's MRI platforms.

It will satisfy Linux OS and system requirements. However, users must
obtain any proprietary software from the vendor, and install those
into this container themselves.  This repository provides guidance
and instructions on how to go about doing that, but will not provide
any proprietary software.

A Dockerfile for the basic software for this development repository
is now included.  To build the image locally, run a command along
the lines of:

   ```bash
   docker build -t local:fmrifDevContainerBase .
   ```

