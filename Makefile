
## Note - this Makefile is incomplete. I will gradually bring all of data-raw
## under its control, but haven't get there yet.

vpath %.rda data

%.rda : %.R
	$<

.PHONY: all
all: sweden.deaths.rda \
     sweden.popn.rda

## sweden.deaths_sweden.popn

sweden.deaths.rda : data-raw/sweden.deaths_sweden.popn/sweden.deaths.R \
                    data-raw/sweden.deaths_sweden.popn/BE0101D9.csv \
                    data-raw/sweden.deaths_sweden.popn/BE0101D9-2.csv \
                    data-raw/sweden.deaths_sweden.popn/BE0101D9-3.csv \
                    data-raw/sweden.deaths_sweden.popn/BE0101D9-4.csv \
                    data-raw/sweden.deaths_sweden.popn/BE0101D9-5.csv
	$<
sweden.popn.rda : data-raw/sweden.deaths_sweden.popn/sweden.popn.R \
                    data-raw/sweden.deaths_sweden.popn/BE0101N1.csv \
                    data-raw/sweden.deaths_sweden.popn/BE0101N1-2.csv \
                    data-raw/sweden.deaths_sweden.popn/BE0101N1-3.csv \
                    data-raw/sweden.deaths_sweden.popn/BE0101N1-4.csv \
                    data-raw/sweden.deaths_sweden.popn/BE0101N1-5.csv
	$<






# .PHONY: clean
# clean:
# 	rm -rf output
# 	@mkdir -p output/intermediate
# 	@mkdir -p output/results
