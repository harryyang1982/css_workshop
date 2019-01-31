# A Research of legislator network in making Industry Law
# Sys.setlocale("LC_ALL", "korean")

# setwd("C:/Users/user/Google Drive/Research/industrylaw")
# getwd()
# install.packages("fansi")
library(fansi)
# install.packages("tidyverse")
library(tidyverse)
library(readxl)

a <- read_excel("css_workshop/aaa.xlsx")

k <- a %>% 
  gather(num, 발의자, `발의자..6`:`발의자..35`) %>% 
  separate(num, into = c("role", "num")) %>% 
  arrange(발의날짜) %>% 
  na.omit(num) %>% 
  select(-role) %>%
  select(-num) %>%
  select(c("주발의자", "발의자"))

k

library(igraph)
g <- graph_from_data_frame(k)
h <- as_adjacency_matrix(g)


# assign attributes
attr <- read_excel("css_workshop/attr.xlsx")
attr


i <- network::as.network(as.matrix(h), directed = FALSE)
network::set.vertex.attribute(i, "assembly", attr$국회)
network::set.vertex.attribute(i, "no_initiation", attr$발의수)
network::set.vertex.attribute(i, "party", attr$정당)
network::set.vertex.attribute(i, "no_elected", attr$선수)
network::set.vertex.attribute(i, "gender", attr$성별)
network::set.vertex.attribute(i, "birth_yr", attr$연령)
network::set.vertex.attribute(i, "district", attr$지역구)
network::set.vertex.attribute(i, "ideology", attr$이념)
network::set.vertex.attribute(i, "farm_ratio", attr$농가인구비율)
network::set.vertex.attribute(i, "manufacture_ratio", attr$제조업종사자비율)
network::set.vertex.attribute(i, "remarks", attr$비고)

# ergm
library(ergm)
j <- formula(i ~ edges)
summary(j)

j <- formula(i ~ edges + kstar(2) + kstar(3) + triangle)
summary(j)

j <- formula(i ~ edges + gwesp(1, fixed = TRUE))
summary(j)

j <- formula(i ~ edges + gwesp(log(3), fixed = TRUE) +
               match("no_initiation") +
               match("assembly"))
summary(j)

list.vertex.attributes(i)
get.vertex.attribute(i, "ideology") # NA
get.vertex.attribute(i, "gender") # NA
get.vertex.attribute(i, "no_initiation")
get.vertex.attribute(i, "assembly")
get.vertex.attribute(i, "party") # NA
get.vertex.attribute(i, "no_elected") # NA
get.vertex.attribute(i, "birth_yr") # NA
get.vertex.attribute(i, "district") # NA
get.vertex.attribute(i, "ideology") # NA
get.vertex.attribute(i, "farm_ratio") # NA
get.vertex.attribute(i, "manufacture_ratio") # NA
get.vertex.attribute(i, "remarks") # NA

plot(i)
summary(i)

head(V(g))




# model fitting
set.seed(42)
j.fit <- ergm(j)
anova(j.fit)
summary(j.fit)

