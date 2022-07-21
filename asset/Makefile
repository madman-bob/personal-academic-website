.PHONY: all clean

all: panam.css github.svg affiliation.svg email.svg

panam.css:
	wget -nv -O panam.css http://b.enjam.info/panam/styling.css

github.svg:
	wget -nv -O github.svg https://icons.getbootstrap.com/assets/icons/github.svg

affiliation.svg:
	wget -nv -O affiliation.svg https://icons.getbootstrap.com/assets/icons/building.svg

email.svg:
	wget -nv -O email.svg https://icons.getbootstrap.com/assets/icons/envelope.svg

clean:
	$(RM) panam.css
	$(RM) *.svg
