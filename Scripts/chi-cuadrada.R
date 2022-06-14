
data <- "positivos_2021.csv"

# cargando matriz

positivos_2021 <- as.data.frame(readr::read_csv(data)) 

colnames(positivos_2021) # observando la integridad de las variables
head(positivos_2021)




###       --- PRUEBA DE CHI CUADRADA ---



# Necesitamos jerarquizar los datos numéricamente
# podemos dividir a la enfermedad dependiendo si los pacientes fueron o no 
# intubados y si murieron


# 8 de cada 10 intubados mueren

#personas en UCI sin intubar y que sobrevivieron
nrow(positivos_2021 %>% filter(INTUBADO == 2, is.na(FECHA_DEF),
                               UCI == 1) %>% select(...1)) #606

#personas intubadas
nrow(positivos_2021 %>% filter(INTUBADO == 1) %>% select(...1)) #4416

# personas que murieron y fueron intubadas
nrow(positivos_2021 %>% filter(!is.na(FECHA_DEF),
                               INTUBADO == 1) %>% select(...1)) #3812

# personas que murieron
nrow(positivos_2021 %>% filter(!is.na(FECHA_DEF)) %>% select(...1)) #27723

# personas que murieron y NO fueron intubadas
nrow(positivos_2021 %>% filter(!is.na(FECHA_DEF),
                               INTUBADO == 2) %>% select(...1)) # 21275

### Clasificación sugerida
# 1- leve - personas que sobrevivieron y no fueron intubadas ni estuvieron en UCI
# 2- moderado - personas que sobrevivieron y estuvieron en UCI sin intubar
# 3- grave - personas intubadas que sobrevivieron (independientemente de si estuvieron en UCI)
# 4- fatal - personas que murieron


#### Aplicando clasificacion de la enfermedad a la matriz

matriz_chi <- positivos_2021 %>% mutate(GRAVEDAD = case_when(
     INTUBADO == 2 & is.na(FECHA_DEF) & UCI == 2 ~ 1, # condicion 1
     INTUBADO == 2 & is.na(FECHA_DEF) & UCI == 1 ~ 2, # condicion 2
     INTUBADO == 1 & is.na(FECHA_DEF) ~ 3, #condicion 3
     !is.na(FECHA_DEF) ~ 4
))


# variables que se compararán
# ENTIDAD_RES, EDAD, SEXO, NEUMONIA, DIABETES, INDIGENA, EPOC, ASMA, INMUSUPR,
# HIPERTENSION, CARDIOVASCULAR, OBESIDAD, TABAQUISMO

# eliminando columnas que no son de interés

matriz_chi <- matriz_chi[,c(-1,-2,-5,-8,-19,-20,-21)]
head(matriz_chi)

#### Chi cuadrada

matriz_chi %>% 
     summarise_each(funs(chisq.test(., 
                                    matriz_chi$GRAVEDAD)$p.value), -one_of("GRAVEDAD"))



# gravedad con SEXO
#chisq.test(matriz_chi$GRAVEDAD, matriz_chi$SEXO)

M <- matriz_chi %>% filter(SEXO == 1) %>% group_by(GRAVEDAD) %>%
     summarise(M = length(SEXO)) %>% head()

H <- matriz_chi %>% filter(SEXO == 2) %>% group_by(GRAVEDAD) %>%
     summarise(H = length(SEXO)) %>% head()

sexo <- merge(M,H)
(sexo <- sexo[-5,])

chisq.test(sexo, simulate.p.value = T) # 0.0004998


# gravedad con entidad
chisq.test(matriz_chi$GRAVEDAD, matriz_chi$ENTIDAD_RES, simulate.p.value = T)




# gravedad con neumonia
neumonia <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$NEUMONIA)

# gravedad con edad
edad <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$EDAD)

# gravedad con diabetes
diabetes <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$DIABETES)

# gravedad con indigenismo
indigena <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$INDIGENA)

# gravedad con EPOC
epoc <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$EPOC)

# gravedad con asma
asma <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$ASMA)

# gravedad con inmunosuprisión
inmuno <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$INMUSUPR)

# gravedad con hipertension
hiper <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$HIPERTENSION)

# gravedad con cardiovascular
cardio <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$CARDIOVASCULAR)

# gravedad con obesidad
obesidad <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$as.factor(OBESIDAD)

# gravedad con renal cronica
renal <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$RENAL_CRONICA)

# gavedad con tabaquismo
tabaco <- chisq.test(matriz_chi$GRAVEDAD, matriz_chi$TABAQUISMO)
