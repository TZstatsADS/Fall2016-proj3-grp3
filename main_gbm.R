setwd("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/images")

img_train_dir <- "C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/imgages"
##img_test_dir <- "C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/test"

### Import training images class labels
label_train <- read.table("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/label.txt", header=F)
label_train<-as.vector(unlist(label_train))

### Construct visual feature
source("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/lib/feature.R")

tm_feature_train <- system.time(dat_train <- feature(img_train_dir))
##tm_feature_test <- system.time(dat_test <- feature(img_test_dir))
save(dat_train, file="C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/output/feature_train.RData")
##save(dat_test, file="C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/output/feature_test.RData")

### Train a classification model with training images
source("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/lib/gbm/train_gbm.R")
source("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/lib/gbm/test_gbm.R")

### Model selection with cross-validation
# Choosing between different values of interaction depth for GBM
source("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/lib/gbm/cross_validation_gbm.R")
depth_values <- c(seq(3,15,3),20)
err_cv <- array(dim=c(length(depth_values), 2))
K <- 5  
for(k in 1:length(depth_values)){
  cat("k=", k, "\n")
  err_cv[k,] <- cv.function(dat_train, label_train, depth_values[k], K)
}
save(err_cv, file="C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/output/err_cv_gbm2.RData")

# Visualize CV results
pdf("C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/fig/cv_results_300.pdf", width=7, height=5)
plot(depth_values, err_cv[,1], xlab="Interaction Depth", ylab="CV Error",
     main="Cross Validation Error", type="n", ylim=c(0, 0.40))
points(depth_values, err_cv[,1], col="blue", pch=16)
lines(depth_values, err_cv[,1], col="blue")
arrows(depth_values, err_cv[,1]-err_cv[,2],depth_values, err_cv[,1]+err_cv[,2], 
       length=0.1, angle=90, code=3)
dev.off()

# Choose the best parameter value
depth_best <- depth_values[which.min(err_cv[,1])]
par_best <- list(depth=depth_best)

# train the model with the entire training set
tm_train <- system.time(fit_train <- train(dat_train, label_train, par_best))
save(fit_train, file="C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/output/fit_train_gbm2.RData")

### Make prediction 
##tm_test <- system.time(pred_test <- test(fit_train, dat_test))
##save(pred_test, file="C:/Users/YounHyuk/Desktop/Project3_poodleKFC_train/output/fit_test1.RData")

### Summarize Running Time
cat("Time for constructing training features=", tm_feature_train[1], "s \n")
##cat("Time for constructing testing features=", tm_feature_test[1], "s \n")
cat("Time for training model=", tm_train[1], "s \n")
##cat("Time for making prediction=", tm_test[1], "s \n")