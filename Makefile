SHELL := /bin/bash
BUNDLE := bundle
JEKYLL := $(BUNDLE) exec jekyll

PROJECT_DEPS := Gemfile

.PHONY: all clean install update

all: build

install: $(PROJECT_DEPS)
	$(BUNDLE) install

update: $(PROJECT_DEPS)
	$(BUNDLE) update

build: install
	JEKYLL_ENV=production $(JEKYLL) build --verbose

serve: install
	JEKYLL_ENV=development $(JEKYLL) serve --future --drafts

degrade:
	./bin/degrade.sh

clean:
	$(JEKYLL) clean