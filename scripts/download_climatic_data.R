
library(raster)
library(ggfortify)
library(vegan)

source("scripts/data_import.R")

# mis variables climaticas con resolucion 5 minutes
bio1 <- raster("C:/Users/javie/Desktop/wc2.1_5m_bio/wc2.1_5m_bio_1.tif")
bio7 <- raster("C:/Users/javie/Desktop/wc2.1_5m_bio/wc2.1_5m_bio_7.tif")
bio8 <- raster("C:/Users/javie/Desktop/wc2.1_5m_bio/wc2.1_5m_bio_8.tif")
bio12 <- raster("C:/Users/javie/Desktop/wc2.1_5m_bio/wc2.1_5m_bio_12.tif")
bio15 <- raster("C:/Users/javie/Desktop/wc2.1_5m_bio/wc2.1_5m_bio_15.tif")
bio17 <- raster("C:/Users/javie/Desktop/wc2.1_5m_bio/wc2.1_5m_bio_17.tif")

# mis puntos
points <- data[,c("longitudecorrected","latitudecorrected")]
coordinates(points) <- ~ longitudecorrected + latitudecorrected

# plot
# X11()
# plot(bio1); points(points)

data$bio1 <- raster::extract(bio1, points, method = "simple", dr=TRUE, sp=TRUE) %>% as.data.frame() %>% dplyr::select(wc2.1_5m_bio_1) %>% deframe()
data$bio7 <- raster::extract(bio7, points, method = "simple", dr=TRUE, sp=TRUE) %>% as.data.frame() %>% dplyr::select(wc2.1_5m_bio_7) %>% deframe()
data$bio8 <- raster::extract(bio8, points, method = "simple", dr=TRUE, sp=TRUE) %>% as.data.frame() %>% dplyr::select(wc2.1_5m_bio_8) %>% deframe()
data$bio12 <- raster::extract(bio12, points, method = "simple", dr=TRUE, sp=TRUE) %>% as.data.frame() %>% dplyr::select(wc2.1_5m_bio_12) %>% deframe()
data$bio15 <- raster::extract(bio15, points, method = "simple", dr=TRUE, sp=TRUE) %>% as.data.frame() %>% dplyr::select(wc2.1_5m_bio_15) %>% deframe()
data$bio17 <- raster::extract(bio17, points, method = "simple", dr=TRUE, sp=TRUE) %>% as.data.frame() %>% dplyr::select(wc2.1_5m_bio_17) %>% deframe()

table(is.na(data[,8:13]))

# elimino puntos que quedaron fuera de los rasteres climaticos
data <- data %>% subset(!is.na(data[,8]))

str(data)

rm(bio1, bio7, bio8, bio12, bio15, bio17)

# PCA para ver nichos climaticos
clim_pca <- prcomp(data[,8:13], scale=T, center=T)
clim_pca
autoplot(clim_pca, data=data, colour='section', loadings=TRUE, loadings.label=TRUE)
autoplot(clim_pca, data=data, colour='subgenus', loadings=TRUE, loadings.label=TRUE)
