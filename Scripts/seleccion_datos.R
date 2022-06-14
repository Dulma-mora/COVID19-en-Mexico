library("readr")
library("dplyr")

#path
datos_covid <- "210605COVID19MEXICO.csv"

# cargando matriz
datos_2021 <- as.data.frame(readr::read_csv(datos_covid)) 
colnames(datos_2021) # observando variables


# creando nueva matriz solo con las variables de interes
variables_2021 <- select(datos_2021, SEXO, ENTIDAD_RES, INTUBADO,
                         NEUMONIA, EDAD, NACIONALIDAD, DIABETES, INDIGENA, EPOC, ASMA,
                         INMUSUPR, HIPERTENSION, CARDIOVASCULAR, OBESIDAD, RENAL_CRONICA,
                         TABAQUISMO, RESULTADO_ANTIGENO, UCI, FECHA_DEF)


# comprobando la integridad de las variables
colnames(variables_2021)
head(variables_2021)


# Obteniendo resultados positivos -----------------------------------------

# observando los datos únicos en la variable RESULTADO_ANTIGENO
unique(datos_2021$RESULTADO_ANTIGENO)
class(datos_2021$RESULTADO_ANTIGENO)

# 97, 2 y 1
# de acuerdo con los descriptores de las variables, los valores corresponden
# a 1 (POSITIVO A SARS-COV-2), 2 (NEGATIVO A SARS-COV-2)
# y 97 (no aplica, caso sin muestra)

# nos interesan los datos de los pacientes positivos 


# seleccionando positivos

positivos_covid <- filter(datos_2021, RESULTADO_ANTIGENO == 1) # 6 millones de positivos
     
# guardando la matriz resultante
write.csv(positivos_covid, "positivos_2021.csv")
