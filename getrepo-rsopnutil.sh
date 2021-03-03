#!/QOpenSys/usr/bin/qsh
#----------------------------------------------------------------
# Script name: getrepo.sh
# Author: Richard Schoen
# Purpose: Get RSOPNUTIL repo and build the RSOPNUTIL library.
# **WARNING** - Make sure to back up existing RSOPNUTIL library instances 
#               before running build.sh
#               Existing RSOPNUTIL library will be cleared by build.sh
#----------------------------------------------------------------
INSTALLTEMP="/tmp"
INSTALLRSOPNUTIL="/tmp/rsopnutil"
REPONAME="https://github.com/richardschoen/rsopnutil-ibmi.git"

# Create temp download IFS location
mkdir ${INSTALLTEMP}
cd /${INSTALLTEMP}
# Clone the repo via git to temporary download location
git -c http.sslVerify=false clone --recurse-submodules ${REPONAME}

# Change to IFS temp download directory for repo and call build.sh to create library
cd ${INSTALLRSOPNUTIL}
bash build.sh
# After installation you can manually delete the IFS directory /tmp/QshOni
