.DEFAULT_GOAL := and.noun.analizer.hfst

and.noun.analizer.hfst: and.noun.generator.hfst
	hfst-invert $< -o $@
and.noun.generator.hfst: and.noun.lexd
	lexd $< | hfst-txt2fst -o $@
test.pass.txt: tests.csv
	awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@
check: and.noun.generator.hfst test.pass.txt
	bash compare.sh $< test.pass.txt
clean: check
	rm test.*