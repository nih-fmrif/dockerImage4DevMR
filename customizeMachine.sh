
#!/bin/sh

export   ESEHOME=/usr/local/devGE
export   SDKTOP=/usr/local/devGE/Orchestra

mkdir -p $ESEHOME/tmp


# Remove system HDF5 as compiler would not behave properly with both this
# and Orchestra HDF5 libraries simultaneously.
zypper   --non-interactive remove hdf5 hdf5-devel



# Add (potentially) useful groups
groupadd -f            sys
groupadd -f            mail
groupadd -f   -g 201   informix

# and the default (sdc) user ... :
useradd  -d   /home/sdc   -m   -u 9000   -g 100   -G users,audio,informix   \
         -s   /bin/tcsh   -k /dev/null   sdc
cp -p    $ESEHOME/tmp/sdc.tcshrc    /home/sdc/.tcshrc

# ... and set up default user.
echo     "setenv SDKTOP   $SDKTOP"                     >>   /home/sdc/.tcshrc ; \
echo     'setenv PATH     {$PATH}:{$SDKTOP}/recon/bin' >>   /home/sdc/.tcshrc ; \
echo     "alias  setese   'source $ESEHOME/ESE_current/psd/config/set_ese_vars'" >> /home/sdc/.tcshrc ; \
echo     "setese"                                      >>   /home/sdc/.tcshrc ; \
echo     ""                                            >>   /home/sdc/.tcshrc

chown    -R sdc:users   /home/sdc



# Now install and customize ESE packages
rpm -ivh --prefix $ESEHOME/WindRiver_02 $ESEHOME/tmp/$WR_CUR
rpm -ivh --force --nodeps --nofiledigest --ignorearch --prefix $ESEHOME $ESEHOME/tmp/$ESE_CUR
rpm -ivh --force --nodeps --nofiledigest --ignorearch --prefix $ESEHOME $ESEHOME/tmp/$ESE_3P_CUR

# Remove existing link to previous default installation ...
cd       $ESEHOME
rm -f    ESE_current
# ... and make link to existing new ESE installation
ln -s    `ls -rt -1 | tail -1`   ESE_current

# In new ESE, point to WindRiver installation.
cd       ESE_current
rm -rf   3p_vxworks   os
ln -s    ../WindRiver_02/3p_vxworks
ln -s    ../WindRiver_02/os

# Customize newly installed ESE to point to its own current installation location
sed -i   's/set _ese = /&$ESEHOME/' $ESEHOME/ESE_current/psd/config/set_ese_vars
sed -i   's/_ese=/&$ESEHOME/'       $ESEHOME/ESE_current/psd/config/set_ese_vars_bash

