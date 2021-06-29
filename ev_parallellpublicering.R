#
#
#Ev parallellpublicering
#200714 GL
#Artiklar som inte är OA
#
#

library(tidyverse)

source('/home/shub/src/common/lib/sh_parameters.R')
source('/home/shub/src/common/lib/sh_diva_bibliometrics_functions.R')


diva <- read_csv(file="/home/shub/assets/diva/diva_researchpubl_sh_latest.csv")
diva <- diva %>% filter(between(Year, 2005, 2018))

#Använd Sherpas API och matcha ISSN
#Begränsa till SH-författare först eller sist? Byt input

atiklar <- diva %>%
  filter(ContentType == "Refereegranskat") %>%
  filter(PublicationType == "Artikel i tidskrift") %>%
  filter(is.na(FullTextLink)) %>%
  filter(is.na(FreeFulltext)) %>%
  select(PID, DOI, Journal, JournalISSN, JournalEISSN, Status, Year)
  