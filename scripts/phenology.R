
library(ggpubr)

source("scripts/data_import.R")

# number of specimens 
hist(data$year[which(data$year>1900)], xlim=c(1900,2030),
     breaks=100, main="Specimens collected Scleria", xlab="Year")

# phenology
data$month <- data$col_date %>% substr(6,7)
data_phe <- data %>% subset(!is.na(data$year))
# data_phe$section %>% table() %>% as.data.frame() %>% view()
data_phe <- table(data_phe$section, data_phe$month)
data_phe <- data_phe[2:dim(data_phe)[1],]
# estandarizo por fila, para poder comparar entre especies
for (st in rownames(data_phe)) { data_phe[st,] <- data_phe[st,] / max(data_phe[st,]) }
data_phe <- data_phe %>% as.data.frame()
colnames(data_phe) <- c("section","month","freq")

a<-ggplot(data=subset(data_phe, section%in%unique(data_phe$section)[1:4]), aes(x=month, y=freq, group=section, color=section)) +
  geom_smooth(method="loess", se=F)
b<-ggplot(data=subset(data_phe, section%in%unique(data_phe$section)[5:8]), aes(x=month, y=freq, group=section, color=section)) +
  geom_smooth(method="loess", se=F)
c<-ggplot(data=subset(data_phe, section%in%unique(data_phe$section)[9:12]), aes(x=month, y=freq, group=section, color=section)) +
  geom_smooth(method="loess", se=F)
d<-ggplot(data=subset(data_phe, section%in%unique(data_phe$section)[13:17]), aes(x=month, y=freq, group=section, color=section)) +
  geom_smooth(method="loess", se=F)

ggarrange(a,b,c,d)

rm(data_phe,a,b,c,d)


