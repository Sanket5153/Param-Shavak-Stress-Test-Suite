#!/bin/bash
#SBATCH -N 1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=74:00:00
#SBATCH --job-name=GROMACS_GPU
#SBATCH --output=GROMACS_%j.out
#SBATCH --error=GROMACS_%j.err
#SBATCH --partition=Standard

ulimit -s unlimited

source /home/apps/spack/share/spack/setup-env.sh
spack load gromacs+cuda
export GMX_ENABLE_DIRECT_GPU_COMM=true

echo "==================================================" > gromacs_gpu.log
echo "Job Started : $(date)" >> gromacs_gpu.log
echo "Host        : $(hostname)" >> gromacs_gpu.log
echo "==================================================" >> gromacs_gpu.log

(time gmx_mpi mdrun \
-nb gpu \
-ntomp 24 \
-pin on \
-nsteps 18000000 \
-s water.tpr) \
>> gromacs_gpu.log 2>&1

echo "==================================================" >> gromacs_gpu.log
echo "Job Finished: $(date)" >> gromacs_gpu.log
echo "==================================================" >> gromacs_gpu.log
