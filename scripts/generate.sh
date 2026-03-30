#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

data=$base/data
tools=$base/tools
samples=$base/samples
models=$base/models

mkdir -p $samples

num_threads=4
device=""

checkpoint=$(realpath $1)
outfile=$2

(cd $tools/pytorch-examples/word_language_model &&
    CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python generate.py \
        --data $data/alice \
        --words 100 \
        --checkpoint $checkpoint \
        --outf $samples/$outfile
)
