#!/bin/zsh -l 
resubmit_to_condor=true
while [ "$resubmit_to_condor" = true ]; do
	cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src
	cmsenv
	cd DQM/RPCMonitorModule/test/condor/Express_Cosmics
	./submit_condor.sh 371 208 > submit_result.txt
	cat submit_result.txt
	num_submitted_jobs=$(grep -o -P '\d+(?= job\(s\))' submit_result.txt)
	cluster_id=$(grep -o -P '(?<=cluster ).*?(?=\.)' submit_result.txt)
	condor_q $cluster_id > condor_query.txt
	jobs_remaining=$(grep -o -P '(?<=Total for query: ).*?(?= jobs)' condor_query.txt)

	# Check that condor run finished.
	while [ "$jobs_remaining" -ne 0 ]; do
		sleep 5
		condor_q $cluster_id > condor_query.txt
		cat condor_query.txt
		jobs_remaining=$(grep -o -P '(?<=Total for query: ).*?(?= jobs)' condor_query.txt)
	done

	# Clean dir.
	rm -rf submit_result.txt
	rm -rf condor_query.txt
	
	# Check that all jobs were transferred successfully.
	cd run_371208/output_371208
	transferred_jobs=$(ls | wc -l)
	if [ "$num_submitted_jobs" = "$transferred_jobs" ]; then
		echo "All files transferred successfully!"
		resubmit_to_condor=false
	else
		echo "Some files were not transferred successfully!"
		resubmit_to_condor=true
	fi
done
