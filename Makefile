.DEFAULT_GOAL := agul.analyzer.tr.hfst

# GENERATE ANALYZER AND GENERATOR

agul.analyzer.hfst: agul.generator.hfst
	hfst-invert $< -o $@
	
agul.generator.hfst: agul.lexd
	lexd $< | hfst-txt2fst -o $@
	
agul.lexd: $(wildcard agul.noun.lexd agul.num.lexd)
	cat $^ > agul.lexd


# GENERATE TRANSLITERATERS

cy2la.transliterator.hfst: la2cy.transliterator.hfst
	hfst-invert $< -o $@
	
la2cy.transliterator.hfst: correspondence.hfst
	hfst-repeat -f 1 $< -o $@
	
correspondence.hfst: correspondence
	hfst-strings2fst -j correspondence -o $@
	
# GENERATE ANALYZER AND GENERATOR FOR TRANSCRIPTION

agul.analyzer.tr.hfst: agul.generator.tr.hfst
	hfst-invert $< -o $@
	
agul.generator.tr.hfst: agul.generator.hfst cy2la.transliterator.hfst
	hfst-compose $^ -o $@
	
# CREAT AND APPLY TESTS
test.pass.txt: tests.csv
	awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@

check: agul.generator.hfst test.pass.txt
	bash compare.sh $< test.pass.txt
	

# CLEANS FILES CREATED DURING THE CHECK
test.clean: check
	rm test.*

# REMOVE ALL HFST FILES
clean:
	rm *.hfst