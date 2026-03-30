#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools

mkdir -p $models
mkdir -p $base/logs 

num_threads=4
device=""

SECONDS=0

for dropout in 0.0 0.2 0.4 0.6 0.8   
do
     echo "Training with dropout=$dropout"
    (cd $tools/pytorch-examples/word_language_model &&
        CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python main.py --data $data/alice \
            --epochs 40 \
            --log-interval 100 \
            --emsize 200 --nhid 200 --dropout $dropout --tied \
            --save $models/model_dropout_${dropout}.pt \
            --log-file $base/logs/log_dropout_${dropout}.csv
    )
done
echo "time taken:"
echo "$SECONDS seconds"
