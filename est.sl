#! /bin/bash -l
#SBATCH -J aaa-bbb-ccc
#SBATCH --output=aaa-bbb-ccc.out
#SBATCH -N 1
#SBATCH --ntasks-per-node=2
#SBATCH --mem 100
#SBATCH --time 7-0
#SBATCH -A G74-3
#SBATCH -p topola
#SBATCH --mail-type=ALL

# TODO: In -J option set model name, ppopsize, and estimation type, e.g.: main-10k-u
# TODO: Set --output with log file name
# TODO: Set ppopsize here again
PPOPSIZE=10000
# TODO: Model specification name, e.g. main, diffhom...
MODEL=main


# `parallel` will be --ntasks-per-node - 1
let "PARALLEL = SLURM_NTASKS_PER_NODE - 1"




MYJOB=$SLURM_JOBID

# Submit subsequent job for GOF
echo MODELFILE=${SLURM_JOB_NAME}.rds sbatch -J ${SLURM_JOB_NAME}-gof --dependency=afterok:$MYJOB --output=${SLURM_JOB_NAME}-gof.out gof.sl

# Load modules
module load apps/r/3.5.1

# Estimate
echo run_estimate.R -n -m ${MODEL} -e "parallel=${PARALLEL}" -c "ppopsize=${PPOPSIZE}" -o ${SLURM_JOB_NAME}.rds

