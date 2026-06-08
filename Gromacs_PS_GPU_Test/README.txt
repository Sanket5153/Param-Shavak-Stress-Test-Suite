# GROMACS GPU Test Execution Guide

Follow the steps below to validate a CUDA-enabled GROMACS installation and verify GPU utilization during execution.

## 1. Load the Spack Environment

Before running any commands, load the Spack environment:

```bash
source /home/apps/spack/share/spack/setup-env.sh
```

## 2. Verify GROMACS Installation

Check whether a CUDA-enabled GROMACS installation is available:

```bash
spack find gromacs+cuda
```

## 3. Install GROMACS (If Required)

If the previous command returns no results, install GROMACS with CUDA support:

```bash
spack install gromacs+cuda
```

Wait for the installation to complete successfully before proceeding.

## 4. Load GROMACS and Prepare Benchmark Input

Load the CUDA-enabled GROMACS package:

```bash
source /home/apps/spack/share/spack/setup-env.sh
spack load gromacs+cuda
```

Create a working directory and download the benchmark dataset:

```bash
mkdir Gromacs
cd Gromacs

wget https://ftp.gromacs.org/pub/benchmarks/water_GMX50_bare.tar.gz --no-check-certificate
tar -xzf water_GMX50_bare.tar.gz
```

Navigate to the benchmark directory:

```bash
cd water-cut1.0_GMX50_bare/3072
```

Generate the benchmark input file:

```bash
gmx_mpi grompp -f pme.mdp -c conf.gro -p topol.top -o water.tpr
```

Verify that the file was created successfully:

```bash
ls -lh water.tpr
```

The generated file will be located at:

```text
Gromacs/water-cut1.0_GMX50_bare/3072/water.tpr
```

## 5. Copy the Benchmark Input File

Copy the generated `water.tpr` file to the directory containing `test_gromacs_gpu.sh`:

```bash
cp Gromacs/water-cut1.0_GMX50_bare/3072/water.tpr .
```

Verify that the file is present:

```bash
ls -lh water.tpr
```

Verify that both `water.tpr` and `test_gromacs_gpu.sh` are located in the same directory before submitting the job:

```bash
ls -lh water.tpr test_gromacs_gpu.sh
```

Expected output:

```text
-rw-r--r-- ... water.tpr
-rwxr-xr-x ... test_gromacs_gpu.sh
```

Both files should be listed successfully. If either file is missing, ensure that `water.tpr` has been copied to the directory containing `test_gromacs_gpu.sh` before proceeding.

## 6. Submit the GPU Test Job

Run the test script using Slurm:

```bash
sbatch test_gromacs_gpu.sh
```

A successful submission should return output similar to:

```text
Submitted batch job <JOB_ID>
```

## 7. Start GPU Temperature Logging

After the job has been submitted, start GPU temperature logging:

```bash
./log_gpu_temp.sh
```

## 8. Monitor GPU Utilization

Open a separate terminal and monitor GPU activity using one of the following tools.

### Option A: NVIDIA SMI

```bash
nvidia-smi
```

For continuous monitoring:

```bash
watch -n 1 nvidia-smi
```

### Option B: NVTOP

If available:

```bash
nvtop
```

## 9. Verify Successful Execution

Confirm the following:

1. The Spack environment loaded successfully.
2. `spack find gromacs+cuda` returns an installed package.
3. If required, `spack install gromacs+cuda` completed successfully.
4. GROMACS was loaded successfully using `spack load gromacs+cuda`.
5. The benchmark dataset was downloaded and extracted successfully.
6. The `water.tpr` file was generated successfully using `gmx_mpi grompp`.
7. The `water.tpr` file was copied to the directory containing `test_gromacs_gpu.sh`.
8. Both `water.tpr` and `test_gromacs_gpu.sh` were verified to be in the same directory.
9. The test job was submitted and returned `Submitted batch job <JOB_ID>`.
10. Temperature logging started successfully using `./log_gpu_temp.sh`.
11. GPU utilization is visible in `nvidia-smi` or `nvtop`.
12. GPU memory usage and compute utilization increase while the GROMACS test is running.

## 10. Useful Commands

Check job status:

```bash
squeue -u $USER
```

View job details:

```bash
scontrol show job <JOB_ID>
```

Cancel a job if needed:

```bash
scancel <JOB_ID>
```

