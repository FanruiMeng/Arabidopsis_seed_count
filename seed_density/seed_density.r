setwd("C:\\Users\\Fanrui Meng\\Desktop\\crowd_density")
all_seeds <- read.table("seeds_labels.csv",stringsAsFactors=F,sep=",",header=FALSE)

imgs <- unique(all_seeds[,1])

for(i in imgs){
	seeds <- subset(all_seeds,all_seeds[,1]==i)
	seeds[,9]<-(seeds[,5]+seeds[,7])/2
	seeds[,10]<-(seeds[,6]+seeds[,8])/2
	#每个种子中心点30个像素圈里种子数
	column <- c()
	for(i in  1:nrow(seeds)){
		tem<-c()
		for(j in 1:nrow(seeds)){
			tem<-cbind(tem,sqrt((seeds[i,9]-seeds[j,9])*(seeds[i,9]-seeds[j,9])+(seeds[i,10]-seeds[j,10])*(seeds[i,10]-seeds[j,10])))
		}
		#distance <- rbind(distance,tem)
		newdata <- subset(tem[1,],tem[1,]<30)
		# if(length(newdata)>=3){
			# column <- cbind(column,i)
		# }
		
		column <- cbind(column,length(newdata))
	}
	imgs<-rbind(imgs,mean(column[1,]))
}

write.table(imgs, "all_imgs_seeds_density.txt", sep=',',row.names=F,col.names=F)
