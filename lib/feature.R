feature <- function(img_dir){
  
  library("EBImage")
  dir_images<-"./data/images"
  dir_names<-list.files(dir_images)
  n_files <- length(dir_names)-1
  
  dat_lables<-rep(0,n_files)
  for (i in 1:n_files) {
    if (grepl("chicken",dir_names[i])==TRUE) {
      dat_lables[i]<-1
    }
    else 
      dat_lables[i]<-0
  }
  
  dat1<-read.csv("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/data/sift_features.csv",header=TRUE)
  dat1<-t(dat1)
  write(dat_lables,file="./data/label.txt",ncol=1)
  save(dat1,file="./output/sift_feature.RData")

  ##color feature
  nR<-10
  nG<-8
  nB<-10
  
  color_data<-matrix(0,n_files,nR*nG*nB)
  
  for (i in 1:n_files) {
    img <-readImage(paste0("./data/images/",dir_names[i]))
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
    save(color_data,file="./output/color_feature.RData")

  
  dat<-cbind(dat1,color_data)
  save(dat,file="./output/combined_feature.RData")
  }


  
