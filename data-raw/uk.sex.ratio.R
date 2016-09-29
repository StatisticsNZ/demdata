
uk.sex.ratio <- read.csv("data-raw/birthsummarytables2014final_tcm77-410981/Table 1-Table 1.csv",
                         header = FALSE,
                         col.names = c("year", rep("NULL", 6), "sex.ratio", rep("NULL", 8)),
                         colClasses = c("integer", rep("NULL", 6), "character", rep("NULL", 8)),
                         skip = 11,
                         nrows = 77)
uk.sex.ratio$sex.ratio <- sub(",", "", uk.sex.ratio$sex.ratio)
uk.sex.ratio$sex.ratio <- as.numeric(uk.sex.ratio$sex.ratio) / 10
uk.sex.ratio <- uk.sex.ratio[seq(from = nrow(uk.sex.ratio), to = 1), ]
rownames(uk.sex.ratio) <- NULL

save(uk.sex.ratio, file = "data/uk.sex.ratio.rda")




          
