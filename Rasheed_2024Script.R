# Data source: https://data.mendeley.com/datasets/mmnzx4w8cg/1
data <- read.csv(file="Rasheed_2024DATA.csv")
# How many observations: 1242
nrow(data)

# Use mental_health as outcome variable (mental_health must be understood as mental disorder)
table(data$mental_health)
prop.table(table(data$mental_health))*100
# If "Possibly" means something like "rather yes than no", then about 65% of the 1242 respondents indicate that they may have a mental disorder diagnosis.

# Only 2 variables which contain numeric data
summary(data[,c("mh_share", "age")])

# The other variables will be transformed to numeric, after knowing
# what is their content:
for(i in colnames(data)[-c(8,9)]) {
    print(i)
    print(table(data[,i]))
    cat("------------------------\n")
}

# Variables with only No and Yes, coded as 0 for no and 1 for yes
for(i in c("tech_company", "mh_employer_discussion", "mh_coworker_discussion", "medical_coverage")) {
    data[,i] <- as.numeric(as.factor(data[,i])) - 1
}

# Variables with answers I don't know, No, and Yes, coded as 0 for I don't know, 1 for no, and 2 for yes
for(i in c("benefits", "workplace_resources")) {
    data[,i] <- as.numeric(as.factor(data[,i])) - 1
}

# Variable mental_health, answers Don't know (= 0), No (= 1), Possibly (= 2), Yes (= 3)
data[,"mental_health"] <- as.numeric(as.factor(data[,"mental_health"])) - 1

# Variable gender, answers Female (= 0), Male (= 1), Other (= 2)
data[,"gender"] <- as.numeric(as.factor(data[,"gender"])) - 1

# Check that the coding is as it has been intended, compare table output of
# numeric variables with the table output of script lines 11-15.
for(i in colnames(data)[-c(8,9)]) {
    print(i)
    print(table(data[,i]))
    cat("------------------------\n")
}

# Transform answers "I don't know", "Don't know", and "Possibly" to NA.
# Reason: NAs (= missing data, NA = not available) are removed automatically
# in a regression model in R.
# This concerns variables: benefits, workplace_resources, and mental_health
# BEWARE: Removal is a drastic treatment. There may be other ways to use
# this information. For example: "Possibly" is very different from I don't know.

# Check variables before:
table(data$benefits)
table(data$workplace_resources)
table(data$mental_health)

data$benefits[data$benefits==0] <- NA
data$workplace_resources[data$workplace_resources==0] <- NA
data$mental_health[data$mental_health %in% c(0, 2)] <- NA

# Check variables afterwards:
table(data$benefits)
table(data$workplace_resources)
table(data$mental_health)

# Recode values of mental_health (before 1 is now 0, before 3 is not 1)
# That means mental health disorder no = 0, yes = 1
data$mental_health[data$mental_health==1] <- 0
data$mental_health[data$mental_health==3] <- 1

# Recode also benefits and workplace_resources:
data$benefits <- data$benefits - 1
data$workplace_resources <- data$workplace_resources - 1

# How many values are lost by transforming them to NA:
(lost_to_na <- length(which(apply(data, 1, function(x) any(is.na(x))))))
# How many observations remain:
nrow(data) - lost_to_na

# Bivariate comparison between gender (female, male, other) and
# mental_health (0 = mental disorder absent, 1 = mental disorder present)
# 71.3% of women say yes, 55.3% of men say yes, 81.4% of other say yes
prop.table(table(data[,c("gender", "mental_health")]), margin=1)

# Run a logistic regression model, use mental health as outcome and age as predictor:
summary(glm(mental_health ~ age, family = binomial(link="logit"), data=data))

# Run a logistic regression model, use mental health as outcome:
model <- glm(mental_health ~ tech_company + benefits + workplace_resources + medical_coverage + gender + age, family = binomial(link="logit"), data=data)
summary(model)

# Run a logistic regression model, use mental health as outcome, drop age from predictors:
model <- glm(mental_health ~ tech_company + benefits + workplace_resources + medical_coverage + gender, family = binomial(link="logit"), data=data)
summary(model)
# --------------------------------------------------

# eg = expand.grid
# This are ALL the groups that are produced,
# by combining each level of one of these
# binary predictors with the levels of the
# remaining predictors.
eg <- base::expand.grid(
    gender=0:1,
    tech_company=0:1,
    benefits=0:1,
    workplace_resources=0:1,
    medical_coverage=0:1
)
# sum3, because the sum exludes gender.
sum4 <- apply(eg[,-1], 1, sum)
# Produce increasing order of whether just
# one of the 3 predictors is present, two,
# or all 3.
eg <- eg[order(sum4),]
cbind(eg, sort(sum4))

# Actively remove all rows which contain at least one missing value.
d <- data[!apply(data, 1, function(x) any(is.na(x))),]
nrow(d)

d1 <- d[,c("gender", "tech_company", "benefits", "workplace_resources", "medical_coverage")]
datString <- as.character(unlist(d1))
datStringMat <- matrix(datString, nrow=nrow(d1))

datStringLs <- list()
for(i in 1:nrow(datStringMat)) {
    datStringLs[[i]] <- paste0(datStringMat[i,], collapse = "")
}
datStringVec <- unlist(datStringLs)

rows <- cases <- c()
for(i in 1:nrow(eg)) {
    idx_i <- which(datStringVec %in% paste0(eg[i,], collapse = ""))
    rows <- c(rows, nrow(d[idx_i,]))
    cases <- c(cases, sum(d[idx_i,"mental_health"]))
}
perc <- cases/rows *100
perc[is.na(perc)] <- NA
resDf <- data.frame(rows, cases, Percent=perc, gender=eg$gender)
resDf$gender <- forcats::as_factor(resDf$gender)
resDf
# A positive trend is visible. The same is expressed
# in the model output: 3 out of 4 predictors are positive.
# The negative predictor is the weakest of the 4, i.e.,
# it has the lowest z value.
library(ggplot2)
ggplot(data=resDf, aes(x=1:nrow(resDf), y=Percent, color=gender)) +
    geom_point()
# --------------------------------------