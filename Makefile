SHELL := /bin/bash
BUNDLE := bundle
JEKYLL := $(BUNDLE) exec jekyll

PROJECT_DEPS := Gemfile

.PHONY: all clean install update

all: http gopher

install: $(PROJECT_DEPS)
	$(BUNDLE) install

update: $(PROJECT_DEPS)
	$(BUNDLE) update

http: install
	JEKYLL_ENV=production $(JEKYLL) build --verbose --config _config.http.yml

gopher: install
	JEKYLL_ENV=production $(JEKYLL) build --verbose --config _config.gopher.yml

serve: install
	JEKYLL_ENV=development $(JEKYLL) serve --config _config.http.yml --future --drafts

degrade:
	./bin/degrade.sh

clean:
	$(JEKYLL) clean --config _config.http.yml
	$(JEKYLL) clean --config _config.gopher.yml