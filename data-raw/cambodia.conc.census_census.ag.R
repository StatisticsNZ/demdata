
census <- c("Banteay Meanchey",
            "Battambang",
            "Kampong Cham",
            "Kampong Chhnang",
            "Kampong Speu",
            "Kampong Thom",
            "Kampot",
            "Kandal",
            "Koh Kong",
            "Kratie",
            "Mondul Kiri",
            "Phnom Penh",
            "Preah Vihear",
            "Prey Veng",
            "Pursat",
            "Ratanak Kiri",
            "Siem Reap",
            "Preah Sihanouk",
            "Stung Treng",
            "Svay Rieng",
            "Takeo",
            "Otdar Meanchey",
            "Kep",
            "Pailin")

census.ag <- c("Banteay Meanchey",
               "Battambang & Pailin",
               "Kampong Cham",
               "Kampong Chhnang",
               "Kampong Speu",
               "Kampong Thom",
               "Kampot & Kep",
               "Kandal",
               "Koh Kong & Preah Sihanouk",
               "Kratie",
               "Mondul Kiri & Ratanak Kiri",
               "Phnom Penh",
               "Preah Vihear & Stung Treng",
               "Prey Veng",
               "Pursat",
               "Mondul Kiri & Ratanak Kiri",
               "Siem Reap",
               "Koh Kong & Preah Sihanouk",
               "Preah Vihear & Stung Treng",
               "Svay Rieng",
               "Takeo",
               "Otdar Meanchey",
               "Kampot & Kep",
               "Battambang & Pailin")

cambodia.conc.census_census.ag <- data.frame(census, census.ag)
save(cambodia.conc.census_census.ag,
     file = "data/cambodia.conc.census_census.ag.rda")


               






