#!/bin/zsh -l 
cd /afs/cern.ch/user/a/ahgit/cmssw
cmsrel CMSSW_13_0_9
cd CMSSW_13_0_9/src
cmsenv
source /cvmfs/cms.cern.ch/crab3/crab.sh
git cms-addpkg RecoLocalMuon/RPCRecHit
git clone -b run3_offlineAna_12_5_1 ssh://git@gitlab.cern.ch:7999/ahussein/OfflineRPCEfficiency.git
