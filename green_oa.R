#
#
#
#green_oa
#190815 GL
#Sammanställning av artiklar som kanske kan parallellpubliceras. Endast refereedartiklar som är affilierade till högskolan.
#Inte tidskrifter som är registrerade i DOAJ eller redan har fulltext i DiVA. Blir en csv-fil.
#
#
#

library(tidyverse)

source('/home/shub/src/common/lib/sh_parameters.R')
source('/home/shub/src/common/lib/sh_diva_bibliometrics_functions.R')

#Läs in data från DiVA. Vi använder en csvall2-fil.
diva <- read_csv(file = "/home/shub/assets/diva/diva_researchpubl_sh_latest.csv")

#Tidskriftslista nerladdad från doaj.org.
doaj_listan <- read_csv("/home/shub/assets/doaj.csv")

diva$JournalISSN[is.na(diva$JournalISSN)] <- 0L
diva$JournalEISSN[is.na(diva$JournalEISSN)] <- 0L
diva$FreeFulltext[diva$FreeFulltext == "true"] <- TRUE

green_oa <- diva %>%
  filter(between(Year, 2017, 2018)) %>%
  filter(PublicationType %in% c("Artikel, forskningsöversikt", "Artikel i tidskrift")) %>%
  filter(ContentType == "Refereegranskat")%>%
  mutate(doaj = ((JournalISSN %in% doaj_listan$`Journal ISSN (print version)`)|
                   (JournalEISSN %in% doaj_listan$`Journal EISSN (online version)`)))%>%
  filter(doaj == "FALSE")%>%
  filter(is.na(FullTextLink))%>%
  select(PID, Name, Title, Journal, JournalISSN, JournalEISSN, Year, Status, DOI, Urls, FreeFulltext)
  
  write_csv(green_oa, "Ev_green_oa.csv")
  