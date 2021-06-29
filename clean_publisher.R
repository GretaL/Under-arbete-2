#
#
# clean_publisher
# 200228 GL
# Städa förlag. Kolla norska listan
# Komplettera förlag tidskrifter


library(tidyverse)

diva <- read_csv("/home/shub/assets/diva/diva_researchpubl_latest.csv")
diva <- diva %>% filter(between(Year, 2015, 2020))

tidskrifter_forlag <- diva %>%
  filter(PublicationType == "Artikel i tidskrift"|PublicationType == "Artikel, forskningsöversikt" 
         |PublicationType == "Artikel, recension") %>%
  filter(ContentType != "Övrig (populärvetenskap, debatt, mm)") %>%
  select(PID, PublicationType, Journal, JournalISSN, JournalEISSN, Year, Publisher, ContentType)

write_csv(tidskrifter_forlag, "tidskrifter_förlag.csv")

bok_forlag <- diva %>%
  filter(PublicationType == "Bok" |PublicationType == "Kapitel i bok, del av antologi" |PublicationType == "Konferensbidrag" |PublicationType == "Samlingsverk (redaktörskap)" |PublicationType == "Proceeding (redaktörskap)") %>%
  count(Publisher) %>%
  arrange(Publisher)
