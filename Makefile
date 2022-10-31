.PHONY: all serve mostlyclean clean

PANDOC=pandoc
PANDOC_ARGS=--data-dir="_pandoc" --no-highlight --shift-heading-level-by=1

BUILD_PAGE := $(PANDOC) $(PANDOC_ARGS) --to=html --template="default"

CONTENT_MDS := $(wildcard content/*.md)
CONTENT_OUTPUT := $(patsubst content/%.md,_output/%.html,$(CONTENT_MDS))

TALKS_DIR=talks
# Use find instead of wildcard, as wildcard can't cope with spaces in filenames
TALKS := $(shell find "$(TALKS_DIR)" -path '*/talk.md' | sed 's/ /\\ /g')

ifndef TALKS
$(error No talks found in "$(TALKS_DIR)")
endif

TALK_DATE_LINE := sed '/^date-meta/!d'
BUILD_TALK_BLURB := $(PANDOC) $(PANDOC_ARGS) --to=markdown --template="talk_blurb"
BUILD_TALK_BLURBS := for talk in $(TALKS_DIR)/*/talk.md; do { \
	$(TALK_DATE_LINE) "$$talk";\
	$(BUILD_TALK_BLURB) "$$talk";\
} | sed -z 's/\n/\v/g'; echo ""; done | sort -r | sed 's/^date-meta: [^\v]\+\v//' | sed 's/\v/\n/g'

all: $(CONTENT_OUTPUT)
	make -C asset all
	cp asset/*.svg _output
	cp asset/*.css _output

serve:
	python3 -m http.server --directory _output 8000 --bind 127.0.0.1

_output/%.html: content/%.md
	mkdir -p "_output"
	$(BUILD_PAGE) --output="$@" "$<"

_output/index.html: content/index.md $(TALKS)
	mkdir -p "_output"
	{ cat "$<"; printf "\n# Talks\n"; $(BUILD_TALK_BLURBS); } | $(BUILD_PAGE) --output="$@"

mostlyclean:
	$(RM) -r _output

clean:
	make mostlyclean
	make -C asset clean
