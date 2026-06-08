# Param Shavak Stress Test Framework

## Overview

This package provides:

1. HPL-based system stress testing for long-duration validation (24/72 hours)
2. CPU temperature and frequency monitoring during benchmark execution
3. Logging of benchmark and monitoring data for post-run analysis

---

## Prerequisites

### 1. Load the Spack Environment

Before running any commands, load the Spack environment:

```bash
source /home/apps/spack/share/spack/setup-env.sh
```

Verify Spack is available:

```bash
spack --version
```

---

### 2. Verify HPL Installation

Check whether HPL is already installed:

```bash
spack find hpl
```

If HPL is not installed, install it using:

```bash
spack install hpl
```

Load HPL:

```bash
spack load hpl
```

Verify the executable:

```bash
which xhpl
```

Example output:

```bash
/path/to/xhpl
```

---

### 3. Install lm_sensors

Rocky Linux / RHEL:

```bash
sudo dnf install lm_sensors
```

Ubuntu / Debian:

```bash
sudo apt install lm-sensors
```

Verify sensor data:

```bash
sensors
```

---

## Setup

Make all scripts executable:

```bash
chmod +x *.sh

cd Scripts
chmod +x *.sh
cd ..
```

---

## Configuring HPL Stress Test Duration

Edit:

```bash
Scripts/stress_test_hpl.sh
```

Modify:

```bash
DURATION_HOURS=24
```

Examples:

```bash
DURATION_HOURS=24
```

Runs the benchmark for 24 hours.

```bash
DURATION_HOURS=72
```

Runs the benchmark for 72 hours.

---

## Running the Stress Test

Submit the SLURM job:

```bash
sbatch slurm_script_hpl_stress_test.sh
```

Check job status:

```bash
squeue -u $USER
```

---

## Running Node Health Monitoring

Start monitoring manually:

```bash
cd Scripts
./node_health_monitoring.sh
```

The script continuously records:

* Timestamp
* CPU Temperature
* Average CPU Frequency

By default, data is collected every 10 seconds.

To change the interval, edit:

```bash
sleep 10
```

inside:

```bash
Scripts/node_health_monitoring.sh
```

---

## Monitoring Logs

Monitoring data is stored in:

```bash
LOGS/MONITOR_LOG/node_health.csv
```

View:

```bash
cat LOGS/MONITOR_LOG/node_health.csv
```

Example:

```text
Timestamp,Temp_C,Avg_CPU_MHz
2026-06-08 11:00:00,65,2400
2026-06-08 11:00:10,66,2400
2026-06-08 11:00:20,68,2395
```

---

## HPL Benchmark Logs

Benchmark logs are stored in:

```bash
LOGS/HPL_LOG/
```

Files generated:

```text
summary.log
run_1.log
run_2.log
run_3.log
...
```

The `summary.log` file contains benchmark start time, finish time, and exit status for each run.

---

## Cancelling a Running Job

Find the Job ID:

```bash
squeue -u $USER
```

Cancel the job:

```bash
scancel <JOB_ID>
```

Example:

```bash
scancel 123456
```

---

## Output Directory Structure

```text
LOGS/
├── HPL_LOG/
│   ├── summary.log
│   ├── run_1.log
│   ├── run_2.log
│   └── ...
│
└── MONITOR_LOG/
    └── node_health.csv
```

---

## Use Cases

* 24-hour burn-in testing
* 72-hour stability testing
* Thermal throttling detection
* CPU frequency drop analysis
* HPC node health validation
* Cluster acceptance testing
* Pre-deployment system qualification
