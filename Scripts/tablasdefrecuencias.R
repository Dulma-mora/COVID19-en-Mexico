
data <- "positivos_2021.csv"

# cargando matriz

positivos_2021 <- as.data.frame(readr::read_csv(data)) 



data <- positivos_2021[,c(-1,-2,-5,-8,-19,-20,-21)]
head(data)


BP <- Boxplots[sample(1:7894263, 10000),]




summary(BP)

summary(data[sample(1:607251, 10000),])


table(data$SEXO[sample(1:607251, 10000),]) # muestra aleatoria de 10 mil muestras

table(data$TABAQUISMO)
# una por cada una de las variables
