
data <- "positivos_2021.csv"

# cargando matriz

positivos_2021 <- as.data.frame(readr::read_csv(data)) 



data <- positivos_2021[,c(-1,-2,-5,-8,-19,-20,-21)]
head(data)




# Boxplots ----------------------------------------------------------------

Boxplots <- data %>% 
     pivot_longer(names_to = "Categoria", values_to = "Valor", cols = c(1, 3:14)) 

BP <- Boxplots[sample(1:7894263, 10000),]

# ggplot(BP, aes(x = Categoria, y = Valor)) +
#     geom_boxplot()

ggplot(BP[BP$Categoria == "EDAD",], aes(x=Categoria, y=Valor)) + 
     geom_violin(alpha = 0.5) + 
     geom_boxplot() +
     theme_gray() +
     labs(
          x=element_blank(), y=element_blank()
     )


summary(BP)

summary(data[sample(1:607251, 10000),])


table(data$SEXO[sample(1:607251, 10000),]) # muestra aleatoria de 10 mil muestras

table(data$TABAQUISMO)
# una por cada una de las variables



