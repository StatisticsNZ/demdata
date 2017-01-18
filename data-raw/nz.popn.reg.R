
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



removeAdminCrud <- function(x) {
    x <- sub("^Area outside territorial authority$", "Area Outside TA", x)
    x <- sub(" district$", "", x)
    x <- sub(" city$", "", x)
    x <- sub(" territory$", "", x)
    x
}

removeAgeCrud <- function(x) {
    x <- sub(" years and over$", "+", x)
    x <- sub(" years$", "", x)
    x <- sub(" Years and over$", "+", x)
    x <- sub(" Years$", "", x)
    x
}

nz.popn.reg.9613 <- read.csv("data-raw/Estimated resident population (ERP) 25 Sep 2016/TABLECODE7512_Data_838872e3-0507-441f-8e5e-9a45a0821ce2.csv")
nz.popn.reg.9613$region <- as.character(nz.popn.reg.9613$Area)
nz.popn.reg.9613$region <- sub(" region", "", nz.popn.reg.9613$region)
nz.popn.reg.9613$region <- factor(nz.popn.reg.9613$region,
                                  levels = unique(nz.popn.reg.9613$region))
nz.popn.reg.9613$age <- as.character(nz.popn.reg.9613$Age)
nz.popn.reg.9613$age <- removeAgeCrud(nz.popn.reg.9613$age)
nz.popn.reg.9613$age <- factor(nz.popn.reg.9613$age,
                              levels = unique(nz.popn.reg.9613$age))
names(nz.popn.reg.9613)[match("Year.at.30.June", names(nz.popn.reg.9613))] <- "year"
names(nz.popn.reg.9613)[match("Value", names(nz.popn.reg.9613))] <- "value"
nz.popn.reg.9613$sex <- as.character(nz.popn.reg.9613$Sex)
nz.popn.reg.9613$sex <- factor(nz.popn.reg.9613$sex,
                              levels = c("Female", "Male"))
nz.popn.reg.9613 <- nz.popn.reg.9613[c("region", "age", "sex", "year", "value")]
nz.popn.reg.9601 <- subset(nz.popn.reg.9613, year <= 2001)


nz.popn.reg.0615 <- read.csv("data-raw/Subnational population estimates (RC-2/TABLECODE7501_Data_713f9378-1f8d-4c69-9380-7b472bcb5870.csv")
nz.popn.reg.0615$region <- as.character(nz.popn.reg.0615$Area)
nz.popn.reg.0615$region <- sub(" region", "", nz.popn.reg.0615$region)
nz.popn.reg.0615$region <- factor(nz.popn.reg.0615$region,
                                  levels = unique(nz.popn.reg.0615$region))
nz.popn.reg.0615$age <- as.character(nz.popn.reg.0615$Age)
nz.popn.reg.0615$age <- removeAgeCrud(nz.popn.reg.0615$age)
nz.popn.reg.0615$age <- factor(nz.popn.reg.0615$age,
                              levels = unique(nz.popn.reg.0615$age))
names(nz.popn.reg.0615)[match("Year.at.30.June", names(nz.popn.reg.0615))] <- "year"
names(nz.popn.reg.0615)[match("Value", names(nz.popn.reg.0615))] <- "value"
nz.popn.reg.0615$sex <- as.character(nz.popn.reg.0615$Sex)
nz.popn.reg.0615$sex <- factor(nz.popn.reg.0615$sex,
                              levels = c("Female", "Male"))
nz.popn.reg.0615 <- nz.popn.reg.0615[c("region", "age", "sex", "year", "value")]

nz.popn.reg <- rbind(nz.popn.reg.9601, nz.popn.reg.0615)
nz.popn.reg <- split(x = nz.popn.reg, f = nz.popn.reg[c("region", "age", "sex")])
splineInterpolate <- function(obj) {
    fun <- splinefun(x = obj$year, y = obj$value)
    year <- 1996:2015
    value <- fun(x = year)
    value <- round(value, -1)
    data.frame(region = obj$region[1],
               age = obj$age[1],
               sex = obj$sex[1],
               year = year,
               value = value)
}
nz.popn.reg <- lapply(nz.popn.reg, splineInterpolate)
nz.popn.reg <- do.call(rbind, nz.popn.reg)
nz.popn.reg <- xtabs(value ~ region + age + sex + year,
                    data = nz.popn.reg)
nz.popn.reg[nz.popn.reg < 0] <- 0
nz.popn.reg <- array(as.integer(nz.popn.reg),
                    dim = dim(nz.popn.reg),
                    dimnames = dimnames(nz.popn.reg))
save(nz.popn.reg,
     file = "data/nz.popn.reg.rda",
     compress = "xz")
