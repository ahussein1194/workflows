#!/bin/zsh -l 
cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src
cmsenv
cd DQM/RPCMonitorModule/test/2nd_3rd/Express_Cosmics
cmsRun makeEfficiencySummary.py ${1} ${2}
mkdir /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src/DQM/RPCMonitorModule/test/condor/Express_Cosmics/run_${1}${2}/output_${1}${2}/3steps
mv *${1}${2}*.root /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src/DQM/RPCMonitorModule/test/condor/Express_Cosmics/run_${1}${2}/output_${1}${2}/3steps
