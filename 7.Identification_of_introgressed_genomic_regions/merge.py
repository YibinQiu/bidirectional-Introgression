"""
"""

import os,sys,argparse

parser=argparse.ArgumentParser()
parser.add_argument('-i',"--input", help = "Input file merged from several results of beagle IBD", required = True)
parser.add_argument('-c',"--chr",help="Chromosome number",required = True)
parser.add_argument('-o',"--output",help="Output file",required = True)
args=parser.parse_args()

file = args.input
ch = args.chr
out = args.output

ibdfile=open(file)
dat=[i.replace("\n","").split(" ") for i in ibdfile]
mergeDat=open(out, "w")

tmp=[]
for i in range(0,len(dat)):
#    print("i="+str(i))
    ids1=dat[i][0:3]
    if i != (len(dat)-1):
        ids2=dat[i+1][0:3]
    tmp.append([int(dat[i][4])]+dat[i])
    if ids1 != ids2 or i==len(dat)-1:
        tmp.sort()
        mergeRegion=[]
        for j in range(0,len(tmp)-1):
#            print("j="+str(j))
            if len(mergeRegion)==0:
                mergeRegion=tmp[j][1:7]
            start1=int(mergeRegion[4])
            end1=int(mergeRegion[5])
            start2=int(tmp[j+1][5])
            end2=int(tmp[j+1][6])
            if start2 >= end1:
                mergeDat.write(mergeRegion[0]+" "+mergeRegion[1]+" ")
                mergeDat.write(mergeRegion[2]+" "+mergeRegion[3]+" ")
                mergeDat.write(str(mergeRegion[4])+" "+str(mergeRegion[5])+"\n")
                mergeRegion=[]
            if start2 < end1:
                mergeRegion=tmp[j][1:5]+[start1]+[max(end1,end2)]
        if len(mergeRegion)==0:
            mergeRegion=tmp[len(tmp)-1][1:7]
            mergeDat.write(mergeRegion[0]+" "+mergeRegion[1]+" ")
            mergeDat.write(mergeRegion[2]+" "+mergeRegion[3]+" ")
            mergeDat.write(str(mergeRegion[4])+" "+str(mergeRegion[5])+"\n")
        tmp=[]

mergeDat.close()
