


conc <- read.csv("data-raw/ONS_Deaths/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv",
                 as.is = TRUE)
conc <- conc[c("LAD14CD", "LAD14NM")]
conc <- unique(conc)
conc <- subset(conc,
               subset = substr(conc$LAD14CD, 1, 1) %in% c("E", "W"))
rownames(conc) <- NULL

females <- read.csv("data-raw/ONS_Deaths/MYE2_population_by_sex_and_age_for_local_authorities_UK_2014/UK females-Table 1.csv",
                    skip = 2,
                    as.is = TRUE)
males <- read.csv("data-raw/ONS_Deaths/MYE2_population_by_sex_and_age_for_local_authorities_UK_2014/UK males-Table 1.csv",
                  skip = 2,
                  as.is = TRUE)
females <- merge(females, conc, by.x = "CODE", by.y = "LAD14CD")
males <- merge(males, conc, by.x = "CODE", by.y = "LAD14CD")
females <- reshape(females,
                   varying = list(paste0("X", 0:90)),
                   v.names = "count",
                   idvar = "LAD14NM",
                   timevar = "age",
                   times = c(0:89, "90+"),
                   direction = "long",
                   drop = c("CODE", "NAME", "ALL.AGES"))
males <- reshape(males,
                 varying = list(paste0("X", 0:90)),
                 v.names = "count",
                 idvar = "LAD14NM",
                 timevar = "age",
                 times = c(0:89, "90+"),
                 direction = "long",
                 drop = c("CODE", "NAME", "ALL.AGES"))
names(females)[match("LAD14NM", names(females))] <- "lad"
names(males)[match("LAD14NM", names(males))] <- "lad"
females$sex <- "Female"
males$sex <- "Male"
popn <- rbind(females, males)
rownames(popn) <- NULL
popn$count <- sub(",", "", popn$count)
popn$count <- as.integer(popn$count)
popn$lad <- factor(popn$lad,
                   levels = unique(popn$lad))
england.wales.popn <- xtabs(count ~ age + sex + lad,
                            data = popn)
stopifnot(identical(sum(england.wales.popn), 57408654L))

save(england.wales.popn,
     file = "data/england.wales.popn.rda",
     compress = "xz")

                            

