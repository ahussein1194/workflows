#!/bin/zsh 
cd /afs/cern.ch/user/a/ahgit/cmssw
cmsrel CMSSW_13_0_10
cd CMSSW_13_0_10/src
cmsenv
source /cvmfs/cms.cern.ch/crab3/crab.sh
git cms-addpkg RecoLocalMuon/RPCRecHit
