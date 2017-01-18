
uk.tfr <- read.csv("data-raw/birthsummarytables2014final_tcm77-410981/Table 1-Table 1.csv",
                   header = FALSE,
                   col.names = c("year", "NULL", "tfr", rep("NULL", 13)),
                   colClasses = c("integer", "NULL", "numeric", rep("NULL", 13)),
                   skip = 11,
                   nrows = 77)
uk.tfr <- uk.tfr[seq(from = nrow(uk.tfr), to = 1), ]
rownames(uk.tfr) <- NULL
save(uk.tfr, file = "data/uk.tfr.rda")




          
