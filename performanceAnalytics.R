# Settings
## Core Tidyverse
library(tidyverse)

## Time Series
library(tidyquant)
library(tibbletime)

## Time Frame
finDate <- today()
staDate <- today() - weeks(52)

## stock_lst
stock_lst <- read_csv("./inputs/cac40.csv")

# Ra
Ra <- stock_lst$symbol %>% 
  tq_get(get  = "stock.prices",
         from = staDate,
         to   = finDate) %>%
  group_by(symbol) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "monthly", 
               col_rename = "Ra")

# Rb
Rb <- "^N100" %>%
  tq_get(get  = "stock.prices",
         from = staDate,
         to   = finDate) %>%
  tq_transmute(select     = adjusted, 
               mutate_fun = periodReturn, 
               period     = "monthly", 
               col_rename = "Rb")

# RaRb
RaRb <- left_join(Ra, Rb, by = c("date" = "date"))

# CAPM
RaRb_capm <- RaRb %>%
  tq_performance(Ra = Ra, 
                 Rb = Rb, 
                 performance_fun = table.CAPM)

# Annualized Returns
annualizedReturns <- Ra %>%
  tq_performance(Ra = Ra, 
                 Rb = NULL, 
                 performance_fun = table.AnnualizedReturns)
