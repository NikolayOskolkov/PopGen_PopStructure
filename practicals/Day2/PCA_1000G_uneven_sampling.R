library("SNPRelate")
setwd("/home/nikolay/WABI/P_Sullivan/vcf/chr21")

#download 1000G vcf-files from here: http://hgdownload.cse.ucsc.edu/gbdb/hg19/1000Genomes/phase3/
#download 1000G annotation from here: http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel

#CONVERT VCF TO GDS
snpgdsVCF2GDS("ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz","1000G.gds",method="biallelic.only")

#download 1000G chr21 vcf-file as:
#wget http://hgdownload.cse.ucsc.edu/gbdb/hg19/1000Genomes/phase3/ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz
#download 1000G annotation from here: http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel

#CONVERT CHR21 VCF TO GDS
snpgdsVCF2GDS("ALL.chr21.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz","1000G_chr21.gds",method="biallelic.only")


################################################## NO DOWNSAMPLING ########################################################################

#READ GENOTYPES AND ANNOTATION AND CHECK HOW THEY LOOK LIKE
genofile<-snpgdsOpen("1000G_chr21.gds")
annot<-read.delim("integrated_call_samples_v3.20130502.ALL.panel",header=TRUE,sep="\t")
annot[,c(5,6)]<-NULL
head(annot,20)
table(annot$super_pop)
#AFR AMR EAS EUR SAS 
#661 347 504 503 489 
table(annot$pop)
#ACB ASW BEB CDX CEU CHB CHS CLM ESN FIN GBR GIH GWD IBS ITU JPT KHV LWK MSL MXL PEL PJL PUR STU TSI YRI 
#96  61  86  93  99 103 105  94  99  99  91 103 113 107 102 104  99  99  85  64  85  96 104 102 107 108 

#SELECT EUROPEANS, EASTERN ASIANS AND AFRICANS AS REFERENCE POPULATIONS AND MEXICANS AS QUERY POPULATION
my_samples<-c(as.character(annot$sample[as.character(annot$super_pop)==
                                          "AFR"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="AFR"])),661)],
              as.character(annot$sample[as.character(annot$super_pop)==
                                          "EUR"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="EUR"])),503)],
              as.character(annot$sample[as.character(annot$super_pop)==
                                          "EAS"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="EAS"])),504)],
              as.character(annot$sample[as.character(annot$pop)==
                                          "MXL"])[sample(1:length(as.character(annot$sample[as.character(annot$pop)=="MXL"])),64)])
annot<-annot[as.character(annot$sample)%in%my_samples,]

#COMPUTE PCA ON SELECTED SAMPLES
ccm_pca<-snpgdsPCA(genofile, missing.rate=0, maf=0.05, num.thread=4, sample.id=my_samples)

COLOR<-rep("blue",length(ccm_pca$sample.id))
meta<-data.frame(ID=as.character(ccm_pca$sample.id),COLOR=as.character(COLOR))
meta$ID<-as.character(meta$ID)
meta$COLOR<-as.character(meta$COLOR)

EUR<-annot[as.character(annot$super_pop)=="EUR",]
AFR<-annot[as.character(annot$super_pop)=="AFR",]
MXL<-annot[as.character(annot$pop)=="MXL",]
EAS<-annot[as.character(annot$super_pop)=="EAS",]

meta$COLOR[meta$ID%in%as.character(EUR$sample)]<-"blue"
meta$COLOR[meta$ID%in%as.character(AFR$sample)]<-"green"
meta$COLOR[meta$ID%in%as.character(MXL$sample)]<-"brown"
meta$COLOR[meta$ID%in%as.character(EAS$sample)]<-"red"

#VISUALIZE PCA PLOT
plot(ccm_pca$eigenvect[,1],ccm_pca$eigenvect[,2],col=meta$COLOR,pch=19,cex=0.8,
     xlab=paste0("PC1 ( ",round(ccm_pca$varprop[1]*100,2),"% )"),
     ylab=paste0("PC2 ( ",round(ccm_pca$varprop[2]*100,2),"% )"),
     main="1000G World Populations, No Downsampling")
legend("topright",c("EUR","AFR","MEX","EAS"),inset=0.02,fill=c("blue","green","brown","red"),cex=1.2)
mtext("N_eur = 503, N_afr = 661, N_eas = 504, N_mxl = 64")



################################################## DOWNSAMPLING EUROPEANS #####################################################################

