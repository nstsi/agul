.DEFAULT_GOAL := agx.analyser.hfst

# GENERATE analyser AND GENERATOR

agx.analyser.hfst: agx.generator.hfst
	hfst-invert $< -o $@
	
agx.generator.hfst: agx.lexd
	lexd $< | hfst-txt2fst -o $@
	
agx.lexd: $(wildcard agx.noun.lexd agx.num.lexd)
	cat $^ > agx.lexd


# GENERATE TRANSLITERATERS

cy2la.transliterator.hfst: la2cy.transliterator.hfst
	hfst-invert $< -o $@
	
la2cy.transliterator.hfst: correspondence.hfst
	hfst-repeat -f 1 $< -o $@
	
correspondence.hfst: correspondence
	hfst-strings2fst -j correspondence -o $@
	
# GENERATE analyser AND GENERATOR FOR TRANSCRIPTION

agx.analyser.tr.hfst: agx.analyser.hfst la2cy.transliterator.hfst
	hfst-invert $< -o $@
	
agx.generator.tr.hfst: agx.generator.hfst cy2la.transliterator.hfst
	hfst-compose $^ -o $@
	
# CREAT AND APPLY TESTS
test.pass.txt: tests.csv
	awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@

check: agx.generator.hfst test.pass.txt
	bash compare.sh $< test.pass.txt
	

# CLEANS FILES CREATED DURING THE CHECK
test.clean: check
	rm test.*

# REMOVE ALL HFST FILES
clean:
	rm *.hfst
