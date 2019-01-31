library(tidyverse); library(readxl)

y2000 <- read_excel("dataset/datasets.xlsx", sheet = "2000")
y2005 <- read_excel("dataset/datasets.xlsx", sheet = "2005")
y2010 <- read_excel("dataset/datasets.xlsx", sheet = "2010")
y2015 <- read_excel("dataset/datasets.xlsx", sheet = "2015")

# 정의
# 17대(2004~2008): y2000 자료 활용
# 18대(2008~2012): y2005 자료 활용
# 19대(2012~2016): y2010 자료 활용
# 20대(2016~2020): y2015 자료 활용

