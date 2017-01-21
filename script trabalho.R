install.packages(lubridate)
df <- read.csv("/home/julia/Documents/SI/6 semestre/MQAAE/Rec/Airplane_Crashes_and_Fatalities_Since_1908.csv", header=TRUE,
                 col.names=c("Date", "Time", "Location", "Operator", "Flight #", "Route",
                             "Type", "Registration", "cn/In", "Aboard", "Fatalities",
                             "Ground", "Summary"))
head(df)


timeColumn <- df[,c('Time')]
#timestamp <- paste(timeColumn,":00",sep="")
timeColumn

hours <- table(substr(timeColumn, 0, 2))
hours

all <- c("06","07","08","09","10","11","12","13","14","15","16","17", "18","19","20","21","22","23","00","01","02","03","04","05")
barplot(hours[all])


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


day <- subset(adu, Time == '06:00' | Time== '17:59') #select elements between 6am and 5:59pm
night <- subset(adu, Time == '18:00' | Time== '05:59') #select elements between 6pm and 5:59am
