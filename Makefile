
## Note - this Makefile is incomplete. I will gradually bring all of data-raw
## under its control, but haven't get there yet.

.PHONY: all
all: data/england.wales.conc.rda \
     data/england.wales.deaths.rda \
     data/england.wales.popn.rda \
     data/iceland.births.rda \
     data/iceland.migrants.rda \
     data/iceland.popn.rda \
     data/nz.popn.reg.rda \
     data/nz.births.reg.rda \
     data/nz.deaths.reg.rda \
     data/nz.injuries.rda \
     data/nz.int.mig.reg.rda \
     data/nz.ext.mig.reg.rda \
     data/nz.intl.migr.rda \
     data/nz.school.rda \
     data/russia.births.rda \
     data/sim.popn.true.rda \
     data/sim.admin.nat.rda \
     data/sim.admin.school.rda \
     data/sim.admin.health.rda \
     data/sim.admin.survey.rda \
     data/sweden.births.rda \
     data/sweden.deaths.rda \
     data/sweden.popn.rda \
     data/waikato.tfr.rda


data/england.wales.conc.rda : data-raw/england.wales.conc/england.wales.conc.R \
                              data-raw/england.wales.conc/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv \
                              data-raw/england.wales.conc/LAD15_RGN15_EN_LU.csv
	Rscript $<

data/england.wales.deaths.rda : data-raw/england.wales.deaths/england.wales.deaths.R \
                                data-raw/england.wales.deaths/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv \
                                data-raw/england.wales.deaths/deathsarea2014tcm77431322/Table-2-Table-1.csv
	Rscript $<

data/england.wales.popn.rda : data-raw/england.wales.popn/england.wales.popn.R \
                              data-raw/england.wales.popn/Ward_to_Local_Authority_District_December_2014_Lookup_in_the_United_Kingdom.csv \
                              data-raw/england.wales.popn/MYE2_population_by_sex_and_age_for_local_authorities_UK_2014/UK-females-Table-1.csv \
                              data-raw/england.wales.popn/MYE2_population_by_sex_and_age_for_local_authorities_UK_2014/UK-males-Table-1.csv
	Rscript $<

data/iceland.births.rda : data-raw/iceland.births/iceland.births.R \
                          data-raw/iceland.births/MAN05101.csv
	Rscript $<

data/iceland.migrants.rda : data-raw/iceland.migrants/iceland.migrants.R \
                            data-raw/iceland.migrants/MAN01401-3.csv
	Rscript $<

data/iceland.popn.rda : data-raw/iceland.popn/iceland.popn.R \
                        data-raw/iceland.popn/MAN00101.csv
	Rscript $<

data/nz.popn.reg.rda : data-raw/nz.popn.reg/nz.popn.reg.R \
                       data-raw/nz.popn.reg/rc13_pop9616_rnd.csv
	Rscript $<

data/nz.births.reg.rda : data-raw/nz.births.reg/nz.births.reg.R \
                         data-raw/nz.births.reg/rc13_bths9716_rr3.csv
	Rscript $<

data/nz.deaths.reg.rda : data-raw/nz.deaths.reg/nz.deaths.reg.R \
                         data-raw/nz.deaths.reg/rc13_dths9716_rr3.csv
	Rscript $<

data/nz.injuries.rda : data-raw/nz.injuries/nz.injuries.R \
                       data-raw/nz.injuries/Count_of_fatal_and_series_non-fatal_injuries_by_sex/TABLECODE7935_Data_32d81df2-590c-443e-bc4e-7030037f2be2.csv
	Rscript $<

data/nz.int.mig.reg.rda : data-raw/nz.int.mig.reg/nz.int.mig.reg.R \
                          data-raw/nz.int.mig.reg/migr_transitions_rc13_9613_rr3.zip
	Rscript $<

data/nz.ext.mig.reg.rda : data-raw/nz.ext.mig.reg/nz.ext.mig.reg.R \
                          data-raw/nz.ext.mig.reg/rc13_pltmig_9716.zip
	Rscript $<

data/nz.intl.migr.rda : data-raw/nz.intl.migr/nz.intl.migr.R \
                        data-raw/nz.intl.migr/ITM340202_20170305_021409_89.csv
	$<

data/nz.school.rda : data-raw/nz.school/nz.school.R \
                     data-raw/nz.school/Age-and-Region-2016.xls
	Rscript $<

data/russia.births.rda : data-raw/russia.births/russia.births.R \
                         data-raw/russia.births/UNdata_Export_20160304_232915853.csv
	Rscript $<

data/sim.popn.true.rda : data-raw/sim.popn.true.R \
                         data/nz.popn.ta.rda
	Rscript $<

data/sim.admin.nat.rda : data-raw/sim.admin.nat.R \
                         data/sim.popn.true.rda
	Rscript $<

data/sim.admin.school.rda : data-raw/sim.admin.school.R \
                            data/sim.popn.true.rda
	Rscript $<

data/sim.admin.health.rda : data-raw/sim.admin.health.R \
                            data/sim.popn.true.rda
	Rscript $<

data/sim.admin.survey.rda : data-raw/sim.admin.survey.R \
                            data/sim.popn.true.rda
	Rscript $<

data/sweden.births.rda : data-raw/sweden.births/sweden.births.R \
                         data-raw/sweden.births/BE0101E2.csv \
                         data-raw/sweden.births/BE0101E2-2.csv
	Rscript $<

data/sweden.deaths.rda : data-raw/sweden.deaths/sweden.deaths.R \
                         data-raw/sweden.deaths/BE0101D9.csv \
                         data-raw/sweden.deaths/BE0101D9-2.csv \
                         data-raw/sweden.deaths/BE0101D9-3.csv \
                         data-raw/sweden.deaths/BE0101D9-4.csv \
                         data-raw/sweden.deaths/BE0101D9-5.csv
	Rscript $<

data/sweden.popn.rda : data-raw/sweden.popn/sweden.popn.R \
                       data-raw/sweden.popn/BE0101N1.csv \
                       data-raw/sweden.popn/BE0101N1-2.csv \
                       data-raw/sweden.popn/BE0101N1-3.csv \
                       data-raw/sweden.popn/BE0101N1-4.csv \
                       data-raw/sweden.popn/BE0101N1-5.csv
	Rscript $<

data/waikato.tfr.rda : data-raw/waikato.tfr.R \
                       data/nz.births.reg.rda \
                       data/nz.popn.reg.rda
	Rscript $<






# .PHONY: clean
# clean:
# 	rm -rf output
# 	@mkdir -p output/intermediate
# 	@mkdir -p output/results
