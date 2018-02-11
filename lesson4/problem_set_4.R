#load the ggplot package
library(ggplot2)

data(diamonds)
head(diamonds)

ggplot(aes(x=x, y=price), data=diamonds) +
   geom_point()

#Observations:
#Price increases exponentially with x. There are some outliers at x=0.

cor.test(diamonds$price, diamonds$x)
cor.test(diamonds$price, diamonds$y)
cor.test(diamonds$price, diamonds$z)

ggplot(aes(x=depth, y=price), data=diamonds) +
  geom_point(alpha=1/100) + 
  scale_x_continuous(breaks=seq(0,80,2))

cor.test(diamonds$price, diamonds$depth)

#create a plot of price v. carat, omitting the top 1% of carat values and top 1% of prices
carat_upper_limit <- quantile(diamonds$carat, .99)
price_upper_limit <- quantile(diamonds$price, .99)

ggplot(aes(x=carat, y=price), 
       data=subset(diamonds, 
                   carat < carat_upper_limit || price < price_upper_limit)) + 
  geom_point()

# Create a scatterplot of price vs. volume (x * y * z).
diamonds$volume <- (diamonds$x * diamonds$y * diamonds$z)

ggplot(aes(x=volume, y=price), data=diamonds) +
  geom_point()


'
You can find out how many diamonds have 0 volume by using count(diamonds$volume == 0). 
The count() function comes with the plyr package.

Note: If you ran the count function from plyr, 
you need to run this command in R to unload the plyr package.
detach("package:plyr", unload=TRUE)
The plyr package will conflict with the dplyr package in later exercises.
'

diamonds_no_outliers <- subset(diamonds, diamonds$volume > 0 & diamonds$volume <= 800)

cor.test(diamonds_no_outliers$price, diamonds_no_outliers$volume)


ggplot(aes(x= volume, y=price), data= diamonds_no_outliers) + 
  geom_point(alpha = 1/100) + 
  geom_smooth() + 
  coord_cartesian(xlim=c(0,400))

#check out these smoothing options:
#https://stats.idre.ucla.edu/r/faq/how-can-i-explore-different-smooths-in-ggplot2/

# Do you think this would be a useful model to estimate
# the price of diamonds? Why or why not?

# yes? but only up to volume 150. 
#Then it looks like there are other factors to take into account.

library(dplyr)

diamondsByClarity <- summarise(diamonds,
                               mean_price = mean(price),
                               median_price = median(price),
                               min_price = min(price),
                               max_price = max(price),
                               n = n())

diamondsByClarity <- diamonds %>%
  group_by(clarity) %>%
  summarise(mean_price = mean(price),
            median_price = median(price),
            min_price = min(price),
            max_price = max(price),
            n = n()) %>%
  arrange(clarity)

diamonds_by_clarity <- group_by(diamonds, clarity)
diamonds_mp_by_clarity <- summarise(diamonds_by_clarity, mean_price = mean(price))

diamonds_by_color <- group_by(diamonds, color)
diamonds_mp_by_color <- summarise(diamonds_by_color, mean_price = mean(price))

diamonds_by_cut <- group_by(diamonds, cut)
diamonds_mp_by_cut <- summarise(diamonds_by_cut, mean_price = mean(price))

# Your task is to write additional code to create two bar plots
# on one output image using the grid.arrange() function from the package
# gridExtra.
library(gridExtra)

A <- ggplot(aes(x=clarity, y=mean_price), data=diamonds_mp_by_clarity) + 
  geom_col()

B <- ggplot(aes(x=color, y=mean_price), data=diamonds_mp_by_color) + 
  geom_col()

C <- ggplot(aes(x=cut, y=mean_price), data=diamonds_mp_by_cut) + 
  geom_col()

grid.arrange(A, B, C)


