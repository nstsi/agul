agul.num.analyzer.hfst: agul.num.generator.hfst
	hfst-invert $< -o $@

agul.num.generator.hfst: agul.num.lexd
	lexd $< | hfst-txt2fst -o $@