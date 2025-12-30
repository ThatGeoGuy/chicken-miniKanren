CHICKEN_INSTALL       := chicken-install
CHICKEN_LINT          := chicken-lint
CSI                   := csi
SALMONELLA            := salmonella
SALMONELLA_LOG        := salmonella.log
SALMONELLA_LOG_VIEWER := salmonella-log-viewer
MKFILE_PATH           := $(abspath $(lastword $(MAKEFILE_LIST)))
PWD                   := $(dir $(MKFILE_PATH))
SCHEME_FILES          := $(wildcard **/*.sld **/*.scm)

.PHONY: all clean compile lint salmonella test view print-%
all: compile lint test

clean:
	git clean -xf -- $(git rev-parse --show-toplevel)
	rm -f $(SALMONELLA_LOG)

compile:
	$(CHICKEN_INSTALL) -n

lint: compile
	$(CHICKEN_LINT) -I $(PWD) -X r7rs -R r7rs $(SCHEME_FILES)

test: compile
	$(CSI) -I $(PWD)tests/ -setup-mode -ns $(PWD)tests/run.scm

salmonella:
	$(SALMONELLA)

view:
	$(SALMONELLA_LOG_VIEWER) $(SALMONELLA_LOG)

## Debugging make-vars, call `make print-MYVAR`
print-%:
	@echo "$*=$($*)"
