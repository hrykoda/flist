#!/bin/sh

wlog() {
  TSTAMP=`date +"%Y/%m/%d %H:%M:%S"`
  echo "${TSTAMP} [$$] $@"
}

WORK_DIR=/Develop/tmp/flist
SP=0
EP=999
CLEAN=0

if [ $# -ge 1 ]; then SP=$1; fi
if [ $# -ge 2 ]; then EP=$2; fi
if [ $# -ge 3 ];
then
  if [ $3 = "clean" ]; then CLEAN=1;
  else echo "ERROR: Unexpected($3)"; exit 2;
  fi
fi

# ------
if [ ${CLEAN} -eq 1 ]
then
  rm -rf ${WORK_DIR}
fi
mkdir -p ${WORK_DIR}

# ------
wlog STA ALL; TS[0]=`date +%s`

# ------
P=1;PPP=`printf %03d ${P}`
OTFL=${WORK_DIR}/${PPP}.txt
if [ $SP -le $P -a $EP -ge $P ]
then
  wlog STA ${PPP}; TS[${P}]=`date +%s`
  find / -ls > ${OTFL}
  wlog END ${PPP} "(`expr $(date +%s) - ${TS[${P}]}` sec)"
fi

INFL=${WORK_DIR}/${PPP}.txt
# ------
P=2;PPP=`printf %03d ${P}`
OTFL=${WORK_DIR}/${PPP}.txt
if [ $SP -le $P -a $EP -ge $P ]
then
  wlog STA ${PPP}; TS[${P}]=`date +%s`
  sort -b -k 11r,11 ${INFL} > ${OTFL}
  wlog END ${PPP} "(`expr $(date +%s) - ${TS[${P}]}` sec)"
fi

# ------
P=3;PPP=`printf %03d ${P}`
OTFL=${WORK_DIR}/${PPP}.txt
if [ $SP -le $P -a $EP -ge $P ]
then
  wlog STA ${PPP}; TS[${P}]=`date +%s`
  sort -b -k 7ir,7 ${INFL} > ${OTFL}
  wlog END ${PPP} "(`expr $(date +%s) - ${TS[${P}]}` sec)"
fi

# ------
wlog END ALL "(`expr $(date +%s) - ${TS[0]}` sec)"
