import os, h5py
from tqdm import tqdm
import pandas as pd

def split_data():
    df = pd.read_csv('dataset/data/data.csv')
    # df.info()
    X_df = df.iloc[:,:-2]
    Y_df = df.iloc[:,-2:]

split_data()