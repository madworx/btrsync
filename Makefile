SHELL := /bin/bash

BINARY_NAME ?= bin/btrsync

GO ?= go
build:
	CGO_ENABLED=0 $(GO) build \
		-ldflags "-s -w -X main.version=$(shell git describe --tags --always --dirty)" \
		-o $(BINARY_NAME) \
		cmd/btrsync/main.go

build-tip:
	$(MAKE) build GO="gotip"

install: build
	install -Dm755 $(BINARY_NAME) "$(shell go env GOPATH)/$(BINARY_NAME)"

install-tip: build-tip
	install -Dm755 $(BINARY_NAME) "$(shell gotip env GOPATH)/$(BINARY_NAME)"

generate:
	GO111MODULE=off go get golang.org/x/tools/cmd/stringer
	go generate ./...