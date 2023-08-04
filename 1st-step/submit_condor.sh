#!/bin/zsh -l 
resubmit_to_condor=true
condor_trials_count=1
while [ "$resubmit_to_condor" = true ]; do
	cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src
	cmsenv
	cd DQM/RPCMonitorModule/test/condor/Express_Cosmics
	# Clean dir.
        rm -rf submit_result.txt
        rm -rf condor_query.txt
	./submit_condor.sh 371 208 > submit_result.txt
	cat submit_result.txt
	cluster_id=$(grep -o -P '(?<=cluster ).*?(?=\.)' submit_result.txt)
	# Check if condor submission failed.
	if [ "$cluster_id" = "" ]; then
		rm -rf submit_result.txt
		echo "Submission failed. No jobs were submitted!"
		exit 1
	fi
	# Get the number of submitted jobs.
	num_submitted_jobs=$(grep -o -P '\d+(?= job\(s\))' submit_result.txt)
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
		echo "First step of analysis suceeded! [trial $condor_trials_count/3]."
		resubmit_to_condor=false
	else
		if [ "$condor_trials_count" -lt 3 ]; then
			((condor_trials_count++))
			echo "Some files were not transferred successfully, resubmitting to condor [trial $condor_trials_count/3]."
			resubmit_to_condor=true
		else
			echo "Some files were not transferred successfully. First step failed!"
                        resubmit_to_condor=false
			# Set build status to FAILURE.
			exit 1
		fi

	fi
done
