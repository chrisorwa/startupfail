#Database of Broken Dreams
#load libraries
library(data.table)
library(ggplot2)
#set working directory

setwd("C:\\Users\\user\\Google Drive\\Data_Science\\StartupFails")

#get the data

data = fread("domains_deletions.csv")

data = data[!type==""]

plot1 <- ggplot(data, aes(type))
plot1 + geom_bar(fill=rainbow(9), colour="darkgreen")

plot1 <- ggplot(data, aes(type))
plot1 + geom_bar(fill=rainbow(9))

#get only co type

data2 = data[type=="co"]

stats = table(data[,date_deleted])
stats = setDT(data.frame(stats))
names(stats) = c("date","no_deleted")
stats = stats[,datefx :=as.Date(strptime(date, "%d %B %Y"))]

stats = stats[,month :=as.character(format(datefx,"%B-%Y"))]
stats = stats[,monthfx :=as.Date(strptime(month, "%B-%Y"))]
#stats[,monthfx:=NULL]

stats2 = stats[,lapply(.SD, sum), by=month,.SDcols = c("no_deleted")]
stats2[,monthfx :=paste("1",month,sep="-")]
stats2 = stats2[,monthfx2 :=as.Date(strptime(monthfx, "%d-%B-%Y"))]


#Plot the data

ggplot(stats, aes(datefx,no_deleted)) + geom_line() + xlab("") + ylab("Daily Deletions")

ggplot(stats2, aes(monthfx2,no_deleted)) + geom_line() + xlab("") + ylab("Monthly Deletions")



#####






