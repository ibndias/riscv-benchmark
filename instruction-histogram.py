#!/usr/bin/python

import pandas as pd
import numpy as np
import os
import sys
import pdb
from scipy.stats.mstats import gmean

def loadcsv(name):
    return pd.read_csv(name, header=None, sep="=", index_col=0)

def out(matrix, name):
  if matrix is not None:
    matrix.axes[1].name = "Name"
    #mmodel = addmodel(matrix).transpose()
    mt = matrix.transpose()
    #mt.to_latex("data/" + name + ".tex")
    mt.to_csv(name + ".csv", float_format='%.1f')
    print ""
    print "Benchmark " + name
    print mt

def beautify(name):
    bname = name.replace('results/','')
    bname = bname.replace('.hist','')
    # Make names shorter
    bname = bname.replace("complex", "cmplx")
    bname = bname.replace("sglib-array", "sglib-")
    bname = bname.replace("listinsertsort", "listinssort")
    return bname.lower()


base = None

for (dirpath, dirnames, filenames) in os.walk('results'):
    base = [dirpath+'/'+i for i in filenames if '.hist' in i]
    #model1 = [dirpath+'/'+i for i in filenames if 'model1.hist' in i]
    #model2 = [dirpath+'/'+i for i in filenames if 'model2.hist' in i]


df = None

for name in base:
    obj = loadcsv(name)
    obj = obj.rename({1: beautify(name)}, axis='columns')
    if df is None:
        df = obj
    else:
        df = pd.concat([df, obj], axis=1, sort=False)

df.axes[1].name = "Name"
df = df.reindex(['slli','srli','ld','st','mul','div','reg','ecall','others'])
df = df.fillna(0).astype('Int64')
out(df, "performance")
