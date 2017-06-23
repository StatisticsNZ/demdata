
library(methods)
library(tidyr)
library(plyr)

getData <- function(filename) {
    file <- file.path("data-raw/sweden.popn", filename)
    d <- read.csv(file = file,
                  skip = 2)
    d <- gather_(d,
                 key_col = "year",
                 value_col = "count",
                 gather_cols = paste0("X", 1968:2015))
    mutate(d,
           region = sub("^(.+) (.+)( county)$", "\\2", region),
           age = factor(sub(" years$| year$", "", age),
                        levels = c(0:99, "100+")),
           sex = factor(sex,
                        levels = c("women", "men"),
                        labels = c("Females", "Males")),
           year = as.integer(sub("X", "", year)))
}
filenames <- c("BE0101N1.csv",
               "BE0101N1-2.csv",
               "BE0101N1-3.csv",
               "BE0101N1-4.csv",
               "BE0101N1-5.csv")
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
sweden.popn <- lapply(filenames, getData)
sweden.popn <- do.call(rbind, sweden.popn)
sweden.popn$region <- factor(sweden.popn$region,
                             levels = region.names,
                             labels = names(region.names))
sweden.popn <- xtabs(count ~ age + sex + region + year,
                     data = sweden.popn)
sweden.popn <- array(as.integer(sweden.popn),
                     dim = dim(sweden.popn),
                     dimnames = dimnames(sweden.popn))
save(sweden.popn,
     file = "data/sweden.popn.rda",
     compress = "bzip2")
