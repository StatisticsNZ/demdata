
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
nz.departures <- read.csv("data-raw/ITM340204_20160720_090723_71.csv",
                          skip = 2,
                          nrow = 2400)
region.levels <- unique(as.character(nz.departures[[2]]))
region.levels <- region.levels[region.levels != " "]
nz.departures$region <- rep(region.levels, each = 16)
nz.departures$age <- as.character(nz.departures$X..2)
nz.departures$age <- removeAgeCrud(nz.departures$age)
nz.departures$age <- factor(nz.departures$age,
                            levels = age.levels)
nz.departures$sex <- rep(c("Female", "Male"),
                       each = length(region.levels) * length(unique(nz.departures$age)))
nz.departures <- reshape(nz.departures,
                       varying = list(paste0("X", 1991:2015)),
                       v.names = "value",
                       idvar = c("region", "age", "sex"),
                       timevar = "year",
                       times = 1991:2015,
                       direction = "long",
                       drop = c("X.", "X..1", "X..2"))
rownames(nz.departures) <- NULL
in.akl <- grepl(" \\(to 10\\.2010\\)", nz.departures$region)
is.akl <- grepl(" \\(from 11\\.2010\\)", nz.departures$region)
akl <- nz.departures[in.akl | is.akl, ]
akl <- aggregate(akl["value"],
                 by = akl[c("age", "sex", "year")],
                 FUN = sum)
akl$region <- "Auckland"
nz.departures <- nz.departures[!in.akl & !is.akl, ]
nz.departures <- rbind(nz.departures, akl)
region.levels <- unique(as.character(nz.departures$region))
region.levels <- c(region.levels[1:3],
                   region.levels[length(region.levels)],
                   region.levels[-c(1:3, length(region.levels))])
region.levels.short <- removeAdminCrud(region.levels)
nz.departures$region <- factor(nz.departures$region,
                               levels = region.levels,
                               labels = region.levels.short)
nz.departures <- xtabs(value ~ region + age + sex + year,
                       data = nz.departures)
nz.departures <- array(as.integer(nz.departures),
                       dim = dim(nz.departures),
                       dimnames = dimnames(nz.departures))
save(nz.departures,
     file = "data/nz.departures.rda",
     compress = "xz")
