# Useage: python run-trim.py [illumina or mgi]  [path to sample csv]

import os
import subprocess
import sys
import csv

if len(sys.argv) != 3:
    raise Exception("Bad number of arguements")

os.makedirs("qc", exist_ok=True)

with open(sys.argv[2], "r", encoding='utf-8-sig') as f:
    csv_reader = csv.DictReader(f)

    for row in csv_reader:
        if sys.argv[1] == "illumina":
            qsub_args = ["qsub", "trim_illumina.sh", row["id"], row["r1"], row["r2"]]
        elif sys.argv[1] == "prism":
            qsub_args = ["qsub", "trim_prism.sh", row["id"], row["r1"], row["r2"]]
        elif sys.argv[1] == "mgi": 
            qsub_args = ["qsub", "trim_mgi.sh", row["id"], row["r1"], row["r2"]]
        else:
            raise Exception("You have to spefify either illumina or mgi")
        print(qsub_args)
        subprocess.run(qsub_args)

