#!/bin/zsh -l 
cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src
cmsenv
cd DQM/RPCMonitorModule/test/2nd_3rd/Express_Cosmics
cmsRun calculateEfficiency.py ${1} ${2}
