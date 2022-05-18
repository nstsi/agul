# .DEFAULT_GOAL := agul.analyzer.tr.hfst
.DEFAULT_GOAL := clean_some

# GENERATE ANALYZER AND GENERATOR
agul.analyzer.hfst: agul.generator.hfst
	hfst-invert $< -o $@
	
agul.generator.hfst: agul.lexd
	lexd $< | hfst-txt2fst -o $@
	
agul.lexd: $(wildcard agul.noun.lexd agul.num.lexd)
	cat $^ > agul.lexd

# GENERATE TRANSLITERATERS
cy2la.transliterater.hfst: la2cy.transliterater.hfst
	hfst-invert $< -o $@
	
la2cy.transliterater.hfst: correspondence.hfst
	hfst-repeat -f 1 $< -o $@
	
correspondence.hfst: correspondence
	hfst-strings2fst -j correspondence -o $@
	
# GENERATE ANALYZER AND GENERATOR FOR TRANSCRIPTION
agul.analyzer.tr.hfst: agul.generator.tr.hfst
	hfst-invert $< -o $@
	
agul.generator.tr.hfst: agul.generator.hfst cy2la.transliterater.hfst
	hfst-compose $^ -o $@
