.PHONY: all serve clean

all: content/panam.css content/github.svg content/affiliation.svg content/email.svg pandoc-ssg.mk
	cd content && make -f ../pandoc-ssg.mk PANDOC=$(abspath _pandoc) PANDOC_ARGS="" _build

serve:
	make -f pandoc-ssg.mk _serve

content/panam.css:
	wget -nv -O content/panam.css http://b.enjam.info/panam/styling.css

content/github.svg:
	wget -nv -O content/github.svg https://icons.getbootstrap.com/assets/icons/github.svg

content/affiliation.svg:
	wget -nv -O content/affiliation.svg https://icons.getbootstrap.com/assets/icons/building.svg

content/email.svg:
	wget -nv -O content/email.svg https://icons.getbootstrap.com/assets/icons/envelope.svg

pandoc-ssg.mk:
	wget -nv -O pandoc-ssg.mk https://raw.githubusercontent.com/ivanstojic/pandoc-ssg/master/Makefile

clean: pandoc-ssg.mk
	cd content && make -f ../pandoc-ssg.mk _clean
	$(RM) content/panam.css
	$(RM) content/*.svg
