ski.cast:
	asciinema rec $@    # record an asciinema cast

ski.anim.png: ski.cast
	agg -v --cols 80 --rows 25 --font-family 'Essential PragmataPro' --font-size 16 --theme solarized-light $< $@.gif     # to GIF
	gifsicle -V --lossy=50 -k8 -O2 -Okeep-empty $@.gif -o $@.sm.gif    # to smaller GIF, shrinks the end result a lot
	gif2apng $@.sm.gif $@     # to APNG
	#rm -f $@*.gif    # cleanup
