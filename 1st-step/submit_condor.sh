#!/bin/zsh -l 
cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src
cmsenv
cd DQM/RPCMonitorModule/test/condor/Express_Cosmics
./submit_condor.sh 371 208 > submit_result.txt
grep -o -P '(?<=cluster ).*?(?=\.)' submit_result.txt > cluster_id.txt
cluster_id=$(grep -o -P '(?<=cluster ).*?(?=\.)' submit_result.txt)
sleep 10
condor_q $cluster_id > condor_query.txt
jobs_remaining=$(grep -o -P '(?<=Total for query: ).*?(?= jobs)' condor_query.txt)
echo "#Remaining jobs: " $jobs_remaining
