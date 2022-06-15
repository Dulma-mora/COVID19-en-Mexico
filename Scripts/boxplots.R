library(tidyverse)
library("readr")
library("dplyr")


data <- "positivos_2021.csv"

# cargando matriz

positivos_2021 <- as.data.frame(readr::read_csv(data)) 



data <- positivos_2021[,c(-1,-2,-5,-8,-19,-20,-21)]
head(data)




# Boxplots ----------------------------------------------------------------

Boxplots <- data %>% 
     pivot_longer(names_to = "Categoria", values_to = "Valor", cols = c(1, 3:14)) 

BP <- Boxplots[sample(1:7894263, 10000),]

ggplot(BP, aes(x = Categoria, y = Valor)) +
     geom_boxplot()


summary(BP)


# 
