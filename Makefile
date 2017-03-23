
## Note - this Makefile is incomplete. I will gradually bring all of data-raw
## under its control, but haven't get there yet.

vpath %.rda data

.PHONY: all
all: england.wales.conc.rda \
     england.wales.deaths.rda \
     england.wales.popn.rda \
     iceland.births.rda \
     iceland.migrants.rda \
     iceland.popn.rda \
     nz.intl.migr.rda \
     sweden.births.rda \
     sweden.deaths.rda \
     sweden.popn.rda


england.wales.conc.rda : data-raw/england.wales.conc/england.wales.conc.R \
                         data-raw/england.wales.conc/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv \
                         data-raw/england.wales.conc/LAD15_RGN15_EN_LU.csv
	Rscript $<

england.wales.deaths.rda : data-raw/england.wales.deaths/england.wales.deaths.R \
                           data-raw/england.wales.deaths/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv \
                           data-raw/england.wales.deaths/deathsarea2014tcm77431322/Table-2-Table-1.csv
	Rscript $<

england.wales.popn.rda : data-raw/england.wales.popn/england.wales.popn.R \
                         data-raw/england.wales.popn/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv \
                         data-raw/england.wales.popn/MYE2_population_by_sex_and_age_for_local_authorities_UK_2014/UK-females-Table-1.csv \
                         data-raw/england.wales.popn/MYE2_population_by_sex_and_age_for_local_authorities_UK_2014/UK-males-Table-1.csv
	Rscript $<

iceland.births.rda : data-raw/iceland.births/iceland.births.R \
                     data-raw/iceland.births/MAN05101.csv
	$<

iceland.migrants.rda : data-raw/iceland.migrants/iceland.migrants.R \
                       data-raw/iceland.migrants/MAN01401-3.csv
	$<

iceland.popn.rda : data-raw/iceland.popn/iceland.popn.R \
                   data-raw/iceland.popn/MAN00101.csv
	$<

nz.intl.migr.rda : data-raw/nz.intl.migr/nz.intl.migr.R \
                   data-raw/nz.intl.migr/ITM340202_20170305_021409_89.csv
	$<

sweden.births.rda : data-raw/sweden.births/sweden.births.R \
                    data-raw/sweden.births/BE0101E2.csv \
                    data-raw/sweden.births/BE0101E2-2.csv
	$<

sweden.deaths.rda : data-raw/sweden.deaths/sweden.deaths.R \
                    data-raw/sweden.deaths/BE0101D9.csv \
                    data-raw/sweden.deaths/BE0101D9-2.csv \
                    data-raw/sweden.deaths/BE0101D9-3.csv \
                    data-raw/sweden.deaths/BE0101D9-4.csv \
                    data-raw/sweden.deaths/BE0101D9-5.csv
	$<

sweden.popn.rda : data-raw/sweden.popn/sweden.popn.R \
                  data-raw/sweden.popn/BE0101N1.csv \
                  data-raw/sweden.popn/BE0101N1-2.csv \
                  data-raw/sweden.popn/BE0101N1-3.csv \
                  data-raw/sweden.popn/BE0101N1-4.csv \
                  data-raw/sweden.popn/BE0101N1-5.csv
	$<






# .PHONY: clean
# clean:
# 	rm -rf output
# 	@mkdir -p output/intermediate
# 	@mkdir -p output/results
