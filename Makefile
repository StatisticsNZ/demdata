
## Note - this Makefile is incomplete. I will gradually bring all of data-raw
## under its control, but haven't get there yet.

vpath %.rda data

.PHONY: all
all: iceland.migrants.rda \
     iceland.popn.rda \
     sweden.deaths.rda \
     sweden.popn.rda


iceland.migrants.rda : data-raw/iceland.migrants/iceland.migrants.R \
                       data-raw/iceland.migrants/MAN01401-3.csv
	$<

iceland.popn.rda : data-raw/iceland.popn/iceland.popn.R \
                   data-raw/iceland.popn/MAN00101.csv
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
