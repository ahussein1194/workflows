#!/bin/zsh -l 
resubmit_to_condor=true
condor_trials_count=1
while [ "$resubmit_to_condor" = true ]; do
	cd /afs/cern.ch/user/a/ahgit/cmssw/CMSSW_13_0_10/src
	cmsenv
	cd DQM/RPCMonitorModule/test/condor/Express_Cosmics
	# Clean dir.
        rm -rf submitResult_${1}${2}.txt
        rm -rf condorQuery_${1}${2}.txt
	./submit_condor.sh ${1} ${2} > submitResult_${1}${2}.txt
	cat submitResult_${1}${2}.txt
	cluster_id=$(grep -o -P '(?<=cluster ).*?(?=\.)' submitResult_${1}${2}.txt)
	# Check if condor submission failed.
	if [ "$cluster_id" = "" ]; then
		rm -rf submitResult_${1}${2}.txt
		echo "Submission failed. No jobs were submitted!"
		exit 1
	fi
	# Get the number of submitted jobs.
	num_submitted_jobs=$(grep -o -P '\d+(?= job\(s\))' submitResult_${1}${2}.txt)
	condor_q $cluster_id > condorQuery_${1}${2}.txt
	jobs_remaining=$(grep -o -P '(?<=Total for query: ).*?(?= jobs)' condorQuery_${1}${2}.txt)

	# Check that condor run finished.
	while [ "$jobs_remaining" -ne 0 ]; do
		sleep 5
		condor_q $cluster_id > condorQuery_${1}${2}.txt
		cat condorQuery_${1}${2}.txt
		jobs_remaining=$(grep -o -P '(?<=Total for query: ).*?(?= jobs)' condorQuery_${1}${2}.txt)
	done

	# Clean dir.
	rm -rf submitResult_${1}${2}.txt
	rm -rf condorQuery_${1}${2}.txt
	
	# Check that all jobs were transferred successfully.
	cd run_${1}${2}/output_${1}${2}
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
