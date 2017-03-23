
lad <- read.csv("data-raw/england.wales.conc/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv",
                as.is = TRUE)
lad <- lad[c("LAD14CD", "LAD14NM")]
reg <- read.csv("data-raw/england.wales.conc/LAD15_RGN15_EN_LU.csv",
                as.is = TRUE)
conc <- merge(lad, reg, by.x = "LAD14CD", by.y = "LAD15CD")
conc <- unique(conc)
england.conc <- conc[c("LAD14NM", "RGN15NM")]
names(england.conc) <- c("lad", "rgn")
load("data/england.wales.deaths.rda")
lad.wales <- setdiff(dimnames(england.wales.deaths)$region,
                     c(conc$LAD15NM,
                       "Usual residence outside England and Wales",
                       "Cornwall and Isles of Scilly",
                       "Kings Lynn and West Norfolk"))
wales.conc <- data.frame(lad = lad.wales,
                         rgn = "Wales")
england.wales.conc <- rbind(england.conc,
                            wales.conc)
england.wales.conc <- england.wales.conc[with(england.wales.conc, order(rgn, lad)),]
rownames(england.wales.conc) <- NULL
save(england.wales.conc,
     file = "data/england.wales.conc.rda",
     compress = "xz")

