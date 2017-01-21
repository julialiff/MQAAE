#instalação de packages
install.packages("lubridate")
install.packages("ggplot2")

#importação do dataset
df <- read.csv("/home/julia/Documents/SI/6 semestre/MQAAE/Rec/Airplane_Crashes_and_Fatalities_Since_1908.csv", header=TRUE,
                 col.names=c("Date", "Time", "Location", "Operator", "Flight #", "Route",
                             "Type", "Registration", "cn/In", "Aboard", "Fatalities",
                             "Ground", "Summary"))
head(df)

#transformar N/A em 0
df[is.na(df)] <- 0

#Extrair apenas os anos das datas (única parte importante desta variável para nosso trabalho)
df$Date <- sapply(format(as.Date(df$Date, format="%m/%d/%Y"),"%Y"), as.numeric)

#Histograma de acidentes por ano
x <- df$Date
h<-hist(x,
     freq = F,
     main="Histograma de Acidentes por Ano",
     xlab="Anos",
     ylab="Frequência",
     col=c("lightblue"),
     xlim=c(1908,2009),
     breaks = 101)
curve(dnorm(x, mean= mean(x), sd= sd(x)), add = TRUE, col="darkblue", lwd=2)




timeColumn <- df[,c('Time')] #seleciona a coluna de horas
hours <- table(substr(timeColumn, 0, 2)) #seleciona os caracteres correspondentes às horas apenas, sem os minutos

all <- c("06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","00","01","02","03","04","05")
barplot(hours[all],
        main="Acidentes por hora do dia", 
        xlab="Horas", 
        ylab="Quantidade",
        col=c(rep("orangered1",12),rep("darkblue",12)))

#histograma arrumar
hist(hours, 
     main="Histograma de acidentes por hora do dia", 
     xlab="Horas", 
     ylab="Frequência",
     breaks=24)


hist(hours[all], main = "", xlab = "horas", ylab = "número de acidentes")
axis(1, at = seq(00, 23, by = 1), pos = 0) 

nightHours <- c("18","19","20","21","22","23","00","01","02","03","04","05")
nightHours


dayHours <- c("06","07","08","09","10","11","12","13","14","15","16","17")
dayHours

day <- hours[dayHours]
day

night <- hours[nightHours]
night

barplot(day)
barplot(night)






#Distribuição t
mean_aboard <- mean(df$Aboard)
mean_aboard#Print
t.test(df$Aboard, mu = mean_aboard)




#COVARIÂNCIA:
x  <- df[, c("Aboard", "Fatalities", "Ground")] #seleciona os dados quantitativos

dados <- princomp(x, cor = FALSE, scores = TRUE)
summary(dados, loadings = TRUE)





#MATRIZ DE CORRELAÇÃO
matriz <- data.frame(Aboard=c(df$Aboard), 
                     Fatalities=c(df$Fatalities), 
                     Ground=c(df$Ground))
mCor <- cor(matriz)




