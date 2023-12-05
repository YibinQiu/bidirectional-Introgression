# 清空当前环境中的变量，并设置选项，将字符串作为因子处理
rm(list=ls());options(stringsAsFactors=FALSE)
# 指定文件夹路径和文件列表
folder_path <- "/home/qiuyb/dengsx/1.genetic_diversity/4.R2"
all_files <- list.files(folder_path)
pop_file <- grep("\\.txt$", all_files, value = TRUE)
ld_files = grep("\\.ld$", all_files, value = TRUE)
# 使用lapply函数遍历筛选后的文件列表，并进行文件读取
pop_list <- lapply(pop_file, function(file) {
  file_path <- file.path(folder_path, file)
  data <- read.table(file_path, header = FALSE, sep = "\t")
  return(data)
})
# 创建一个空矩阵来存储计算结果
criticalValue = matrix(,length(ld_files),4)
for(i in 1:length(ld_files)) {  
  if (nrow(pop_list[[i]]) > 4) {# 如果文件数据行数大于4
    dat = read.table(ld_files[i],header=TRUE)# 从文件读取数据
    distance = abs(dat[,5] - dat[,2])# 计算距离
    R2 = dat[,7]# 获取R2数据
    Beta.st=c(beta1=0.00001)# 设置起始估计值
    Beta.nonlinear = nls(R2~1/(1+4*beta1*distance),start=Beta.st,control=nls.control(maxiter=500)) # 进行非线性最小二乘拟合
    tt=summary(Beta.nonlinear)# 获取拟合结果的摘要统计
    Beta.est = tt$parameters[1]# 获取估计值
    Beta.error = tt$parameters[2]# 获取标准误
    criticalValue[i,1] = ld_files[i]
    criticalValue[i,2] = 0.7/(1.2*Beta.est*1000)          #0.3 = 1/(1+4*Beta.est*mkrs)存储计算结果
    criticalValue[i,3] = Beta.est# 存储估计值
    criticalValue[i,4] = Beta.error# 存储标准误
    cat(i,"\n") # 输出当前迭代次数
  } else {
    # 跳过当前迭代，继续下一次迭代
    cat("跳过当前循环\n")
    next
  }
}

colnames(criticalValue) = c("indID","0.3R2(kb)","estimate","std.error")
write.csv(criticalValue, file="criticalValue.csv", row.names=FALSE, quote=FALSE)
