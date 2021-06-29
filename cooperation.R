#
#
#cooperation
#190304 GL
#
#

library(tidyverse)

source('/home/shub/src/common/lib/sh_parameters.R')
source('/home/shub/src/common/lib/sh_diva_bibliometrics_functions.R')

diva <- read_csv("/home/shub/assets/diva/diva_researchpubl_sh_latest.csv")

diva <- diva %>% 
  filter(between(Year, 2014, 2019)) %>%
  filter((is.na(Status))|Status=="published")

#Få in Italy eller Italien
diva <- mutate(diva, coop = ifelse(grepl("Italien", diva$Name), T, F))

only_coop <- diva %>% 
  filter(coop == TRUE) %>%
  select(PID, Name, Title, PublicationType, Journal,JournalISSN, JournalEISSN, Year, Volume, Issue, HostPublication, Publisher, 
         DOI, ISI, ScopusId, ContentType, PublicationSubtype, Categories)

write_csv(only_coop, "Italien")
