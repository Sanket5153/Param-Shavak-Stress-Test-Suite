# HPL Stress Test and Node Health Monitoring

## Overview

This package provides:

1. HPL-based system stress testing for long-duration validation (24/72 hours).
2. CPU temperature and frequency monitoring during benchmark execution.
3. Logging of benchmark and monitoring data for post-run analysis.

---

## Prerequisites

Install lm_sensors:

```bash
sudo dnf install lm_sensors
```

or

```bash
sudo apt install lm-sensors
```

Verify sensors are available:

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

Edit the following file:

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
source node_health_monitoring.sh
```

The script continuously records:

* Timestamp
* CPU Temperature
* Average CPU Frequency

Monitoring data is collected every 10 seconds by default.

To modify the sampling interval, edit:

```bash
sleep 10
```

at the end of `node_health_monitoring.sh`.

---

## Monitoring Logs

Monitoring data is stored in:

```bash
LOGS/MONITOR_LOG/node_health.csv
```

View the collected data:

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

`summary.log` contains the start time, finish time, and exit status of each benchmark run.

---

## Cancelling a Running Job

Find the job ID:

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

## Purpose

This framework is intended for:

* 24-hour burn-in testing
* 72-hour stability testing
* Thermal throttling detection
* CPU frequency drop analysis
* HPC node health validation
* Pre-deployment cluster qualification
