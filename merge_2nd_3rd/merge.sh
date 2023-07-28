#!/bin/zsh -l 
cd /eos/user/a/ahgit/rpc_workspace/runs_output/RPCMon/output_370753
hadd -j 8 -f -O Efficiency_370753_RPCMon2023.root *.root
mv Efficiency_370753_RPCMon2023.root /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src/DQM/RPCMonitorModule/test/2nd_3rd/RPCMon
