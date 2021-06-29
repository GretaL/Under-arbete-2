
library(httr)
library(jsonlite)
library(dplyr)

#https://statistik-api.uka.se/api/indicators ukä:s api till statistikdatabasen


#laddar ned totalräknade registreringar för Södertörns högskola.
#Nästa uppgift blir att ta fram data för kön och ålder.

httr::set_config(config(ssl_verifypeer = 0L))# Tar bort certifikatet i ssl, obra men data går att ladda ned


#laddar ned registrerade för Södertörns högskola HT1996 och framåt
#klickade mig fram till SH via huvudapi:et till UKÄ ovan
sh_reg_stud <- GET("https://statistik-api.uka.se/api/totals/1?university=44&year=HT2019") 

status_code(sh_reg_stud) # kontrollerar statuskod för HTTP, 200 om allt är korrekt

headers(sh_reg_stud) #kontrollerar formatet för filen, json eller xml

glimpse(sh_reg_stud) # ser kolumnrubriker


str(content(sh_reg_stud)) #Innehållet i anropet


sh_reg_parsed <- content(sh_reg_stud, as="text") %>% fromJSON() #parsar innehållet och pipar det genom fromJSON

sh_reg_parsed$yearly_totals #Tittar på innehållet i listan $yearly_totals

sh_reg_df <- as_tibble(sh_reg_parsed$yearly_totals)

#---------------------------

