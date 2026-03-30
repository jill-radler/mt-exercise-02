import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path

log_direction = Path("logs")
result_direction = Path("results")
result_direction.mkdir(exist_ok=True)

def main():
    all_df = []

    for file in sorted(log_direction.glob("log_dropout_*.csv")):
        dropout = file.stem.replace("log_dropout_", "")

        df = pd.read_csv(file)

        test_row = df[df["epoch"] == "test"]
        test_ppl = float(test_row["test_ppl"].values[0])

        df = df[df["epoch"] != "test"].copy()
        df["epoch"] = df["epoch"].astype(int)

        df["dropout"] = dropout
        df["test_ppl"] = test_ppl

        all_df.append(df)
    
    full_df = pd.concat(all_df)

    #Table
    test_table = full_df.groupby("dropout")["test_ppl"].first().reset_index()
    test_table.to_csv(result_direction / "test_table.csv", index=False)

    train_table = full_df.pivot(index="epoch", columns="dropout", values="train_ppl")
    train_table.to_csv(result_direction / "train_table.csv")

    valid_table = full_df.pivot(index="epoch", columns="dropout", values="valid_ppl")
    valid_table.to_csv(result_direction / "valid_table.csv")

    #Train plot
    plt.figure()
    for d, group in full_df.groupby("dropout"):
        plt.plot(group["epoch"], group["train_ppl"], label=f"dropout={d}")
    plt.xlabel("Epoch")
    plt.ylabel("Training Perplexity")
    plt.title("Training Perplexity")
    plt.legend()
    plt.savefig(result_direction / "train_plot.png")
    plt.close()

    #Validation plot
    plt.figure()
    for d, group in full_df.groupby("dropout"):
        plt.plot(group["epoch"], group["valid_ppl"], label=f"dropout={d}")
    plt.xlabel("Epoch")
    plt.ylabel("Validation Perplexity")
    plt.title("Validation Perplexity")
    plt.legend()
    plt.savefig(result_direction / "valid_plot.png")
    plt.close()


if __name__ == "__main__":
    main()