#READ GENOTYPES AND ANNOTATION AND CHECK HOW THEY LOOK LIKE
snpgdsClose(genofile)
genofile<-snpgdsOpen("1000G_chr21.gds")
annot<-read.delim("integrated_call_samples_v3.20130502.ALL.panel",header=TRUE,sep="\t")
annot[,c(5,6)]<-NULL
head(annot,20)

#SELECT EUROPEANS, EASTERN ASIANS AND AFRICANS AS REFERENCE POPULATIONS AND MEXICANS AS QUERY POPULATION
my_samples<-c(as.character(annot$sample[as.character(annot$super_pop)==
                                          "AFR"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="AFR"])),661)],
              as.character(annot$sample[as.character(annot$super_pop)==
                                          "EUR"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="EUR"])),20)],
              as.character(annot$sample[as.character(annot$super_pop)==
                                          "EAS"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="EAS"])),504)],
              as.character(annot$sample[as.character(annot$pop)==
                                          "MXL"])[sample(1:length(as.character(annot$sample[as.character(annot$pop)=="MXL"])),64)])
annot<-annot[as.character(annot$sample)%in%my_samples,]

#COMPUTE PCA ON SELECTED SAMPLES
ccm_pca<-snpgdsPCA(genofile, missing.rate=0, maf=0.05, num.thread=4, sample.id=my_samples)

COLOR<-rep("blue",length(ccm_pca$sample.id))
meta<-data.frame(ID=as.character(ccm_pca$sample.id),COLOR=as.character(COLOR))
meta$ID<-as.character(meta$ID)
meta$COLOR<-as.character(meta$COLOR)

EUR<-annot[as.character(annot$super_pop)=="EUR",]
AFR<-annot[as.character(annot$super_pop)=="AFR",]
MXL<-annot[as.character(annot$pop)=="MXL",]
EAS<-annot[as.character(annot$super_pop)=="EAS",]

meta$COLOR[meta$ID%in%as.character(EUR$sample)]<-"blue"
meta$COLOR[meta$ID%in%as.character(AFR$sample)]<-"green"
meta$COLOR[meta$ID%in%as.character(MXL$sample)]<-"brown"
meta$COLOR[meta$ID%in%as.character(EAS$sample)]<-"red"

#VISUALIZE PCA PLOT
plot(ccm_pca$eigenvect[,1],ccm_pca$eigenvect[,2],col=meta$COLOR,pch=19,cex=0.8,
     xlab=paste0("PC1 ( ",round(ccm_pca$varprop[1]*100,2),"% )"),
     ylab=paste0("PC2 ( ",round(ccm_pca$varprop[2]*100,2),"% )"),
     main="1000G World Populations, Downsampling Europeans")
legend("bottomright",c("EUR","AFR","MEX","EAS"),inset=0.02,fill=c("blue","green","brown","red"),cex=1.2)
mtext("N_eur = 20, N_afr = 661, N_eas = 504, N_mxl = 64")



################################################## DOWNSAMPLING ASIANS #####################################################################

#READ GENOTYPES AND ANNOTATION AND CHECK HOW THEY LOOK LIKE
snpgdsClose(genofile)
genofile<-snpgdsOpen("1000G_chr21.gds")
annot<-read.delim("integrated_call_samples_v3.20130502.ALL.panel",header=TRUE,sep="\t")
annot[,c(5,6)]<-NULL
head(annot,20)

#SELECT EUROPEANS, EASTERN ASIANS AND AFRICANS AS REFERENCE POPULATIONS AND MEXICANS AS QUERY POPULATION
my_samples<-c(as.character(annot$sample[as.character(annot$super_pop)==
                                          "AFR"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="AFR"])),661)],
              as.character(annot$sample[as.character(annot$super_pop)==
                                          "EUR"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="EUR"])),503)],
              as.character(annot$sample[as.character(annot$super_pop)==
                                          "EAS"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="EAS"])),20)],
              as.character(annot$sample[as.character(annot$pop)==
                                          "MXL"])[sample(1:length(as.character(annot$sample[as.character(annot$pop)=="MXL"])),64)])
annot<-annot[as.character(annot$sample)%in%my_samples,]

#COMPUTE PCA ON SELECTED SAMPLES
ccm_pca<-snpgdsPCA(genofile, missing.rate=0, maf=0.05, num.thread=4, sample.id=my_samples)

COLOR<-rep("blue",length(ccm_pca$sample.id))
meta<-data.frame(ID=as.character(ccm_pca$sample.id),COLOR=as.character(COLOR))
meta$ID<-as.character(meta$ID)
meta$COLOR<-as.character(meta$COLOR)

