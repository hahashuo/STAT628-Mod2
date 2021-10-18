rm(list=ls())
dat=read.csv("./Data/preprocess_data.csv",header=TRUE)
library(MASS)
library(tidyverse)
#delete the variable density
dat_del=dat[,c(-1,-3,-6,-5)]
rmse<-function(testdata,actual,fitmodel){
  predicted<-predict(fitmodel,testdata)
  return((mean((predicted - actual)^2))^0.5)
}
#=====fullmodel========
full.model=lm(BODYFAT~.,data=dat_del)
summary(full.model)
actual<-dat_del$BODYFAT
test<-dat_del[,-1]
rmse(test,actual,full.model)
#=====stepwise========
step.model=stepAIC(full.model, direction = "both", trace = FALSE)
summary(step.model)
test<-dat_del[,c('AGE','NECK','ABDOMEN','HIP','THIGH','FOREARM','WRIST','WEIGHT_KG')]
rmse(test,actual,step.model)
#=========split in age========
dat_del$age_group<-'g2'
dat_del$age_group[which(dat$AGE<=40)]<-'g1'
dat_del$age_group[which(dat$AGE>60)]<-'g3'

boxplot(BODYFAT~age_group,data = dat_del)
#======age group under 40======
substi<-function(str){
  return(gsub(' [+] ',"','",str))
}
sub<-which(dat_del$age_group=='g1')
fit<-lm(BODYFAT~.,dat_del[sub,-16])
step(fit)
#Stepwise model
fit<-lm(BODYFAT ~ ABDOMEN + HIP + THIGH + WRIST,dat=dat_del[sub,])
summary(fit)
str<-substi('ABDOMEN + HIP + THIGH + WRIST')
str
test<-dat_del[sub,c('ABDOMEN','HIP','THIGH','WRIST')]
actual<-dat_del[sub,"BODYFAT"]
rmse(test,actual,fit)

#=====age group under 60=====
sub<-which(dat_del$age_group=='g2')
fit<-lm(BODYFAT~.,dat_del[sub,-16])
step(fit)
#Stepwise model
fit<-lm(BODYFAT ~  AGE + NECK + ABDOMEN + ANKLE + FOREARM + WRIST,dat=dat_del[sub,])
summary(fit)
#drop not significant
fit<-lm(BODYFAT ~  NECK + ABDOMEN + ANKLE + FOREARM + WRIST,dat=dat_del[sub,])
summary(fit)
str<-substi('NECK + ABDOMEN + ANKLE + FOREARM + WRIST')
str
test<-dat_del[sub,c('NECK','ABDOMEN','ANKLE','FOREARM','WRIST')]
actual<-dat_del[sub,"BODYFAT"]
rmse(test,actual,fit)
#=====age group above 60=====
sub<-which(dat_del$age_group=='g3')
fit<-lm(BODYFAT~.,dat_del[sub,-16])
step(fit)
#Stepwise model
fit<-lm(BODYFAT ~ ABDOMEN + ANKLE + BICEPS + FOREARM,dat=dat_del[sub,])
summary(fit)
#drop not significant
fit<-lm(BODYFAT ~ ABDOMEN + ANKLE ,dat=dat_del[sub,])
summary(fit)

str<-substi('ABDOMEN + ANKLE ')
str
test<-dat_del[sub,c('ABDOMEN','ANKLE')]
actual<-dat_del[sub,"BODYFAT"]
rmse(test,actual,fit)
