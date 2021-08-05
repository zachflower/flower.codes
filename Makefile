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
	$(JEKYLL) build --config _config.http.yml

gopher: install
	$(JEKYLL) build --config _config.gopher.yml

serve: install
	$(JEKYLL) serve --config _config.http.yml

clean:
	$(JEKYLL) clean --config _config.http.yml
	$(JEKYLL) clean --config _config.gopher.yml