install.packages(c("tidyr", "devtools"))
install.packages("splitstackshape")
#for the fucntion count
install.packages("dplyr")


library(devtools)
library(tidyr)
#for assocstats() function Cramer's V 
install.packages("vcd")
library(vcd)
library(MASS)
library(dplyr)

#importing Big_Boston_Crime dataset and separating the blank rows as separate columns and omiting them
Big_Boston_Crime = read.csv("Crime_Incident_Reports.csv",na.strings = c("", "NA"))
summary(Big_Boston_Crime)
#use library(MASS) for %>% function
Big_Boston_Crime = Big_Boston_Crime %>% na.omit()
#verify
summary(Big_Boston_Crime)
names(Big_Boston_Crime)

#Cramer's V and chi-squared test------------------------------------------------------

# load the MASS package 
# the contingency table 
tblA = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$NatureCode) 
tblB = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$MAIN_CRIMECODE) 
tblC = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$SHIFT) 
tblD = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$FROMDATE) 
tblE = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$DATE) 
tblF = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$TIME) 
tblG = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$Year) 
tblH = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$Month) 
tblI= table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$DAY_WEEK) 
tblJ = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$UCRPART) 
tblK = table(Big_Boston_Crime$INCIDENT_TYPE_DESCRIPTION, Big_Boston_Crime$STREETNAME) 



#shows p-value
chisq.test(tblA) 
chisq.test(tblB) 
chisq.test(tblC) 
chisq.test(tblD) 
chisq.test(tblE) 
chisq.test(tblF) 
chisq.test(tblG) 
chisq.test(tblH) 
chisq.test(tblI) 
chisq.test(tblJ) 
chisq.test(tblK) 


#all entries of 'x' must be nonnegative and finite
#Cramer's V shows high value of significance for street
assocstats(tblA)
assocstats(tblB)
assocstats(tblC)
assocstats(tblD)
assocstats(tblE)
assocstats(tblF)
assocstats(tblG)
assocstats(tblH)
assocstats(tblI)
assocstats(tblJ)
assocstats(tblK)



#Excluding the folowing columns that are not considered
Big_Boston_Crime <- subset( Big_Boston_Crime, select = -NatureCode )
Big_Boston_Crime <- subset( Big_Boston_Crime, select = -MAIN_CRIMECODE )
Big_Boston_Crime <- subset( Big_Boston_Crime, select = -SHIFT )
Big_Boston_Crime <- subset( Big_Boston_Crime, select = -Year )
Big_Boston_Crime <- subset( Big_Boston_Crime, select = -Month )
Big_Boston_Crime <- subset( Big_Boston_Crime, select = -DAY_WEEK )
Big_Boston_Crime <- subset( Big_Boston_Crime, select = -UCRPART )

Boston_Crime <- Big_Boston_Crime

#When we performed Cramer's V test on the Big_Boston_Crime, 
#we noticed UCRPART had a very high Cramer's V value of 0.839 since there 
#is a one-to-one relationship between UCRPART and the INCIDENT_TYPE_DESCRIPTION column
#So we excluded the column so that the model doesnt become overfitted.


#Export dataset
write.csv(Boston_Crime, "Boston_Crime.csv" )

#deleting dataset
rm(Boston_Crime)

#names of columns
names(Boston_Crime)


#Cramer's V and chi-squared test------------------------------------------------------

# load the MASS package 
# the contingency table 
 
tbl3 = table(Boston_Crime$Incident, Boston_Crime$STREETNAME) 

#shows p-value
chisq.test(tbl3) 

#all entries of 'x' must be nonnegative and finite
#Cramer's V shows high value of significance for street
assocstats(tbl3)

#_______________________________________________________________________

#find the number of occurances of each instance in the Column "STREETNAME"
Street_occurances <- Boston_Crime %>% count(STREETNAME, sort = TRUE)
write.csv(Street_occurances, "Street_occurances_FINAL.csv" )

#find the number of occurances of each instance in the Column "INCIDENT_TYPE_DESCRIPTION"
Crime_occurances <- Boston_Crime %>% count(Incident, sort = TRUE)
write.csv(Crime_occurances, "Crime_occurances.csv" )



