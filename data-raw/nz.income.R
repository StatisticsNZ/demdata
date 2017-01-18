
nz.income <- read.csv("data-raw/NZIS_Sub_SURF1.csv")
nz.income$age <- paste(nz.income$age_category, nz.income$age_category + 4, sep = "-")
nz.income$sex <- factor(nz.income$sex, levels = c("F", "M"), labels = c("Female", "Male"))
nz.income$id <- nz.income$random_ID
nz.income$ethnicity <- factor(nz.income$ethnicity,
                              levels = c("european/pakeha",
                                  "maori",
                                  "pacific",
                                  "non-maori combination",
                                  "maori combination",
                                  "other"),
                              labels = c("European",
                                  "Maori",
                                  "Pacific",
                                  "Non-Maori combination",
                                  "Maori combination",
                                  "Other"))
nz.income$qualification <- factor(nz.income$highest_qualification,
                                  levels = c("no qual",
                                      "school",
                                      "post-school",
                                      "vocational/trade",
                                      "bachelor or higher"),
                                  labels = c("None",
                                      "School",
                                      "Post-school",
                                      "Vocational",
                                      "University"))
nz.income$hours <- nz.income$weekly_hours
nz.income$income <- nz.income$weekly_income
nz.income <- nz.income[c("id", "age", "sex", "ethnicity", "qualification", "hours", "income")]
save(nz.income,
     file = "data/nz.income.rda",
     compress = "bzip2")
