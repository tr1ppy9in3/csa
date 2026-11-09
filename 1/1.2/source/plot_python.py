import csv
import os

import matplotlib.pyplot as plt

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, "..", "data"))
DOCS_DIR = os.path.abspath(os.path.join(SCRIPT_DIR, "..", "docs"))
os.makedirs(DOCS_DIR, exist_ok=True)
csv_path = os.path.join(DATA_DIR, "python-matmul.csv")
img_path = os.path.join(DOCS_DIR, "python-matmul.png")

with open(csv_path, "r", encoding="utf-8") as f:
    rows = list(csv.DictReader(f))

xs = [int(r["run"]) for r in rows]
ys = [float(r["seconds"]) for r in rows]

plt.plot(xs, ys, "o-")
plt.xlabel("запуск")
plt.ylabel("время, с")
plt.title("Python: умножение матриц 256x256")
plt.grid(True)
plt.savefig(img_path, dpi=150)
plt.close()
