#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# link default training data for easier access

mkdir -p $data/wikitext-2

for corpus in train valid test; do
    absolute_path=$(realpath $tools/pytorch-examples/word_language_model/data/wikitext-2/$corpus.txt)
    ln -snf $absolute_path $data/wikitext-2/$corpus.txt
done

# download a different interesting data set!

mkdir -p $data/alice

mkdir -p $data/alice/raw

curl -L https://www.gutenberg.org/cache/epub/11/pg11.txt -o pg11.txt
curl -L https://www.gutenberg.org/cache/epub/12/pg12.txt -o pg12.txt
curl -L https://www.gutenberg.org/cache/epub/620/pg620.txt -o pg620.txt
mv pg11.txt $data/alice/raw/alice1.txt
mv pg12.txt $data/alice/raw/alice2.txt
mv pg620.txt $data/alice/raw/alice3.txt

cat $data/alice/raw/alice1.txt $data/alice/raw/alice2.txt  $data/alice/raw/alice3.txt > $data/alice/raw/alice_combined.txt

# preprocess slightly

cat $data/alice/raw/alice_combined.txt | python $base/scripts/preprocess_raw.py > $data/alice/raw/alice.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/alice/raw/alice.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > \
    $data/alice/raw/alice.preprocessed.txt

# split into train, valid and test

head -n 598 $data/alice/raw/alice.preprocessed.txt > $data/alice/valid.txt
head -n 1196 $data/alice/raw/alice.preprocessed.txt | tail -n 598 > $data/alice/test.txt
tail -n 4786 $data/alice/raw/alice.preprocessed.txt > $data/alice/train.txt
