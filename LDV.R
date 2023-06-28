library("data.table")
library(ggplot2)
library(dplyr)
#read data from csv file
df22 <- read.csv("/Users/ioneciirinamadalina/Desktop/Isse supercap 2023/T_ambiant/E2_ambiant_5min_incarcare/0.5/E2_0.5A_5min.csv")
#create table with data from csv
new_tableavx <- data.frame(df22[1,])
new_variable <- numeric(nrow(df22))
# Initialize the variable "timp"
timp <- 0

# Loop over the range of indices to create time column
for (i in 1:nrow(df22)) {
  timp <- timp + 0.01
  new_variable[i] <- timp
}

# Use cbind to combine the original data frame with the new vector to add time column to the table
df22 <- cbind(df22, new_variable)
#rename column names
current_colnames <- colnames(df22)
current_colnames[1] <- "Voltage"
current_colnames[2] <- "Time_s"
colnames(df22) <- current_colnames

#complete if it is null
df22 <- df22[complete.cases(df22), ]
#Print the updated data frame
#View(df)
head(df)

#plot characteristis time on X scale and voltage on Y scale
p12<-ggplot(df22, aes(Time_s ,Voltage)) + geom_line()
p12


#plot characteristics with zoom on certain interval to see more detalied voltages
dfdrop<-filter( df , Time_s >298.45 &Time_s<298.5)
p4<-ggplot(dfdrop, aes(Time_s ,Voltage)) + geom_line()+scale_x_continuous(breaks = scales::pretty_breaks(n = 10))+scale_y_continuous(breaks = scales::pretty_breaks(n = 30)) 
p4

#plot characteristics with zoom on certain interval to see more detalied time
cap<-filter(df,Voltage<=0.64 )
p5<-ggplot(cap, aes(Time_s ,Voltage)) + geom_line()+scale_y_continuous(breaks = scales::pretty_breaks(n = 20)) +scale_x_continuous(breaks = scales::pretty_breaks(n = 20)) 
p5

