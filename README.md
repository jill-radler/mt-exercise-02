# MT Exercise 2: Pytorch RNN Language Models

This repo shows how to train neural language models using [Pytorch example code](https://github.com/pytorch/examples/tree/master/word_language_model). Thanks to Emma van den Bold, the original author of these scripts. 

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/marcamsler1/mt-exercise-02
    cd mt-exercise-02

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/install_packages.sh

Download and preprocess data:

    ./scripts/download_data.sh

Train a model:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Generate (sample) some text from a trained model with:

    ./scripts/generate.sh


# Task 1 Training a recurrent neural network language model

I modified the data preparation to use custom dataset instead of the default one.

Changes made:

- Replaced the Grimm dataset in download_data.sh
- Downloaded three texts from Project Gutenberg using 'curl'(better for MAC)
    - Alice's adventure in Wonderland
    - Through the Looking-Glass
    - Sylvie and Bruno
- Combined those into a single dataset
- Limited the vocabulary size to 5000
- Split the dataset into the 3 segments

Commands: in this order

    ./scripts/download_data.sh
    ./scripts/train.sh
    ./scripts/generate.sh


Training:

- Updated the train.sh to use "data/alice" instead of the grimm one

Generation:

- Again, updated the generate.sh to load the model and generate text.

# Task 2 Parameter tuning: Experimenting with dropout

Changes made:

- In main_modified.py
    - added the "--log-file" argument
    - logs training, validation and test perplexities to csv files
- In train.sh
    - modified it to train models with dropout values 0.0,0.2,0.4,0.6,0.8
    - saves one model and logfile per dropout
- log_plots.py
    - read the csv log files
    - creates tables and plots for training


Commands:

- ./scripts/download_data.sh
- ./scripts/train.sh
- python scripts/log_plots.py
- ./scripts/generate.sh models/model_dropout_0.2.pt best.txt
- ./scripts/generate.sh models/model_dropout_0.8.pt worst.txt

please note: I did install additional packages for the plots and tables: pip install pandas, matplotlib

Important outputs:

- Trained models:
    - models/model_dropout_0.0.pt
    - model_dropout_0.2.pt
    - model_dropout_0.4.pt
    - model_dropout_0.6.pt
    - model_dropout_0.8.pt

- Log files:
    - logs/log_dropout_0.0.csv
    - log_dropout_0.2.csv
    - log_dropout_0.4.csv
    - log_dropout_0.6.csv
    - log_dropout_0.8.csv

- Tables and plots:
    - results/train_table.csv
    - valid_table.csv
    - test_table.csv
    - train_plot.png
    - valid_plot.png

Creation of tables:
I did convert the csv files into tables in Excel. This was for me, the simplest way to do it. 

- Generated samples:
    - samples/best.txt
    - worst.txt

