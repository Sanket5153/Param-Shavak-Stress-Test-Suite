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

# Start monitoring
./Scripts/node_health_monitoring.sh $LOGDIR &
MON_PID=$!

echo "Monitor PID: $MON_PID"

# Run HPL stress test
./Scripts/stress_test.sh $LOGDIR

# Stop monitoring
kill $MON_PID

# Save SLURM logs
cp slurm-${SLURM_JOB_ID}.out $LOGDIR/
cp slurm-${SLURM_JOB_ID}.err $LOGDIR/

echo "Benchmark completed"
