
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


nz.popn.ta.9601 <- read.csv("data-raw/Estimated resident population (ERP)/TABLECODE7512_Data_c5ff0a06-3e0f-42ec-b093-096af5b7aa96.csv")
nz.popn.ta.9601$region <- as.character(nz.popn.ta.9601$Area)
nz.popn.ta.9601$region <- removeAdminCrud(nz.popn.ta.9601$region)
nz.popn.ta.9601$region <- factor(nz.popn.ta.9601$region,
                                 levels = unique(nz.popn.ta.9601$region))
nz.popn.ta.9601$age <- as.character(nz.popn.ta.9601$Age)
nz.popn.ta.9601$age <- removeAgeCrud(nz.popn.ta.9601$age)
nz.popn.ta.9601$age <- factor(nz.popn.ta.9601$age,
                              levels = unique(nz.popn.ta.9601$age))
names(nz.popn.ta.9601)[match("Year.at.30.June", names(nz.popn.ta.9601))] <- "year"
names(nz.popn.ta.9601)[match("Value", names(nz.popn.ta.9601))] <- "value"
nz.popn.ta.9601$sex <- as.character(nz.popn.ta.9601$Sex)
nz.popn.ta.9601$sex <- factor(nz.popn.ta.9601$sex,
                              levels = c("Female", "Male"))
nz.popn.ta.9601 <- nz.popn.ta.9601[c("region", "age", "sex", "year", "value")]

nz.popn.ta.0615 <- read.csv("data-raw/Subnational population estimates (TA/TABLECODE7502_Data_d98929f5-a253-452a-96fc-b10ff045a63a.csv")
nz.popn.ta.0615$region <- as.character(nz.popn.ta.0615$Area)
nz.popn.ta.0615$region <- removeAdminCrud(nz.popn.ta.0615$region)
nz.popn.ta.0615$region <- factor(nz.popn.ta.0615$region,
                                 levels = unique(nz.popn.ta.0615$region))
nz.popn.ta.0615$age <- as.character(nz.popn.ta.0615$Age)
nz.popn.ta.0615$age <- removeAgeCrud(nz.popn.ta.0615$age)
nz.popn.ta.0615$age <- factor(nz.popn.ta.0615$age,
                              levels = unique(nz.popn.ta.0615$age))
names(nz.popn.ta.0615)[match("Year.at.30.June", names(nz.popn.ta.0615))] <- "year"
names(nz.popn.ta.0615)[match("Value", names(nz.popn.ta.0615))] <- "value"
nz.popn.ta.0615$sex <- as.character(nz.popn.ta.0615$Sex)
nz.popn.ta.0615$sex <- factor(nz.popn.ta.0615$sex,
                              levels = c("Female", "Male"))
nz.popn.ta.0615 <- nz.popn.ta.0615[c("region", "age", "sex", "year", "value")]

nz.popn.ta <- rbind(nz.popn.ta.9601, nz.popn.ta.0615)
nz.popn.ta <- split(x = nz.popn.ta, f = nz.popn.ta[c("region", "age", "sex")])
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
nz.popn.ta <- lapply(nz.popn.ta, splineInterpolate)
nz.popn.ta <- do.call(rbind, nz.popn.ta)
nz.popn.ta <- xtabs(value ~ region + age + sex + year,
                    data = nz.popn.ta)
nz.popn.ta[nz.popn.ta < 0] <- 0
nz.popn.ta <- array(as.integer(nz.popn.ta),
                    dim = dim(nz.popn.ta),
                    dimnames = dimnames(nz.popn.ta))
save(nz.popn.ta,
     file = "data/nz.popn.ta.rda",
     compress = "xz")
