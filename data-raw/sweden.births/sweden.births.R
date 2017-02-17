#!/usr/local/bin/Rscript

library(methods)
library(tidyr)
library(dplyr)

getData <- function(filename) {
    file <- file.path("data-raw/sweden.births", filename)
    d <- read.csv(file = file,
                  skip = 2)
    d <- gather_(d,
                 key_col = "year",
                 value_col = "count",
                 gather_cols = paste0("X", 1968:2015))
    mutate(d,
           region = sub("^(.+) (.+)( county)$", "\\2", region),
           age = sub(" years$| year$", "", age.of.mother),
           sex = factor(sex,
                        levels = c("women", "men"),
                        labels = c("Females", "Males")),
           year = as.integer(sub("X", "", year)))
}
filenames <- c("BE0101E2.csv",
               "BE0101E2-2.csv")
region.names <- c(Stockholm = "Stockholm",
                  Uppsala = "Uppsala",
                  Sodermanland = "S\xfc\xbe\x8d\xa6\x98\xbcdermanland",
                  Ostergotland = "\xfc\xbe\x8d\xa6\x90\xbcsterg\xfc\xbe\x8d\xa6\x98\xbctland",
                  Jonkoping = "J\xfc\xbe\x8d\xa6\x98\xbcnk\xfc\xbe\x8d\xa6\x98\xbcping",
                  Kronoberg = "Kronoberg",
                  Kalmar = "Kalmar",
                  Gotland = "Gotland",
                  Blekinge = "Blekinge",
                  Skane = "Sk\xfc\xbe\x8d\x96\x94\xbcne",
                  Halland = "Halland",
                  Gotaland = "G\xfc\xbe\x8d\xa6\x98\xbctaland",
                  Varmland = "V\xfc\xbe\x8d\x86\x94\xbcrmland",
                  Orebro = "\xfc\xbe\x8d\xa6\x90\xbcrebro",               
                  Vastmanland = "V\xfc\xbe\x8d\x86\x94\xbcstmanland",
                  Dalarna = "Dalarna",                       
                  Gavleborg = "G\xfc\xbe\x8d\x86\x94\xbcvleborg",
                  Vasternorrland = "V\xfc\xbe\x8d\x86\x94\xbcsternorrland",
                  Jamtland = "J\xfc\xbe\x8d\x86\x94\xbcmtland",
                  Vasterbotten = "V\xfc\xbe\x8d\x86\x94\xbcsterbotten",
                  Norrbotten = "Norrbotten")
sweden.births <- lapply(filenames, getData)
sweden.births <- do.call(rbind, sweden.births)
sweden.births$region <- factor(sweden.births$region,
                               levels = region.names,
                               labels = names(region.names))
sweden.births$age <- recode(sweden.births$age,
                            `-14` = "<15")
sweden.births <- xtabs(count ~ age + sex + region + year,
                       data = sweden.births)
sweden.births <- array(as.integer(sweden.births),
                       dim = dim(sweden.births),
                       dimnames = dimnames(sweden.births))
save(sweden.births,
     file = "data/sweden.births.rda",
     compress = "bzip2")

