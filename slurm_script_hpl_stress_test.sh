#!/bin/bash
#SBATCH --job-name=hpl_stress_test
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=48
#SBATCH --time=72:30:00
#SBATCH --output=slurm-%j.out
#SBATCH --error=slurm-%j.err

cd $SLURM_SUBMIT_DIR

# Load spack env
source /home/apps/spack/share/spack/setup-env.sh

# Load HPL Benchmark
spack load hpl

# RUN benchmark
mpirun -np 48 xhpl HPL.dat

echo "Benchmark completed"
