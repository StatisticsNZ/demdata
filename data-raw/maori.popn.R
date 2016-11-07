
levels.age <- c(0:89, "90+")
popn <- read.csv("data-raw/Estimated resident population (ERP) 24 Oct 2016/TABLECODE7511_Data_2d0e7c00-6498-4ee5-bb48-28ea5497e7ca.csv")
popn$age <- as.character(popn$Age)
popn$age <- sub(" Years and over", "+", popn$age)
popn$age <- sub(" Years", "", popn$age)
popn$age <- factor(popn$age,
                   levels = levels.age)
popn$sex <- factor(popn$Sex,
                   levels = c("Female", "Male"))
popn$year <- popn$Year.at.30.June
popn$count <- popn$Value
popn <- popn[c("age", "sex", "year", "count")]
popn <- xtabs(count ~ age + sex + year,
              data = popn)
maori.popn <- array(as.integer(popn),
                    dim = dim(popn),
                    dimnames = dimnames(popn))
save(maori.popn,
     file = "data/maori.popn.rda")
