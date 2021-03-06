
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


eth <- read.csv("data-raw/ethnic_group/TABLECODE8023_Data.csv")
eth <- subset(eth, Area != "Total, New Zealand by territorial authority/area unit")
eth$region <- sub(" Region", "", eth$Area)
eth <- reshape(eth,
               varying = list(c("total", "european", "maori", "pacific", "asian")),
               v.names = "Value",
               timevar = "Ethnic.group",
               idvar = "region",
               direction = "wide",
               drop = c("Area", "Maori.descent.indicator", "Sex", "Year", "Flags"))
eth <- within(eth, {
    pr.asian <- asian / total
    pr.european <- european / total
    pr.maori <- maori / total
    pr.pacific <- pacific / total
    rm(total, european, maori, pacific, asian)
})
  
inc <- read.csv("data-raw/Total income/TABLECODE8112_Data.csv")
inc <- subset(inc, Area != "Total, New Zealand by territorial authority/area unit")
inc$region <- sub(" Region", "", inc$Area)
inc <- reshape(inc,
               varying = list(c("incall", "inc5", "inc10", "inc20", "inc30", "inc50", "incplus", "incstated")),
               v.names = "Value",
               idvar = "region",
               timevar = "Grouped.total.personal.income",
               direction = "wide",
               drop = c("Area", "Ethnic.group", "Sex", "Flags"))
inc$pr.inc.50 <- with(inc, (inc50 + incplus) / incstated)
inc <- inc[c("region", "pr.inc.50")]

nz.census.reg <- merge(eth, inc, by = "region")
nz.census.reg <- nz.census.reg[match(kLevelsRegion, nz.census.reg$region), ]

save(nz.census.reg,
     file = "data/nz.census.reg.rda",
     compress = "xz")
