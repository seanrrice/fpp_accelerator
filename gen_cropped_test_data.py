from pathlib import Path
import csv
from PIL import Image
# ===================================================================
# Creates a test dataset (original set cropped to 64x64) for faster testing. Adjust the settings below as needed.
#==================================================================
# ====== settings ======
SRC_DIR = Path("TestData")
DST_DIR = Path("TestData_small")
NDATASETS = 6
NSTEPS = 5

CROP_H = 64
CROP_W = 64
# ======================

DST_DIR.mkdir(exist_ok=True)

def crop_csv(src_path: Path, dst_path: Path, crop_h: int, crop_w: int):
    rows = []
    with open(src_path, "r", newline="", encoding="utf-8") as f:
        reader = csv.reader(f)
        for row in reader:
            rows.append(row)

    cropped = [row[:crop_w] for row in rows[:crop_h]]

    with open(dst_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerows(cropped)

for ds in range(NDATASETS):
    print(f"Processing dataset {ds}...")

    # Crop PNG stack
    for k in range(NSTEPS):
        src_img = SRC_DIR / f"stack_{ds}_{k}.png"
        dst_img = DST_DIR / f"stack_{ds}_{k}.png"

        img = Image.open(src_img)
        cropped = img.crop((0, 0, CROP_W, CROP_H))  # (left, top, right, bottom)
        cropped.save(dst_img)

    # Crop reference CSVs
    src_phi = SRC_DIR / f"phi_{ds}.csv"
    dst_phi = DST_DIR / f"phi_{ds}.csv"
    crop_csv(src_phi, dst_phi, CROP_H, CROP_W)

    src_mod = SRC_DIR / f"mod_{ds}.csv"
    dst_mod = DST_DIR / f"mod_{ds}.csv"
    crop_csv(src_mod, dst_mod, CROP_H, CROP_W)

print("Done. Cropped dataset written to", DST_DIR)