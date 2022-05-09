# Useage: python run-trim.py [illumina or mgi]  [path to sample csv]

import os
import subprocess
import sys
import pandas as pd

if len(sys.argv) != 3:
    raise Exception("Bad number of arguements")

csv_file = pd.read_csv(sys.argv[2])

for i, row in csv_file.iterrows():
    if sys.argv[1] == "illumina":
        qsub_args = ["qsub", "trim_illumina.sh", row.id, row.r1, row.r2]
    elif sys.argv[1] == "prism":
        qsub_args = ["qsub", "trim_prism.sh", row.id, row.r1, row.r2]
    elif sys.argv[1] == "mgi": 
        qsub_args = ["qsub", "trim_mgi.sh", row.id, row.r1, row.r2]
    else:
        raise Exception("You have to spefify either illumina or mgi")
    print(qsub_args)
    subprocess.run(qsub_args)

