
VADeaths2 <- array(datasets::VADeaths,
                   dim = c(5, 2, 2),
                   dimnames = list(age = c("50-54", "55-59", "60-64", "65-69", "70-74"),
                       sex = c("Male", "Female"),
                       residence = c("Rural", "Urban")))
save(VADeaths2, file = "data/VADeaths2.rda")
