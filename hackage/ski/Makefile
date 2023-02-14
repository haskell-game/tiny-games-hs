ski.cast:
	asciinema rec $@

ski.gif: ski.cast
	agg -v --cols 80 --rows 25 --font-family 'Essential PragmataPro' --font-size 16 --theme solarized-light $< $@
	mv $@ $@.big.gif && gifsicle -V --lossy=50 -k8 -O2 -Okeep-empty $@.big.gif -o $@ && rm -f $@.big.gif
