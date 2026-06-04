#!/bin/bash
#SBATCH --job-name=hpl_stress_test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=48
#SBATCH --time=72:30:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err

cd $SLURM_SUBMIT_DIR

LOGDIR=LOGS/$SLURM_JOB_ID
mkdir -p $LOGDIR

# Load Spack
source /home/apps/spack/share/spack/setup-env.sh

# Load HPL
spack load hpl

echo "Job Started: $(date)" | tee $LOGDIR/job_info.log

# Start monitoring
./Scripts/node_health_monitoring.sh $LOGDIR &
MON_PID=$!

echo "Monitor PID: $MON_PID"

# Run HPL stress test
./Scripts/stress_test_hpl.sh $LOGDIR

# Stop monitoring
kill $MON_PID

# Save SLURM logs
mv slurm-${SLURM_JOB_ID}.out $LOGDIR/
mv slurm-${SLURM_JOB_ID}.err $LOGDIR/

echo "Benchmark completed"
