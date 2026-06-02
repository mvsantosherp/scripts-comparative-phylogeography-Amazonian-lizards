#########################################
######## Manuela Santos #################
###### manuelasantos237@gmail.com #######
############## 2024 #####################

###########################################
### Plotting PCA results obtained with plink
### based on https://speciationgenomics.github.io/pca/
############################################


# load tidyverse package
library(tidyverse)
library(ggplot2)

# read in data
pca <- read_table2("file.eigenvec", col_names = FALSE)
eigenval <- scan("file.eigenval")

# sort out the pca data
# remove nuisance column
pca <- pca[,-1]
# set names
names(pca)[1] <- "ind"
names(pca)[2:ncol(pca)] <- paste0("PC", 1:(ncol(pca)-1))

# sort out the individual species and pops
# spp
spp <- rep(NA, length(pca$ind))
spp[grep("pop1", pca$ind)] <- "pop1"
spp[grep("pop2", pca$ind)] <- "pop2"
spp[grep("pop3", pca$ind)] <- "pop3"

#individuals
id <- rep(NA, length(pca$ind))
id[grep("ind1", pca$ind)] <- "ind1"
id[grep("ind2", pca$ind)] <- "ind2"
id[grep("ind3", pca$ind)] <- "ind3"

# location
#loc <- rep(NA, length(pca$ind))
#loc[grep("Mak", pca$ind)] <- "makobe"
#loc[grep("Pyt", pca$ind)] <- "python"
# combine - if you want to plot each in different colours
#spp_loc <- paste0(spp, "_", loc)

# remake data.frame
pca <- as.tibble(data.frame(pca, spp))

#Plotting the data
# first convert to percentage variance explained
pve <- data.frame(PC = 1:10, pve = eigenval/sum(eigenval)*100)

# make plot
a <- ggplot(pve, aes(PC, pve)) + geom_bar(stat = "identity")
a + ylab("Percentage variance explained") + theme_light()

# calculate the cumulative sum of the percentage variance explained
cumsum(pve$pve)

# plot pca
b <- ggplot(pca, aes(PC1, PC2, col = spp, label=id)) + geom_point(size = 3) + geom_text(hjust=0, vjust=0)
b <- b + scale_colour_manual(values = c("red", "orchid", "yellow", "green", "blue", "blueviolet"))
b <- b + coord_equal() + theme_light()
b + xlab(paste0("PC1 (", signif(pve$pve[1], 3), "%)")) + ylab(paste0("PC2 (", signif(pve$pve[2], 3), "%)"))

#end/fim

