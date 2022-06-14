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

colnames(variables_2021)
head(variables_2021)


write.csv(variables_2021, "datos_2021")
