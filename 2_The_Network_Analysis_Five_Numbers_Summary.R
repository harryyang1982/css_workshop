library(UserNetR)
library(statnet)

data("Moreno")

Moreno

# 2.3 Simple visualization

gender <- Moreno %v% "gender"
gender
plot(Moreno, vertex.col = gender + 2, vertex.cex = 1.2)

# 2.4 Basic Description

## 2.4.1 Size

network.size(Moreno)

summary(Moreno, print.adj = F)

## 2.4.2 Density

den_head <- 2 * 46 / (33 * 32)
den_head
gden(Moreno)

## 2.4.3 Components

components(Moreno)

## 2.4.4 Diameter

lgc <- component.largest(Moreno, result = "graph")
gd <- geodist(lgc)
max(gd$gdist)

## 2.5 Clustering Coefficients

gtrans(Moreno, mode = "graph")