#!/bin/zsh -l 
cd /afs/cern.ch/user/a/ahgit/cmssw
rm -rf CMSSW_13_0_9
cmsrel CMSSW_13_0_9
cd CMSSW_13_0_9/src
cmsenv
source /cvmfs/cms.cern.ch/crab3/crab.sh
git cms-addpkg RecoLocalMuon/RPCRecHit
git clone -b run3_offlineAna_12_5_1 https://gitlab.cern.ch/CMSRPCDPG/OfflineRPCEfficiency.git 
