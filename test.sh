#!/bin/bash
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the CONTROL_FILE to specify
# each executable per process.
#-------------------------------------------------------
#-------------------------------------------------------
#
#         <------ Setup Parameters ------>
#SBATCH -J Test         # Job name
#SBATCH -o outputs/Test.%j.out           # Name of stdout output file (%j expands to jobId)
#SBATCH -p rtx                    # Queue name
#SBATCH -N 3                      # Number of Nodes
#SBATCH -n 6                      # Number of tasks
#SBATCH -t 48:00:00
#SBATCH -A DMS20012
#

cd /home1/06399/armand/Unsupervised-Classification

module load launcher_gpu
module load cuda/10.0
module load cudnn/7.6.2

source activate selfcondgan


export LAUNCHER_JOB_FILE=/home1/06399/armand/Unsupervised-Classification/
export LAUNCHER_SCHED=interleaved
export LAUNCHER_WORKDIR=/home1/06399/armand/Unsupervised-Classification/

$LAUNCHER_DIR/paramrun

echo " "
echo " Parameteric Job Complete"
echo " "
