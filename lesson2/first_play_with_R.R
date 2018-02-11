getwd()
setwd("/Users/markmeleka/Documents/Comp\ Sci\ and\ Programming\ Learning/Udacity/DAND/Exploratory_Data_Analysis/eda-course-materials/lesson2")

statesInfo <- read.csv("stateData.csv")

regionOne <- subset(statesInfo, state.region == 1)
head(regionOne,3)

regionOneBracket <- statesInfo[statesInfo$state.region == 1, ]
head(regionOneBracket, 3)

regionOne == regionOneBracket

