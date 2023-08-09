#!/bin/zsh -l 
cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src/DQM/RPCMonitorModule/macros
rm -rf plots_${1}${2}
mkdir plots_${1}${2}
cd plots_${1}${2}
cp -r ../Chamber_Issues .
cp ../Construct_bChambers.py .
cp ../CSVReader.h .
cp ../EndcapPlot.C .
cp ../WheelPlot.C .
cp ../drawEfficiencyHistograms.C .
cp /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src/DQM/RPCMonitorModule/test/condor/Express_Cosmics/run_${1}${2}/output_${1}${2}/3steps/SummaryAnalyzeEfficiency_${1}${2}_Express2023.root .
python3 Construct_bChambers.py
summaryFile_name="SummaryAnalyzeEfficiency_${1}${2}_Express2023.root"
root -l -b -q "drawEfficiencyHistograms.C(true, false, 1, \"$summaryFile_name\")"
mkdir /eos/user/a/ahgit/rpc_workspace/plots/run_${1}${2}
cp *.png /eos/user/a/ahgit/rpc_workspace/plots/run_${1}${2}
cd ../
rm -rf plots_${1}${2}
