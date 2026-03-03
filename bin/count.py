#!/usr/bin/env python3

# ghcr.io/bf528/pandas:latest 

# Create cli arguments for the concatenation of the VERSE output files to work
import argparse
parser = argparse.ArgumentParser(description='Concatenate VERSE output files')
parser.add_argument("-i", "--input", help='A list of the VERSE output', dest="input", required=True, nargs='+')
parser.add_argument("-o", "--output", help='The output file name and path provided by snakemake', dest="output", required=True)

args = parser.parse_args()


# Create a single count matrix
import pandas as pd
import os

x=[]
for line in args.input:
    sample_id = os.path.basename(line).split('.')[0]
    df=pd.read_csv(line, sep='\t', header=0)
    df.rename(columns={'count': sample_id}, inplace=True)
    df.set_index('gene', inplace=True)
    x.append(df)

concat = pd.concat(x, axis=1)
concat.to_csv(args.output)
