import csv
import os
import statistics
import matplotlib.pyplot as plt


SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_ROOT = os.path.dirname(SCRIPT_DIR)
DATA_DIR = os.path.join(PROJECT_ROOT, "data")
DOCS_DIR = os.path.join(PROJECT_ROOT, "docs")

os.makedirs(DOCS_DIR, exist_ok=True)

METHODS = ["ijk", "ikj", "jik", "jki", "kij", "kji"]
COLORS  = ["#0072B2", "#E69F00", "#009E73", "#D55E00", "#CC79A7", "#56B4E9"]
MARKERS = ["o", "s", "^", "D", "v", "P"]

def plot_orders(csv_filename, output_image, title):
    csv_path = os.path.join(DATA_DIR, csv_filename)
    output_path = os.path.join(DOCS_DIR, output_image)

    if not os.path.exists(csv_path):
        print(f"Файл {csv_path} не найден, пропускаем...")
        return

    data = {}
    with open(csv_path, encoding="utf-8") as f:
        for row in csv.DictReader(f):
            key = (row["method"], int(row["n"]))
            data.setdefault(key, []).append(float(row["seconds"]))

    plt.figure(figsize=(8, 6))

    for method, color, marker in zip(METHODS, COLORS, MARKERS):
        ns = sorted(n for (m, n) in data if m == method)
        if not ns:
            continue
        med = [statistics.median(data[(method, n)]) for n in ns]
        plt.plot(ns, med, marker=marker, color=color, label=method, linewidth=1.5)

    plt.xscale("log")
    plt.yscale("log")
    plt.xlabel("Размер матрицы n", fontsize=11)
    plt.ylabel("Медиана времени, с", fontsize=11)
    plt.title(title, fontsize=12)
    plt.legend()
    plt.grid(True, which="both", linestyle="--", alpha=0.6)
    plt.tight_layout()
    plt.savefig(output_path, dpi=150)
    plt.close()
    print(f"График сохранен: {output_path}")


plot_orders("matmul.csv", "matmul-orders.png", "C (-O2)")
plot_orders("matmulO0.csv", "matmul-orders-O0.png", "C (-O0)")
plot_orders("matmulO3.csv", "matmul-orders-O3.png", "C (-O3 -march=native)")
