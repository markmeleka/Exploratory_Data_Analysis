#1
#must load the ggplot package first
library(ggplot2) 

#loads the diamonds data set since it comes with the ggplot package
data(diamonds) 

summary(diamonds)

diamonds$color
?diamonds

#2-3
qplot(x= price, data= diamonds, bins = 50, color = I('black'))
summary(diamonds$price)

#4
sum(diamonds$price >= 15000)

#5
# Explore the largest peak in the
# price histogram you created earlier.
# Try limiting the x-axis, altering the bin width,
# and setting different breaks on the x-axis.
qplot(x= price, data= diamonds, binwidth= 25,color = I('black')) + 
  scale_x_continuous(limits = c(400,1200), breaks = seq(400,1200, 50))

#6
#break out by cut
qplot(x= price, data= diamonds, color = I('black')) + 
  facet_wrap(~cut)

#7
#price stats by cut
by(diamonds$price, diamonds$cut, summary)

#8
# The distributions should be somewhat similar,
# but the histograms we created don't show that.

# The 'Fair' and 'Good' diamonds appear to have 
# different distributions compared to the better
# cut diamonds. They seem somewhat uniform
# on the left with long tails on the right.
qplot(x= price, data= diamonds, color = I('black')) + 
  facet_wrap(~cut, scales = "free_y")

#9
# Create a histogram of price per carat
# and facet it by cut. You can make adjustments
# to the code from the previous exercise to get
# started.

# Adjust the bin width and transform the scale
# of the x-axis using log10.
qplot(x= price/carat, data= diamonds, color = I('black')) + 
  xlab('price per carat') +
  facet_wrap(~cut, scales = "free_y") + 
  scale_x_log10()

#10
# Investigate the price of diamonds using box plots,
# numerical summaries, and one of the following categorical
# variables: cut, clarity, or color.

qplot(x= cut, y = price, data= diamonds, geom = 'boxplot')
qplot(x= clarity, y = price, data= diamonds, geom = 'boxplot')
qplot(x= color, y = price, data= diamonds, geom = 'boxplot')


#11
#price stats by color
by(diamonds$price, diamonds$color, summary)

"You can use the function IQR() to find the interquartile range. Pass it a subset of the diamonds data frame. 

For example:
  IQR(subset(diamonds, price <1000)$price)
Remember that subset() returns a data frame 
so we need to use $price on the end to access that variable."

#12
# Investigate the price per carat of diamonds across
# the different colors of diamonds using boxplots.
qplot(x= color, y = price/carat, data= diamonds, geom = 'boxplot')

#13
#investigate the weight of the diamonds (carat) using a frequency polygon. 
#Use different bin widths.

qplot(x= carat, data= diamonds, binwidth = 0.1, geom = 'freqpoly') + 
  scale_x_continuous(limits = c(0,3), breaks = seq(0,6,0.2)) + 
  scale_y_continuous(breaks= seq(0,12000, 2000))

#14
# Your task is to download a data set from Gap Minder of your choice
# and create 2-5 plots that make use of the techniques from Lesson 3.

# You might use a simple histogram, a boxplot split over a categorical variable,
# or a frequency polygon. The choice is yours!
#Internet users per 100 people

#https://discussions.udacity.com/t/l4-l6-and-l8-ps-gapminder-data-work-shared/314797

setwd("/Users/markmeleka/Documents/Comp Sci and Programming Learning/Udacity/DAND/Exploratory_Data_Analysis/eda-course-materials/lesson3")
internet_users <- read.csv('Internet_user_per_100.csv', stringsAsFactors=FALSE, sep=",", 
                           header = T, row.names = 1, check.names = F)

#the below line omits any rows with NA values. we just want to 0 them out. Or do we?
#internet_users <- na.omit(internet_users)

#change first column name to "country"
colnames(internet_users)[1] <- "country"

head(internet_users)
str(internet_users)
summary(internet_users)

selected_countries <- c('Brazil', 'Canada', 'China', 'Egypt',
                        'India', 'Iraq', 'Nigeria', 'Russia', 
                        'Saudi Arabia', 'United States')
subset_internet_users <- subset(internet_users, country %in% selected_countries)

#this doesn't do what I want it to
ggplot(subset(internet_users, country %in% selected_countries) + 
         geom_line(aes(internet_users$country, internet_users$'1990')))

#neither does this
qplot(data = subset_internet_users, 
      x=country, y = subset_internet_users$'2002', 
      color = country)

#trying again but pulling data in with country names as row.names 
#instead of in their own column
qplot(data = internet_users, 
      x=row.names, y = internet_users$'2002', 
      color = row.names)

t(subset_internet_users)
