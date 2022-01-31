.DEFAULT_GOAL := and.analizer.hfst

# generate analizer and generator
and.analizer.hfst: and.generator.hfst
	hfst-invert $< -o $@
and.generator.hfst: and.morphotactics.hfst and.twol.hfst
	hfst-compose-intersect $^ -o $@
and.morphotactics.hfst: and.lexd.hfst and.morphotactics.twol.hfst
	hfst-invert $< | hfst-compose-intersect - and.morphotactics.twol.hfst | hfst-invert -o $@
and.lexd.hfst: and.lexd
	lexd $< | hfst-txt2fst -o $@
and.twol.hfst: and.twol
	hfst-twolc $< -o $@
and.morphotactics.twol.hfst: and.morphotactics.twol
	hfst-twolc $< -o $@

# generate transliteraters
cy2la.transliterater.hfst: la2cy.transliterater.hfst
	hfst-invert $< -o $@
la2cy.transliterater.hfst: correspondence.hfst
	hfst-repeat -f 1 $< -o $@
correspondence.hfst: correspondence
	hfst-strings2fst -j correspondence -o $@

# generate analizer and generator for transcription
and.analizer.tr.hfst: and.generator.tr.hfst
	hfst-invert $< -o $@
and.generator.tr.hfst: and.generator.hfst cy2la.transliterater.hfst
	hfst-compose $^ -o $@

# creat and apply tests
test.pass.txt: tests.csv
	awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@
check: and.generator.hfst test.pass.txt
	bash compare.sh $< test.pass.txt

# cleans files created during the check
test.clean: check
	rm test.*

# remove all hfst files
clean:
	rm *.hfst