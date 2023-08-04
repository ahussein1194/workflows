#!/bin/zsh -l 
cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src
cd DQM/RPCMonitorModule/test/condor/Express_Cosmics/run_${1}${2}/output_${1}${2}
hadd -j 8 -f -O Efficiency_${1}${2}_Express2023.root *.root
mv Efficiency_${1}${2}_Express2023.root /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src/DQM/RPCMonitorModule/test/2nd_3rd/Express_Cosmics
