and.noun.analyzer.hfst: and.noun.generator.hfst
	hfst-invert and.noun.generator.hfst -o and.noun.analyzer.hfst

and.noun.generator.hfst: and.noun.lexd
	lexd and.noun.lexd | hfst-txt2fst -o and.noun.generator.hfst