EUR<-annot[as.character(annot$super_pop)=="EUR",]
AFR<-annot[as.character(annot$super_pop)=="AFR",]
MXL<-annot[as.character(annot$pop)=="MXL",]
EAS<-annot[as.character(annot$super_pop)=="EAS",]

meta$COLOR[meta$ID%in%as.character(EUR$sample)]<-"blue"
meta$COLOR[meta$ID%in%as.character(AFR$sample)]<-"green"
meta$COLOR[meta$ID%in%as.character(MXL$sample)]<-"brown"
meta$COLOR[meta$ID%in%as.character(EAS$sample)]<-"red"

#VISUALIZE PCA PLOT
plot(ccm_pca$eigenvect[,1],ccm_pca$eigenvect[,2],col=meta$COLOR,pch=19,cex=0.8,
     xlab=paste0("PC1 ( ",round(ccm_pca$varprop[1]*100,2),"% )"),
     ylab=paste0("PC2 ( ",round(ccm_pca$varprop[2]*100,2),"% )"),
     main="1000G World Populations, Downsampling Asians")
legend("topright",c("EUR","AFR","MEX","EAS"),inset=0.02,fill=c("blue","green","brown","red"),cex=1.2)
mtext("N_eur = 503, N_afr = 661, N_eas = 20, N_mxl = 64")



################################################## EVEN SAMPLING #####################################################################

#READ GENOTYPES AND ANNOTATION AND CHECK HOW THEY LOOK LIKE
snpgdsClose(genofile)
genofile<-snpgdsOpen("1000G_chr21.gds")
annot<-read.delim("integrated_call_samples_v3.20130502.ALL.panel",header=TRUE,sep="\t")
annot[,c(5,6)]<-NULL
head(annot,20)

#SELECT EUROPEANS, EASTERN ASIANS AND AFRICANS AS REFERENCE POPULATIONS AND MEXICANS AS QUERY POPULATION
my_samples<-c(as.character(annot$sample[as.character(annot$super_pop)==
                                          "AFR"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="AFR"])),64)],
              as.character(annot$sample[as.character(annot$super_pop)==
                                          "EUR"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="EUR"])),64)],
              as.character(annot$sample[as.character(annot$super_pop)==
                                          "EAS"])[sample(1:length(as.character(annot$sample[as.character(annot$super_pop)=="EAS"])),64)],
              as.character(annot$sample[as.character(annot$pop)==
                                          "MXL"])[sample(1:length(as.character(annot$sample[as.character(annot$pop)=="MXL"])),64)])
annot<-annot[as.character(annot$sample)%in%my_samples,]

#COMPUTE PCA ON SELECTED SAMPLES
ccm_pca<-snpgdsPCA(genofile, missing.rate=0, maf=0.05, num.thread=4, sample.id=my_samples)

COLOR<-rep("blue",length(ccm_pca$sample.id))
meta<-data.frame(ID=as.character(ccm_pca$sample.id),COLOR=as.character(COLOR))
meta$ID<-as.character(meta$ID)
meta$COLOR<-as.character(meta$COLOR)

EUR<-annot[as.character(annot$super_pop)=="EUR",]
AFR<-annot[as.character(annot$super_pop)=="AFR",]
MXL<-annot[as.character(annot$pop)=="MXL",]
EAS<-annot[as.character(annot$super_pop)=="EAS",]

meta$COLOR[meta$ID%in%as.character(EUR$sample)]<-"blue"
meta$COLOR[meta$ID%in%as.character(AFR$sample)]<-"green"
meta$COLOR[meta$ID%in%as.character(MXL$sample)]<-"brown"
meta$COLOR[meta$ID%in%as.character(EAS$sample)]<-"red"

#VISUALIZE PCA PLOT
plot(ccm_pca$eigenvect[,1],ccm_pca$eigenvect[,2],col=meta$COLOR,pch=19,cex=0.8,
     xlab=paste0("PC1 ( ",round(ccm_pca$varprop[1]*100,2),"% )"),
     ylab=paste0("PC2 ( ",round(ccm_pca$varprop[2]*100,2),"% )"),
     main="1000G World Populations, Even Sampling")
legend("topright",c("EUR","AFR","MEX","EAS"),inset=0.02,fill=c("blue","green","brown","red"),cex=1.2)
mtext("N_eur = 64, N_afr = 64, N_eas = 64, N_mxl = 64")
