.ONESHELL:
.DELETE_ON_ERROR:
export SHELL     := bash
export SHELLOPTS := pipefail:errexit
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rule

# Adapted from https://www.thapaliya.com/en/writings/well-documented-makefiles/
.PHONY: help
help: ## Display this help.
help:
	@awk 'BEGIN {FS = ": ##"; printf "Usage:\n  make <target>\n\nTargets:\n"} /^[a-zA-Z0-9_\.\-\/%]+: ##/ { printf "  %-45s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

.PHONY: precheck
precheck:
ifneq ($(filter oneshell,$(.FEATURES)),)
@:
else
$(error This Makefile requires GNU Make version 4 or higher)
endif

GO_FILES := $(wildcard *.go)

xinput_exporter: ## Build the exporter binary.
xinput_exporter: go.mod go.sum $(GO_FILES)
	go build ./
