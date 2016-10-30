feature <- function(img_dir,data_name=NULL){
  library("EBImage")
  
  n_files <- length(list.files(img_dir))
  
  dat<-read.csv("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/sift_features.csv",header=TRUE)
  dat<-t(dat)
  ##index<-read.table(paste0(img_dir,"/index.txt"))
  ##index<-as.vector(unlist(index))
  ##dat<-dat[index,]
  
  if(!is.null(data_name)){
    save(dat, file=paste0("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/output/feature_", data_name, ".RData"))
  }
  return(dat)
}

