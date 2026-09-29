my_mat<-data.frame(SNP1=c(0,1,1,0,1),SNP2=c(0,2,0,1,0),SNP3=c(0,1,0,0,1))
rownames(my_mat)<-c("Ind1","Ind2","Ind3","Ind4","Ind5")
my_mat

my_mat_with_miss<-my_mat
my_mat_with_miss[3,3]<-NA
my_mat_with_miss

summary(lm(my_mat_with_miss$SNP3~my_mat_with_miss$SNP1))$adj.r.squared
summary(lm(my_mat_with_miss$SNP3~my_mat_with_miss$SNP2))$adj.r.squared

as.integer(predict(lm(my_mat_with_miss$SNP3~my_mat_with_miss$SNP1), newdata = data.frame(SNP3=my_mat_with_miss$SNP3[3]) ))
