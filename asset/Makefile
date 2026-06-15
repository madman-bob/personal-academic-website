.PHONY: all clean

all: github.svg youtube.svg mastodon.svg email.svg

%.svg:
	wget -nv -O "$@" "https://icons.getbootstrap.com/assets/icons/$@"

email.svg:
	wget -nv -O email.svg https://icons.getbootstrap.com/assets/icons/envelope.svg

clean:
	$(RM) *.svg
