#!/bin/zsh -l 
cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src
cmsenv
cd DQM/RPCMonitorModule/test/2nd_3rd/RPCMon
cmsRun makeEfficiencySummary.py ${1}
mkdir -p /eos/user/a/ahgit/rpc_workspace/runs_output/RPCMon/output_${1}/3steps
mv *${1}*.root /eos/user/a/ahgit/rpc_workspace/runs_output/RPCMon/output_${1}/3steps
