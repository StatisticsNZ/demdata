
kLevelsRegion <- c("Northland",
                   "Auckland",
                   "Waikato",
                   "Bay of Plenty",
                   "Gisborne",
                   "Hawke's Bay",
                   "Taranaki",
                   "Manawatu-Wanganui",
                   "Wellington",
                   "Tasman",
                   "Nelson",
                   "Marlborough",
                   "West Coast",
                   "Canterbury",
                   "Otago",
                   "Southland")
kLevelsAge <- c(paste(seq(0, 80, 5), seq(4, 84, 5), sep = "-"), "85+")
nz.popn.reg <- read.csv("data-raw/TABLECODE7501_Data_bf10992e-f561-462a-be4f-a76fc9ee2eff.csv",
                        colClasses = c("character", "character", "character",
                            "character", "character", "NULL"),
                        col.names = c("region", "age", "sex", "year", "value", "NULL"))
nz.popn.reg <- subset(nz.popn.reg, region != "Area outside region")
nz.popn.reg$region <- sub(" region$", "", nz.popn.reg$region)
nz.popn.reg$region <- factor(nz.popn.reg$region, levels = kLevelsRegion)
nz.popn.reg$age <- sub(" Years and over", "+", nz.popn.reg$age)
nz.popn.reg$age <- sub(" Years", "", nz.popn.reg$age)
nz.popn.reg$age <- factor(nz.popn.reg$age, levels = kLevelsAge)
nz.popn.reg$value <- as.integer(nz.popn.reg$value)
nz.popn.reg <- xtabs(value ~ age + sex + region + year,
                     data = nz.popn.reg)
nz.popn.reg <- array(as.integer(nz.popn.reg),
                     dim = dim(nz.popn.reg),
                     dimnames = dimnames(nz.popn.reg))
save(nz.popn.reg,
     file = "data/nz.popn.reg.rda",
     compress = "bzip2")
