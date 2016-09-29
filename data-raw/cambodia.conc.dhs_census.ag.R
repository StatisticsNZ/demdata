
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
               "Siem Reap",
               "Svay Rieng",
               "Takeo",
               "Otdar Meanchey")

dhs <- c("banteay mean chey",
         "battambang & pailin",
         "kampong cham",
         "kampong chhnang",
         "kampong speu",
         "kampong thom",
         "kampot & kep",
         "kandal",
         "preah sihanouk & kaoh kong",
         "kratie",
         "mondol kiri & rattanak kiri",
         "phnom penh",
         "preah vihear & steung treng",
         "prey veng",
         "pursat",
         "siem reap",
         "svay rieng",
         "takeo",
         "otdar mean chey")

cambodia.conc.dhs_census.ag <- data.frame(dhs, census.ag)
save(cambodia.conc.dhs_census.ag,
     file = "data/cambodia.conc.dhs_census.ag.rda")




