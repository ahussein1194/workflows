#!/bin/zsh -l 
cd /eos/user/a/ahgit/rpc_workspace/runs_output/RPCMon/output_${1}
hadd -j 8 -f -O Efficiency_${1}_RPCMon2023.root *.root
mv Efficiency_${1}_RPCMon2023.root /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src/DQM/RPCMonitorModule/test/2nd_3rd/RPCMon
