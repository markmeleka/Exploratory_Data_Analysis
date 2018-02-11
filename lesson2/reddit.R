#install.packages('ggplot2', dependencies = T)
#library(ggplot2)

reddit <- read.csv("reddit.csv")
summary(reddit)
levels(reddit$children)

qplot(data = reddit, x = age.range)

#age.range.f.bad.order <- factor(reddit$age.range)
#levels(age.range.f.bad.order)

#age.range.f <- factor(reddit$age.range, levels= c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"))
#levels(age.range.f)
#qplot(data = reddit, x = age.range.f)

reddit$age.range <- ordered(reddit$age.range, levels= c("Under 18", "18-24", "25-34", "35-44", "45-54", "55-64", "65 or Above"))
qplot(data = reddit, x = age.range)

