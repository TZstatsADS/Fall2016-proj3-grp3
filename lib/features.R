color_feature<-function(img_dir,data_name=NULL) {
##color feature

##color histogram
library(EBImage)
dir_names<-list.files(img_dir)
n_files<-length(dir_names)-1

nR<-10
nG<-8
nB<-10
color_data<-matrix(0,n_files,nR*nG*nB)

for (i in 1:n_files) {
  img <-readImage(dir_names[i])
  mat<-imageData(img)
  
  rBin <- seq(0, 1, length.out=nR)
  gBin <- seq(0, 1, length.out=nG)
  bBin <- seq(0, 1, length.out=nB)
  freq_rgb <- as.data.frame(table(factor(findInterval(mat[,,1], rBin), levels=1:nR), 
                                  factor(findInterval(mat[,,2], gBin), levels=1:nG), 
                                  factor(findInterval(mat[,,3], bBin), levels=1:nB)))
  rgb_feature <- as.numeric(freq_rgb$Freq)/(ncol(mat)*nrow(mat))
  
  color_data[i,]<-rgb_feature
    
}

if(!is.null(data_name)){
  save(color_data, file=paste0("./output/feature_color", data_name, ".RData"))
}
return(color_data)
}

#save(color_data,file="color_feature.RData")

##transformed color distribution-scale-invariance and shift-invariance is achieved with respect to light intensity
#color_scale_data<-matrix(0,n_files,nR*nG*nB)
#
#for (i in 1:n_files) {
#  img <-readImage(dir_names[i])
#  mat<-imageData(img)
#  mat[,,1]<-(mat[,,1]-mean(mat[,,1]))/sqrt(var(as.vector(mat[,,1])))
#  mat[,,2]<-(mat[,,2]-mean(mat[,,2]))/sqrt(var(as.vector(mat[,,2])))
#  mat[,,3]<-(mat[,,3]-mean(mat[,,3]))/sqrt(var(as.vector(mat[,,3])))
#  
#  rBin <- seq(0, 1, length.out=nR)
#  gBin <- seq(0, 1, length.out=nG)
#  bBin <- seq(0, 1, length.out=nB)
#  freq_rgb <- as.data.frame(table(factor(findInterval(mat[,,1], rBin), levels=1:nR), 
#                                  factor(findInterval(mat[,,2], gBin), levels=1:nG), 
#                                  factor(findInterval(mat[,,3], bBin), levels=1:nB)))
#  rgb_scale_feature <- as.numeric(freq_rgb$Freq)/(ncol(mat)*nrow(mat))
#  
#  color_scale_data[i,]<-rgb_scale_feature
#  
#}
#
#save(color_scale_data,file="color_scale_feature.RData")
#
##spatial color feature


#N <- 3 # number of bins in x-axis
#M <- 5 # number of bins in y-axis
#spatial_color_data<-matrix(0,n_files,N*M*nR*nG*nB)
#p_x <- p_y <- 250
#xbin <- floor(seq(0, p_x, length.out= N+1))
#ybin <- seq(0, p_y, length.out=M+1)

#rBin <- seq(0, 1, length.out=nR)
#gBin <- seq(0, 1, length.out=nG)
#bBin <- seq(0, 1, length.out=nB)
#construct_rgb_feature <- function(X){
#  freq_rgb <- as.data.frame(table(factor(findInterval(X[,,1], rBin), levels=1:nR), 
#                                  factor(findInterval(X[,,2], gBin), levels=1:nG), 
#                                  factor(findInterval(X[,,3], bBin), levels=1:nB)))
#  rgb_feature <- as.numeric(freq_rgb$Freq)/(ncol(X)*nrow(X))
#  return(rgb_feature)
#}



#for (i in 1:n_files) {
#  img <-readImage(dir_names[i])
#  img_s <- resize(img, p_x, p_y)
#  ff <- rep(NA, N*M*nR*nG*nB)
#  for(k in 1:N){
#  for(j in 1:M){
#    tmp <- img_s[(xbin[k]+1):xbin[k+1], (ybin[j]+1):ybin[j+1], ]
#    ff[((M*(k-1)+j-1)*nR*nG*nB+1):((M*(k-1)+j)*nR*nG*nB)] <- construct_rgb_feature(tmp) 
#  }
#  }
#  spatial_color_data[i,]<-ff
#  }

#save(spatial_color_data,file="spatial_color_feature.RData")




