library(tidyverse)
library(readxl)

industry <- read_excel("산업집적공동발의네트워크17to20.xlsx")

industry_tidy <- industry %>% 
  gather(발의자, 의원명, 발의자:발의자__30) %>% 
  separate(발의자, into = c("발의", "순서"), sep="__") %>% 
  mutate(순서=as.numeric(순서)) %>% 
  mutate(순서=ifelse(is.na(순서), 1, 순서 + 1)) %>% 
  na.omit(의원명) %>% 
  select(-발의)

write_rds(industry_tidy, "css_workshop/network.rds")

industry_tidy %>% 
  group_by(발의날짜) %>% 
  summarize()