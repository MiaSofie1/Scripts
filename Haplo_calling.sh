#!/bin/bash

#SBATCH --job-name=test_job 	#give jobs a name
#SBATCH --account=ec432		#current project that we are on
#SBATCH --nodes=1 		#number of nodes/CPU
#SBATCH --ntasks=1		#how many tasks to run simutanously
#SBATCH --time=3:00:00		#how long the job will go for
#SBATCH --mem=1G		#how much memory

## Set up job environment
set -o errexit 			# Exit script on any error
set -o nounset 		 	# Treat any unset variables as an error

module --quiet purge 		#this resets the module environment, always good to start clean!

#Usually you load a number of modules below
#module load <module name>	#this loads a specific "module" allowing you to run programs installed on the cluster

## DO SOMETHING
FILENAME=$1


module load BIOS-IN5410/HT-2023
## Copy some input files to the work directory:
##touch file.txt 			#creates an empty file

## Make a directory in the directory from WHERE you submitted the script. $SUBMITDIR is replaced by the location from where you submit the script
mkdir -p $SUBMITDIR/gvcf      #create a results directory


## Copy output files to the directory you just made
##cp file.txt  $SUBMITDIR/result/



gatk HaplotypeCaller -R Orosv1mt.fasta \
-I $FILENAME --ploidy 1 -O gvcf/$FILENAME.gvcf.gz -ERC GVCF \
2> gvcf/HaploCaller_$FILENAME.out

echo ´$FILENAME HaplotypeCalled´


## Message that you are done with th$e job
echo "Finished running jobs"

