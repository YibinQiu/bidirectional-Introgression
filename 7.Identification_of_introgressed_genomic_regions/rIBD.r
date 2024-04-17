rm(list=ls());options(stringsAsFactors=FALSE,shiny.usecairo = FALSE)

options(scipen=20)
####################################################################
# Manhattan plot WGS
####################################################################
source("/home/qiuyb/China_pigs/rIBD/0.data/manhattanPlot_2colors.r")

args = commandArgs(T)
file1 = args[1]
file2 = args[2]


setwd("/home/qiuyb/China_pigs/rIBD/2.nIBD")
#file1="FLW_TH";file2="FLW_EWB";file3="FLW_OUT"
cat(paste(file1,"_50kbin_25koverlap.nIBD",sep=""),"used","\n")
dat1=read.table(file=paste(file1,"_50kbin_25koverlap.nIBD",sep=""),header=F)
cat(paste(file2,"_50kbin_25koverlap.nIBD",sep=""),"used","\n")
dat2=read.table(file=paste(file2,"_50kbin_25koverlap.nIBD",sep=""),header=F)
datOut=data.frame(chr=dat1[,1],start=dat1[,2],end=dat1[,3],rIBD=dat1[,4]-dat2[,4])
setwd("/home/qiuyb/China_pigs/rIBD/3.rIBD")
#dat3=read.table(file=paste(file3,".nIBD",sep=""),header=F)
datPlot = data.frame(chr=dat1[,1],pos=(dat1[,2]+dat1[,3])/2,rIBD=dat1[,4]-dat2[,4])
#datPlot = data.frame(chr=dat1[,1],pos=(dat1[,2]+dat1[,3])/2,rIBD=dat1[,4]-dat2[,4]-dat3[,4])
datPlot <- datPlot[datPlot$chr != 23,]
datOut <- datOut[datOut$chr !=23,]
colnames(datPlot)[2]="pos"
# dat1 = datPlot
#f="FLW_TH-EWB-OUT"
f=paste(file1,"-",file2,sep="")

# threshold=quantile(datPlot$rIBD, 0.95)
# png(paste(f,"_top5.png",sep=""),height=3000, width=11000, res=400)
# par(mai=c(1,1.2,0.5,0.5))
# manhattanPlot(chrs=1:19, dat=datPlot, trait="rIBD", ylab="rIBD")
# abline(h=threshold, lty=2)
# dev.off()
# datOut=dat1[dat1$rIBD>=threshold,]
# write.table(datOut, file=paste(f,"_top5.txt",sep=""), col.names=TRUE, row.names=FALSE, quote=FALSE)

threshold=quantile(datPlot$rIBD, 0.99)
cat("threshold:",threshold,"\n")
png(paste(f,"_top1.png",sep=""),height=3000, width=11000, res=400)
par(mai=c(1,1.2,0.5,0.5))
manhattanPlot(chrs=1:18, dat=datPlot, trait="rIBD", ylab="rIBD")
abline(h=threshold, lty=2)
abline(h=0.2,lty=1)
dev.off()
datOut1=datOut[datOut$rIBD>=threshold,]
# datOut2=datOut[datOut$rIBD>=0.1,]
datOut3=datOut[datOut$rIBD>=0.2,]
write.table(datOut1, file=paste(f,"_top1.txt",sep=""), col.names=TRUE, row.names=FALSE, quote=FALSE)
# write.table(datOut2, file=paste(f,"_01.txt",sep=""), col.names=TRUE, row.names=FALSE, quote=FALSE)
write.table(datOut3, file=paste(f,"_02.txt",sep=""), col.names=TRUE, row.names=FALSE, quote=FALSE)
write.table(datOut, file=paste(f,"_all.txt",sep=""), col.names=TRUE, row.names=FALSE, quote=FALSE)
# dat1$std_rIBD=scale(dat1$rIBD)
# threshold= mean(dat1$std_rIBD)+2*sd(dat1$std_rIBD)
# datOut = dat1[dat1$std_rIBD>=threshold,]
# datOut$thr = nrow(datOut)/nrow(dat1)*100
# threshold = quantile(dat1$rIBD, 1-nrow(datOut)/nrow(dat1))
# write.table(datOut, file=paste(f,"_2sd.txt",sep=""), quote=FALSE, row.names=FALSE, col.names=TRUE)
# png(paste(f,"_2sd.png",sep=""),height=3000, width=11000, res=400)
# par(mai=c(1,1.2,0.5,0.5))
# manhattanPlot(chrs=1:19, dat=datPlot, trait="rIBD", ylab="rIBD")
# abline(h=threshold, lty=2)
# dev.off()

# a <- hist(as.numeric(dat1$std_rIBD), breaks=80, plot=F)
# png(paste(f,"_hist.png",sep=""),height=2000,width=3000,res=300)
# par(mai=c(1,1.2,0.5,0.5))
# plot(a, col=rainbow(7,alpha=0.8), xlim=c(min(dat1$std_rIBD),max(dat1$std_rIBD)),
    # xlab="Normalized rIBD", ylab="Counts", cex.lab=2, cex.axis=2)
# abline(v=2, col="black", lty=2)
# dev.off()

cat("rIBD","have been done!")
