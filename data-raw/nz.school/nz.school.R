
library(tidyverse)
library(readxl)

path <- "data-raw/nz.school/Age-and-Region-2016.xls"

sheets <- excel_sheets(path)

region.names <- read_excel(path, skip = 2, n_max = 1, col_names = FALSE) %>%
    as.character()
region.names <- region.names[seq(from = 2, to = length(region.names), by = 2)]

nz.school <- lapply(sheets, read_excel, path = path, range = "A4:AI19") %>%
    bind_rows(.id = "year") %>%
    mutate(year = factor(year, levels = seq_along(sheets), labels = sheets)) %>%
    rename(age = X__1) %>%
    mutate(age = sub("^Age ", "", age)) %>%
    filter(age != "Total") %>%
    mutate(age = factor(age, levels = c(5:18, "19+"))) %>%
    gather(key, count, -year, -age) %>%
    separate(key, into = c("sex", "region"), fill = "right") %>%
    mutate(region = as.integer(region),
           region = ifelse(is.na(region), 1L, region + 1L),
           region = region.names[region],
           region = sub(" Region", "", region)) %>%
    filter((region != "Total") & (region != "Correspondence School")) %>%
    mutate(region = recode(region, Canterbury = "Chatham Is. County")) %>%
    mutate(count = ifelse(is.na(count), 0L, count))

nz.school <- xtabs(count ~ age + sex + region + year,
                   data = nz.school)
nz.school <- array(nz.school,
                   dim = dim(nz.school),
                   dimnames = dimnames(nz.school))

save(nz.school,
     file = "data/nz.school.rda",
     compress = "xz")


                   

    

    
    

