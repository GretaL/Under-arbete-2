library(tidyverse)
library(httr)
library(jsonlite)



key <- "8fd68da877f1d22f2262a2dc876fb8d9"
DOI <- "DOI(10.1093/hgs/dcx050) OR DOI(10.22394/2073-7203-2016-34-4-118-147)"

scop <- GET("https://api.elsevier.com/content/search/scopus",
    query = list(apiKey = key, httpAccept = "application/json", query = "AFFIL(Sodertorn*)")) ## format the URL to be sent to the API

status_code(scop) # kontrollerar statuskod för HTTP, 200 om allt är korrekt 

headers(scop) #kontrollerar formatet för filen, json eller xml

glimpse(scop) # ser kolumnrubriker

str(content(scop))

scop_parsed <- content(scop, as="text") %>% fromJSON()

scop_cit <- GET("http://api.elsevier.com/content/search/scopus",
                 query = list(apiKey = key, httpAccept = "application/json", query = DOI, field = "citedby-count", field = "prism:doi"))
                 
status_code(scop_cit) # kontrollerar statuskod för HTTP, 200 om allt är korrekt Stoppkod för ej 200?

headers(scop_cit) #kontrollerar formatet för filen, json eller xml
scop_cit$headers$"content-type"

glimpse(scop_cit) # ser kolumnrubriker Behövs denna?
names(scop_cit)

str(content(scop_cit))

scop_cit_parsed <- content(scop_cit, "text") %>% fromJSON() #raw eller parsed

scop_cit_parsed$citedby_count #Tittar på innehållet i listan $yearly_totals
scop_cit$citedby-count

scop_it_df <- as_tibble(scop_cit_parsed)

doi <- lapply(records, XML::xpathSApply, "./prism:doi", XML::xmlValue, namespaces = c(prism = "http://prismstandard.org/namespaces/basic/2.0/")) ## handle potentially missing doi nodes
doi[sapply(doi, is.list)] <- NA
doi <- unlist(doi)


