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


# Custom Dataset (Task 1)

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