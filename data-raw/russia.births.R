
russia.births <- read.csv("data-raw/UNdata_Export_20160304_232915853.csv",
              nrows = 410)
russia.births <- subset(russia.births, subset = Age.of.mother != "Total")
russia.births$age <- factor(russia.births$Age.of.mother,
                levels = c(12:49, "50 +", "Unknown"),
                labels = c(12:49, "50+", "Unknown"))
names(russia.births)[match("Year", names(russia.births))] <- "year"
names(russia.births)[match("Sex", names(russia.births))] <- "sex"
names(russia.births)[match("Value", names(russia.births))] <- "count"
russia.births <- subset(russia.births, select = c(age, sex, year, count))
russia.births <- russia.births[order(russia.births$year), ]

save(russia.births, file = "data/russia.births.rda")




          
