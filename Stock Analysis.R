# Install required packages. Tidyquant: Financial data analysis and Quantmod: Quantitative 
# financial modelling and analysis.
 
 install.packages(c("tidyquant", "quantmod", "ggplot2", "dplyr"))
 install.packages("plotly")
 install.packages("TTR")
 install.packages("lubridate")
 
 # Load required libraries
 library(tidyquant)
 library(quantmod)
 library(ggplot2)
 library(dplyr)
 library(plotly)
 library(TTR)
 library(lubridate)
 
 # Extract stock data of FAANG companies from Yahoo Finance
 
 stock_symbols <- c("AMZN" , "AAPL", "META", "GOOGL", "NFLX")
 start_date <- "2019-01-01"
 end_date <-  Sys.Date()
 
 # Download stock data from Yahoo Finance
 
 stock_data <-tq_get(stock_symbols,from = start_date, to = end_date)
 
# Explore and clean data
 
 head(stock_data)
 summary(stock_data)

#Visualize the stock prices
# In this case, index(stock_data) points to the date and coredata(stock_data)
# refers to the closing cost of the stock. 
 
gg <- ggplot(stock_data, aes(date, adjusted, color=symbol )) +
  geom_line () +
  labs(title = "Stock Prices Comparision", 
       x= "Year", 
       y= "Stock Prices ($)") 

# Create an interactive plot
interactive_plot <- ggplotly(gg)

# Display interactive plot

interactive_plot

# Technical analysis indicator
#Find RSI using TTR package

data <- stock_data %>%
  mutate(RSI = RSI(close, n=14))
head(data,20)

# Aggregate data by month
data$date <- as.Date(data$date)
data$month <- month(data$date)
data$year <- year(data$date)


gg_2 <- ggplot (data, aes(date, RSI, color= symbol))+
  geom_line()+ 
  facet_wrap(~symbol, scales = "free_y", labeller = labeller(year = label_both)) +
  labs(x="Years", 
       Y="RSI Values")
  #scale_x_continuous(breaks = 1:12, labels = month.abb)

# Create an interactive plot
interactive_plot_2 <- ggplotly(gg_2)

interactive_plot_2

 
 
 
 
 