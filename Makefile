HOMEPAGE=https://github.com/justincampbell/q-queue
PREFIX=/usr/local

VERSION=0.2.2
TAG=v$(VERSION)

ARCHIVE=q-queue-$(TAG).tar.gz
ARCHIVE_URL=$(HOMEPAGE)/archive/$(TAG).tar.gz
FILES=`find bin/*`

export PATH := bin:$(PATH)

test:
	bats test

release: tag sha

tag:
	git tag --force latest
	git tag | grep $(TAG) || git tag --message "Release $(TAG)" --sign $(TAG)
	git push origin
	git push origin --force --tags

pkg/$(ARCHIVE): pkg/
	wget --output-document pkg/$(ARCHIVE) $(ARCHIVE_URL)

pkg/:
	mkdir pkg

sha: pkg/$(ARCHIVE)
	shasum pkg/$(ARCHIVE)

install:
	mkdir -p $(PREFIX)/bin
	for file in $(FILES); do cp -v $$file $(PREFIX)/$$file; done

uninstall:
	for file in $(FILES); do rm -vf $(PREFIX)/$$file; done

.PHONY: test release tag sha install uninstall
