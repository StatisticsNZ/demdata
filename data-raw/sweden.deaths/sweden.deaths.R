
library(methods)
library(tidyr)
library(plyr)

getData <- function(filename) {
    file <- file.path("data-raw/sweden.deaths", filename)
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
filenames <- c("BE0101D9.csv",
               "BE0101D9-2.csv",
               "BE0101D9-3.csv",
               "BE0101D9-4.csv",
               "BE0101D9-5.csv")
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
sweden.deaths <- lapply(filenames, getData)
sweden.deaths <- do.call(rbind, sweden.deaths)
sweden.deaths$region <- factor(sweden.deaths$region,
                               levels = region.names,
                               labels = names(region.names))
sweden.deaths <- xtabs(count ~ age + sex + region + year,
                       data = sweden.deaths)
sweden.deaths <- array(as.integer(sweden.deaths),
                       dim = dim(sweden.deaths),
                       dimnames = dimnames(sweden.deaths))
save(sweden.deaths,
     file = "data/sweden.deaths.rda",
     compress = "bzip2")
