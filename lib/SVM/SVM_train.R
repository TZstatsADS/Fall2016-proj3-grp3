features=read.csv("~/Fall 2016/GR5243/Project3/Project3_poodleKFC_train/sift_features.csv",header=T)
labels=read.table("~/Fall 2016/GR5243/Project3/Project3_poodleKFC_train/label.txt")
features=t(features)
#dim(features)


################################ supporting funciton   ########################################
#k=5
cross_validation=function(features,labels,k,p){
  dat=data.frame(x=features,y=as.factor(as.matrix(labels)))
  colnames(dat)=c(1:(dim(dat)[2]-1),'y')
  rownames(dat)[1:10]
  #colnames(dat)
  accuracy=vector()
  m=dim(dat)[2]
  n=2000/k
  index=list()
  for (i in 1:k){
    index[[i]]=seq(i,2000,k)
  }
  for (i in 1:k){
    ind=index[[i]]
    train_dat=dat[-ind,]
    #dim(train_dat)
    test_dat=dat[ind,]
    #dim(test_dat)
    temp=dat[-ind,-m]
    ind2=which(colSums(temp)==0)
    
    train_dat=train_dat[,-c(ind2)]# with labels
    test_label=test_dat[,m]
    test_dat=test_dat[,-m]
    test_dat=test_dat[,-c(ind2)] # wiout labels
    
    svm.linear=svm(y~.,data=train_dat,kernel="linear",cost=p,scale = T)
    r=predict(svm.linear,test_dat)
    
    accuracy[i]=mean(r==test_label)
  }
  return(mean(accuracy))
}

####################################### generating model ####################################
gen_model=function(features,labels){
  k=5
  p=c(0.0001,0.001,0.01,0.1,1)
  acc=vector()
  for (i in p){
    acc[i]=cross_validation(features,labels,k,i)
  }
  ind=which.min(acc)
  final.p=acc[ind]
  dat=data.frame(x=features,y=as.factor(as.matrix(labels)))
  colnames(dat)=c(1:(dim(dat)[2]-1),'y')
  model=svm(y~.,data=dat,kernel="linear",cost=final.p,scale = T)
  return(model)
}

##################################### Predict Part ###########################################

#testdata=read
#fm=gen_model(features,labels)
#r=predict(fm,testdata)

