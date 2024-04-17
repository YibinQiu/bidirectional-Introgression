#
rm(list=ls());options(stringsAsFactors=FALSE)
setwd("/home/qiuyb/China_pigs/rIBD/0.data")

indInfo = read.table(file = "indInfo_SCN.txt",header = T,sep = "\t")
#pop1 = "PDB";pop2 = "LW"
setwd("/home/qiuyb/China_pigs/rIBD/1.IBD")
args = commandArgs(T)
pop1 = args[1]
pop2 = args[2]

group1 = subset(indInfo,group == pop1)[,"ID"]
group2 = subset(indInfo,group == pop2)[,"ID"]
newID1 = subset(indInfo,group == pop1)[,"newID"]
newID2 = subset(indInfo,group == pop2)[,"newID"]
cat("group1 list:","\n")
cat(group1,"\n")
cat("group1 newIDlist:","\n")
cat(newID1,"\n")
cat("*********************************************************")
cat("group2 list:","\n")
cat(group2,"\n")
cat("group2 newIDlist:","\n")
cat(newID2,"\n")
cat("*********************************************************")
N1 = 2*length(group1);N2 = 2*length(group2)
N = N1*N2

#chrs=c(1:18,23)
chrs=c(1:18)
#chrlens=c(274330532,151935994,132848913,130910915,104526007,170843587,121844099,138966237,139512083,69359453,79169978,61602749,208334590,141755446,140412725,79944280,63494081,55982971,125939595)
chrlens=c(274330532,151935994,132848913,130910915,104526007,170843587,121844099,138966237,139512083,69359453,79169978,61602749,208334590,141755446,140412725,79944280,63494081,55982971)
names(chrlens) = chrs

binSize = 50000
overlap = 25000
tmp = NULL
for(ch in chrs){
    filename = paste("CHR_",ch,".ibd.merge",sep = "")
    dat = read.table(filename,header = F)
    #list1 = strsplit(as.character(dat[,"V1"]),"_")
    #list1Clean = lapply(list1,
    #                  function(x){
    #                     names = x[2:length(x)]
    #                     if(length(names) == 1) return(names)
    #                     else return(paste(names,collapse = "_"))
    #                  })
    #nm1 = do.call(c,list1Clean)
    nm1=c(dat[,"V1"])
    #list2 = strsplit(as.character(dat[,"V2"]),"_")
    #list2Clean = lapply(list2,
    #                  function(x){
    #                     names = x[2:length(x)]
    #                     if(length(names) == 1) return(names)
    #                     else return(paste(names,collapse = "_"))
    #                  })
    #nm2 = do.call(c,list2Clean)
    nm2=c(dat[,"V2"])
    dat2analy = subset(dat,((nm1 %in% group1) & (nm2 %in% group2)) | ((nm1 %in% group2) & (nm2 %in% group1)))
    dat2analy = dat2analy[order(dat2analy[,5]),]
    i = 0
    d = 2000
    while((i+1)*(binSize/2) < chrlens[names(chrlens) == ch]){
        start = i*(binSize - overlap)
        end = binSize + i*(binSize - overlap)
        if(end > chrlens[names(chrlens) == ch]){
            end = chrlens[names(chrlens) == ch]
            cat(ch,":",start,"-",end,"\n")}
        tmpDat = subset(dat2analy,!(V6 < (start + d) | V5 > (end - d)))
        tmp = rbind(tmp,c(ch,start,end,nrow(tmpDat)/N))
        i = i+1
    }
   cat("chromosome",ch,"have been done!","\n")
}
setwd("/home/qiuyb/China_pigs/rIBD/2.nIBD")
write.table(tmp,file = paste(pop1,"_",pop2,"_50kbin_25koverlap.nIBD",sep = ""),col.names = F,row.names = F,quote = F)
