library(tidyverse)
library(readxl)

population <- read_excel("css_workshop/인구.xlsx",
                         skip = 1) %>% 
  select(address = `행정구역(시군구)별`,
         popu=`총인구수 (명)`) 
population

industry <- read_excel("css_workshop/산업.xlsx") %>% 
  select(`지역별(시/군/구)`:`총종사자수_계`) %>% 
  rename(address = `지역별(시/군/구)`,
         industry = `산업분류별`,
         size = `규모별`,
         worker = `총종사자수_계`) %>% 
  select(-size) %>% 
  fill(address) %>% 
  mutate(industry = rep(c("농업", "광업", "제조업"), 154)) %>% 
  group_by_at(vars(-worker)) %>% 
  mutate(row_id=1:n()) %>% ungroup() %>% 
  spread(industry, worker) %>% 
  select(-row_id) %>% 
  mutate(제조업2=광업+제조업)

merged <- left_join(industry, population, by = "address") %>% 
  mutate(aggri_rate = 농업 / popu,
         manu_rate = 제조업2 / popu)

write_csv(merged, "css_workshop/merged.csv")
library(xlsx)

write.xlsx(merged, "css_workshop/merged.xlsx")
