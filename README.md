# Bagvalal Morphology
## Background
[Agul](https://en.wikipedia.org/wiki/Aghul_language) (agx) is a low-resource language from the Nakh-Daghestanian family.
This repository contains a prototype for an Agul morphological analyzer. Currently it processes only nouns and numerals. 
See the [paper](https://docs.google.com/document/d/1FyPhecjvEuInXX2z2QA6gf1fButSfjwc9DN7MyOyCKs/edit?usp=sharing) for a detailed description.

You can cite the paper draft using one of the forms listed below:

* Building morphological parser for Agul in lexd and twol. A. Burakova. Bachelor thesis at the School of Linguistics, NRU HSE, 2022.
* Anastasia Burakova. “Building morphological parser for Agul in lexd and twol”. NRU HSE (2022): 16. pag.
* Буракова А. Создание морфологического парсера для агульского языка в системе lexd и twol. НИУ ВШЭ. Москва, 2022. 16 с.

This parser a part of a larger project by the students of the [School of Linguistics](https://ling.hse.ru/en/) at the NRU HSE that aims to provide digital tools for endangered languages.
Morphological parsers of other Andic languages, made by my fellow students, can be found here:

* [Bagvalal](https://github.com/ruthenian8/bagvalal)
* [Andi](https://github.com/vbunt/andi)
* [Chamalal](https://github.com/ZinaBudilova/Chamalal_parser)
* [Andi](https://github.com/vbunt/andi)

## Sources

### Grammar

The current work is based on the linguistic description of Bagvalal by T. A. Maisak et al. (2021, in preparation), M. R. Ramazanov (2014), and Agul online dictionary [AgulLang](https://agullang.ru/). The process of retrieving noun forms from the online dictionary can be found in the [get_noun_forms directory](https://github.com/nstsi/agul/tree/master/preprocessing/get_noun_forms).

### Corpus

The corpus is an Agul translation of the Gospel of Luke made in 2005 by the Institute for Bible Translation.

The text can be found at the [IBT site](https://ibtrussia.org/en/text?m=AGL&l=Luke.25&g=0), the preprocessed version can be found in the [corpus directory](https://github.com/nstsi/agul/tree/master/coverage/corpus), and the code for that preprocessing can the found in the corpus.ipynb.

## Usage

To use or extend the analyzer, pull the repository and use the makefile commands described below.

[lexd](https://github.com/apertium/lexd) and [hfst](https://github.com/hfst/hfst) are required to build the project. You can get them by adding Apertium to your apt repositories.
```bash
curl -sS https://apertium.projectjj.com/apt/install-nightly.sh | sudo bash
apt install lexd
apt install hfst
```

### Making the analyzers
cyrillic version:
```bash
make agx.analyser.hfst
```
Caucasiologist transcription version
```bash
make agx.analyser.tr.hfst
```

### Running the analyzers
View the statistics:
```bash
make check-coverage-stats
```
* cd to corpora & run make \*corpus name\*.analyzed to analyze with the cyrillic transducer
* cd to corpora & run make \*corpus name\*.tr.analyzed to analyze with the IPA transducer

### Examples:
check
```bash
make check-coverage-stats
```

Current performance: Naive Coverage ~15%
