
removeAdminCrud <- function(x) {
    x <- sub("^Area outside territorial authority$", "Area Outside TA", x)
    x <- sub(" district$", "", x)
    x <- sub(" city$", "", x)
    x <- sub(" territory$", "", x)
    x <- sub(" District$", "", x)
    x <- sub(" City$", "", x)
    x <- sub(" Territory$", "", x)
    x <- sub("Not applicable/not stated", "Not stated", x)
    x
}

removeAgeCrud <- function(x) {
    x <- sub(" years and over$", "+", x)
    x <- sub(" years$", "", x)
    x
}


age.levels <- c(paste(seq(0, 70, 5), seq(4, 74, 5), sep = "-"), "75+")
nz.arrivals <- read.csv("data-raw/ITM340204_20160720_084759_51.csv",
                        skip = 2,
                        nrow = 2400)
region.levels <- unique(as.character(nz.arrivals[[2]]))
region.levels <- region.levels[region.levels != " "]
nz.arrivals$region <- rep(region.levels, each = 16)
nz.arrivals$age <- as.character(nz.arrivals$X..2)
nz.arrivals$age <- removeAgeCrud(nz.arrivals$age)
nz.arrivals$age <- factor(nz.arrivals$age,
                          levels = age.levels)
nz.arrivals$sex <- rep(c("Female", "Male"),
                       each = length(region.levels) * length(unique(nz.arrivals$age)))
nz.arrivals <- reshape(nz.arrivals,
                       varying = list(paste0("X", 1991:2015)),
                       v.names = "value",
                       idvar = c("region", "age", "sex"),
                       timevar = "year",
                       times = 1991:2015,
                       direction = "long",
                       drop = c("X.", "X..1", "X..2"))
rownames(nz.arrivals) <- NULL
in.akl <- grepl(" \\(to 10\\.2010\\)", nz.arrivals$region)
is.akl <- grepl(" \\(from 11\\.2010\\)", nz.arrivals$region)
akl <- nz.arrivals[in.akl | is.akl, ]
akl <- aggregate(akl["value"],
                 by = akl[c("age", "sex", "year")],
                 FUN = sum)
akl$region <- "Auckland"
nz.arrivals <- nz.arrivals[!in.akl & !is.akl, ]
nz.arrivals <- rbind(nz.arrivals, akl)
region.levels <- unique(as.character(nz.arrivals$region))
region.levels <- c(region.levels[1:3],
                   region.levels[length(region.levels)],
                   region.levels[-c(1:3, length(region.levels))])
region.levels.short <- removeAdminCrud(region.levels)
nz.arrivals$region <- factor(nz.arrivals$region,
                               levels = region.levels,
                               labels = region.levels.short)
nz.arrivals <- xtabs(value ~ region + age + sex + year,
                       data = nz.arrivals)
nz.arrivals <- array(as.integer(nz.arrivals),
                       dim = dim(nz.arrivals),
                       dimnames = dimnames(nz.arrivals))
save(nz.arrivals,
     file = "data/nz.arrivals.rda",
     compress = "xz")




