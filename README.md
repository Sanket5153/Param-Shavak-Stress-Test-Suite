HPL Benchmark Setup Guide

1. Load Spack

source /home/apps/spack/share/spack/setup-env.sh

--------------------------------------------------

2. Load HPL

spack load hpl

--------------------------------------------------

3. Check HPL

which xhpl

--------------------------------------------------

4. Give Permission to Script

chmod +x HPL_CPU_Benchmark.sh

--------------------------------------------------

5. Run Script

./HPL_CPU_Benchmark.sh

--------------------------------------------------

6. Script Generates

1. HPL.dat
2. parameters.txt

--------------------------------------------------

7. Run HPL Benchmark

mpirun -np 48 xhpl

--------------------------------------------------

8. Example Values

Efficiency : 90
NB         : 192
P          : 4
Q          : 4
MPI        : 16

--------------------------------------------------

9. Important Note

P × Q should be equal to MPI processes

Example:

6 × 8 = 48
