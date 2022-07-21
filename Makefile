.PHONY: all serve mostlyclean clean

PANDOC=pandoc
PANDOC_ARGS=--no-highlight --shift-heading-level-by=1

CONTENT_MDS := $(wildcard content/*.md)
CONTENT_OUTPUT := $(patsubst content/%.md,_output/%.html,$(CONTENT_MDS))

all: $(CONTENT_OUTPUT)
	make -C asset all
	cp asset/*.svg _output
	cp asset/*.css _output

serve:
	python3 -m http.server --directory _output 8000 --bind 127.0.0.1

_output/%.html: content/%.md
	mkdir -p "_output"
	$(PANDOC) $(PANDOC_ARGS) --data-dir="_pandoc" --to=html --template="default" --output="$@" "$<"

mostlyclean:
	$(RM) -r _output

clean:
	make mostlyclean
	make -C asset clean
