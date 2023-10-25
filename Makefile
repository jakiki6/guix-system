update:
	sudo $(shell which guix) system reconfigure config.scm

deploy:
	sudo $(shell which guix) system init config.scm /mnt

test:
	$(shell guix system vm config.scm) -m 6G -smp 4 --enable-kvm

src/secrets.scm: src/secrets.scm.gpg
	gpg -d $<

.PHONY: update deploy test
