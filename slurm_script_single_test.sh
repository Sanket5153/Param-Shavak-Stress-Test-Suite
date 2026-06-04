#!/bin/bash
#SBATCH --job-name=hpl_stress_test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=48
#SBATCH --time=72:30:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err

cd $SLURM_SUBMIT_DIR

# Create log directory
LOGDIR=LOGS/$SLURM_JOB_ID
mkdir -p $LOGDIR

# Load Spack
source /home/apps/spack/share/spack/setup-env.sh

# Load HPL
spack load hpl

echo "Job Started: $(date)" | tee $LOGDIR/job_info.log

# Run HPL benchmark
mpirun -np 48 xhpl HPL.dat > $LOGDIR/hpl.log 2>&1

echo "Job Finished: $(date)" >> $LOGDIR/job_info.log

# Copy SLURM logs
cp slurm-${SLURM_JOB_ID}.out $LOGDIR/
cp slurm-${SLURM_JOB_ID}.err $LOGDIR/

echo "All logs stored in $LOGDIR"
