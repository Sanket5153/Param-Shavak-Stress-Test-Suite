#!/bin/bash

# ============================================================
# HPL Parameter Generator Script
# Made by Sanket Thakare
# Automatically generates:
#   1. HPL.dat
#   2. parameters.txt
# ============================================================

clear

echo "======================================="
echo "        HPL Parameter Generator        "
echo "======================================="
echo ""

# ------------------------------------------------------------
# RAM Selection
# ------------------------------------------------------------

echo "Select RAM input method:"
echo "1) Automatic RAM Detection"
echo "2) Manual RAM Input (in GB)"
echo ""

read -p "Enter option [1-2]: " option

if [ "$option" -eq 1 ]; then

    ram=$(free -b | grep Mem: | awk '{print $2}')

    echo ""
    echo "Automatically detected RAM: $ram Bytes"

elif [ "$option" -eq 2 ]; then

    read -p "Enter RAM in GB: " ram_gb

    ram=$(( ram_gb * 1024 * 1024 * 1024 ))

    echo ""
    echo "RAM entered: $ram_gb GB"

else
    echo "Invalid option selected."
    exit 1
fi

echo ""
echo "Total RAM used for calculation: $ram Bytes"
echo ""

# ------------------------------------------------------------
# Calculate N
# ------------------------------------------------------------

val=$(( ram / 8 ))

square_root=$(echo "$val" | awk '{print int(sqrt($1))}')

# ------------------------------------------------------------
# Efficiency
# ------------------------------------------------------------

read -p "Enter efficiency percentage: " efficiency

Eff=$(( square_root * efficiency / 100 ))

echo ""
echo "Working on data for $efficiency % efficiency"
echo ""

# ------------------------------------------------------------
# Block Size
# ------------------------------------------------------------

read -p "Enter block size (NB): " NB

echo ""
echo "Block size given is: $NB"
echo ""

N_size=$(( Eff / NB ))

N=$(( N_size * NB ))

echo "Final value of N: $N"
echo ""

# ------------------------------------------------------------
# MPI Parameters
# ------------------------------------------------------------

read -p "Enter number of process rows (P): " P

read -p "Enter number of process columns (Q): " Q

read -p "Enter total MPI processes: " MPI

echo ""

# ------------------------------------------------------------
# Export Variables
# ------------------------------------------------------------

export NB
export N
export P
export Q
export MPI

# ------------------------------------------------------------
# Create parameters.txt
# ------------------------------------------------------------

cat > parameters.txt << EOF
==============================
HPL Parameters
==============================

RAM_BYTES=$ram
EFFICIENCY=$efficiency

N=$N
NB=$NB

P=$P
Q=$Q

MPI_PROCESSES=$MPI
EOF

echo "parameters.txt created successfully."
echo ""

# ------------------------------------------------------------
# Create HPL.dat
# ------------------------------------------------------------

cat > HPL.dat << EOF
HPLinpack benchmark input file
Innovative Computing Laboratory, University of Tennessee
HPL.out
6            device out (6=stdout,7=stderr,file)
1            # of problems sizes (N)
$N Ns
1            # of NBs
$NB NBs
0            PMAP process mapping (0=Row-,1=Column-major)
1            # of process grids (P x Q)
$P Ps
$Q Qs
16.0         threshold
3            # of panel fact
2            PFACTs (0=left, 1=Crout, 2=Right)
1            # of recursive stopping criteria
2            NBMINs (>= 1)
1            # of panels in recursion
2            NDIVs
1            # of recursive panel fact.
1            RFACTs (0=left, 1=Crout, 2=Right)
1            # of broadcast
1            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
1            # of lookahead depth
1            DEPTHs (>=0)
2            SWAP (0=bin-exch,1=long,2=mix)
64           swapping threshold
0            L1 in (0=transposed,1=no-transposed) form
0            U  in (0=transposed,1=no-transposed) form
1            Equilibration (0=no,1=yes)
8            memory alignment in double (> 0)
EOF

echo "HPL.dat created successfully."
echo ""

# ------------------------------------------------------------
# Display Final Parameters
# ------------------------------------------------------------

echo "======================================="
echo "         Final HPL Parameters          "
echo "======================================="
echo "N                : $N"
echo "NB               : $NB"
echo "P                : $P"
echo "Q                : $Q"
echo "MPI Processes    : $MPI"
echo "======================================="
echo ""
