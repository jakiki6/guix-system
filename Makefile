unexport LIVE_IMAGE

update: src/secrets.scm
	sudo $(shell which guix) system reconfigure os.scm
	sudo python3 scripts/copy_boot.py

deploy: src/secrets.scm
	sudo $(shell which guix) system init os.scm /mnt

test: src/secrets.scm
	$(shell guix system vm os.scm) -m 6G -smp 4 --enable-kvm

format:
	@./scripts/format.sh

src/secrets.scm: src/secrets.scm.gpg
	gpg -d $< > $@

.PHONY: update deploy test
