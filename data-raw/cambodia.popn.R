

ages <- c(paste(seq(0, 75, 5), seq(4, 79, 5), sep = "-"), "80+")

getData <- function(name) {
    ans <- read.csv(sprintf("data-raw/Cambodia census 2008/%s.csv", name),
                    header = FALSE,
                    nrow = 551,
                    as.is = TRUE,
                    col.names = c("NULL", "age", "male", "female", rep("NULL", 5)),
                    colClasses = c("NULL", "character", "character", "character", rep("NULL", 5)))
    ans$age <- sub("years|yrs", "", ans$age)
    ans$age <- gsub(" ", "", ans$age)
    i.region <- seq(from = 1, by = 23, length.out = 24)
    region <- ans$male[i.region]
    ans <- subset(ans, subset = age %in% ages)
    ans$region <- rep(region, each = length(ages))
    ans <- reshape(ans,
                   varying = c("male", "female"),
                   v.names = "count",
                   idvar = c("region", "age"),
                   timevar = "sex",
                   times = c("Male", "Female"),
                   direction = "long")
    rownames(ans) <- NULL
    ans$sex <- factor(ans$sex, levels = c("Female", "Male"))
    ans$age <- factor(ans$age, levels = ages)
    ans$region <- factor(ans$region, levels = region)
    ans$area <- gsub("(\\w)(\\w*)", "\\U\\1\\L\\2", name, perl=TRUE)
    ans$count <- as.integer(ans$count)
    ans
}

cambodia.popn <- rbind(getData("rural"), getData("urban"))
cambodia.popn <- xtabs(count ~ region + area + age + sex,
                       data = cambodia.popn)
cambodia.popn <- array(cambodia.popn,
                       dim = dim(cambodia.popn),
                       dimnames = dimnames(cambodia.popn))

save(cambodia.popn, file = "data/cambodia.popn.rda")



