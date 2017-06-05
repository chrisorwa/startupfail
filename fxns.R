#domain data
library(data.table)
library(dplyr)
act_time = function(unxtim){
  dd = (as.POSIXct(unxtim ,origin = "1970-01-01"))
  return(dd)
}

domain_numbs = data.table(read.csv("domains_numbers.csv", stringsAsFactors = FALSE))

totdoms = domain_numbs[details == "Total domains"]
totreg24hrs = domain_numbs[details == "Total domains registered within 24 hours"]
totren24hrs = domain_numbs[details == "Total domains renewed within 24 Hours"]

data= left_join(totren24hrs,totreg24hrs, by = "time") 

#unique(domain_numbs$details)

names(data) = c("time", "g", "Total domains renewed within 24 Hours", "h", "domains registered within 24 hours")

data = data[,c("g","h"):=NULL,with=FALSE]

data = left_join(data,totdoms, by="time")

names(data) = c("time", "domains_renewed_24hrs","domains_regs_24hrs", "details","total_domains" )

data$details = NULL

data$nxt = shift(data$total_domains, 1,fill=0)
data = data[-1,] #remove the first row because 

data = data[,domains_del_24hrs :=  (domains_regs_24hrs+nxt - total_domains)]



as.Date(as.POSIXct(1465801206 ,origin = "1970-01-01"))
