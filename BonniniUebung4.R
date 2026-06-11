# Data source:
# https://osf.io/xb8yj/?view_only=966abafccc844b99924da85be3f76272
# Complete path on my computer to the directory, where Dataset.csv is.
# setwd("/Users/mmiche/Desktop/TeachingClass/FS2026/Theorieseminar/Uebungen/Uebung4/")
data0 <- read.delim(file="Dataset.csv")
# Consensus to participate
data <- data0[!is.na(data0$InformedConsent) & data0$InformedConsent== 1,]
# Independent variables:
indepVars0 <- colnames(data)[c(49:51,77,78,81,96,89,79)]
offlineIdx <- seq(7, 25, by=2)
offlineSum <- apply(data[,offlineIdx], 1, function(x) {sum(x, na.rm = TRUE)})
# How many offline contacts were reported? (max. 10)
offlineContacts <- apply(data[,offlineIdx], 1, function(x) {length(which(!is.na(x)))})
onlineIdx <- seq(28, 46, by=2)
onlineSum <- apply(data[,onlineIdx], 1, function(x) {sum(x, na.rm = TRUE)})
# How many online contacts were reported? (max. 10)
onlineContacts <- apply(data[,onlineIdx], 1, function(x) {length(which(!is.na(x)))})
# Compute predictors which are not yet in the raw dataset:
# Number of all reported contacts (offline and online)
data$contacts <- offlineContacts + onlineContacts
# Proportion of offline contacts, relative to number of all contacts:
data$proportionOffline <- offlineContacts/(data$contacts)
# Mean closeness of offline contacts
data$offlineContactsCloseness <- data$OfflineSocialContacts_Scoring/offlineContacts
# Mean closeness of online contacts
data$onlineContactsCloseness <- data$OnlineSocialContacts_Scoring/onlineContacts
# Instruction of how to compute infectedProvReg, see paper
data$infectedProvReg <- data$Infected_Province/data$Infected_Region
# Instruction of how to compute infectedRegCountry, see paper
data$infectedRegCountry <- data$Infected_Region/data$Infected_Country
# Add the newly computed predictors to indepVars0
indepVars0 <- c(indepVars0, colnames(data)[101:106])
# Produce same order as in Table 3 in the paper
indepVars <- indepVars0[c(1:7, 14,15, 8:13)]
# Education has been dichotomized
data$Educ <- dplyr::if_else(condition = data$Educ==1, 0, 1)
# Dependent variable Depression:
deprCols <- paste0("MentalHealthIssues_", 1:5)
data$Depression <- apply(data[,deprCols], 1, mean)
idxNa <- apply(data[,c("Depression", indepVars)], 1, function(x) any(is.na(x)))
dataTest <- data[!idxNa,c("Depression", "SpaceAdequacy_Privacy", "offlineContactsCloseness", "Occup", "contacts", "SocialIsolation")]
summary(dataTest$Depression)
# summary(lm(Depression ~ ., data=dataTest))
coefficients(summary(lm(Depression ~ ., data=dataTest)))


all(dataTest$SpaceAdequacy_Privacy%%1==0L)
dataTest$offlineContactsCloseness[1:20]

table(dataTest$Occup)

all(dataTest$contacts%%1==0L)
all(dataTest$SocialIsolation%%1==0L)
