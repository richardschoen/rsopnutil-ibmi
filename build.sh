#!/QOpenSys/usr/bin/qsh
#----------------------------------------------------------------
# Script name: build.sh
# Author: Richard Schoen
# Purpose: Create RSOPNUTIL library, copies source members and compiles objects
#----------------------------------------------------------------
SRCLIB="RSOPNUTIL"
SRCLIBTEXT="RS Open Source Utilities"
SRCFILE="SOURCE"
dashes="---------------------------------------------------------------------------"

function cpy_member
{
# ----------------------------------------------------------------
# Copy source member and set source type
# ----------------------------------------------------------------
  SRCMEMBER=`echo "${CURFILE^^}" | cut -d'.' -f1`  # Parse PC file name prefix to member name
  SRCTYPE=`echo "${CURFILE^^}" | cut -d'.' -f2`    # Parse PC file name extenstion to souce type
  system -v "CPYFRMSTMF FROMSTMF('${PWD}/${CURFILE}') TOMBR('/QSYS.LIB/${SRCLIB}.LIB/${SRCFILE}.FILE/${SRCMEMBER}.MBR') MBROPT(*REPLACE)"
  system -v "CHGPFM FILE(${SRCLIB}/${SRCFILE}) MBR($SRCMEMBER) SRCTYPE(${SRCTYPE}) TEXT('${SRCTEXT}')" 
}

echo "$dashes"
echo "Starting Build of ${SRCLIBTEXT} library ${SRCLIB}"

# Create library, clear library and create source file 
system -v "CRTLIB ${SRCLIB} TYPE(*PROD) TEXT('${SRCLIBTEXT}')"
system -v "CLRLIB LIB(${SRCLIB})"
system -v "CRTSRCPF FILE(${SRCLIB}/${SRCFILE}) RCDLEN(120)"

# Copy all the source members and set source types
CURFILE="OPQRYTMP.CMD"
SRCTEXT="SQL Query Data to Selected Temp Table"
cpy_member

CURFILE="OPQRYTMPC.CLP"
SRCTEXT="SQL Query Data to Selected Temp Table"
cpy_member

#CURFILE="SRCBLDC.CLP"
#SRCTEXT="Build cmds from QSHONI/SOURCE file"   
#cpy_member

#CURFILE="README.TXT"
#SRCTEXT="Read Me Docs on Setup"
#cpy_member

#CURFILE="VERSION.TXT"
#SRCTEXT="Version Notes"
#cpy_member

# Create and run build program
#system -q "CRTCLPGM PGM(${SRCLIB}/SRCBLDC) SRCFILE(${SRCLIB}/${SRCFILE})"
#system -v "CALL PGM(${SRCLIB}/SRCBLDC)"

echo "${SRCLIBTEXT} library ${SRCLIB} was created and programs compiled."
echo "$dashes"
  
