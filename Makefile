update:
	sudo $(shell which guix) system reconfigure os.scm

deploy:
	sudo $(shell which guix) system init os.scm /mnt

test:
	$(shell guix system vm os.scm) -m 6G -smp 4 --enable-kvm

image:
	guix system image --image-type=iso9660 os.scm

format:
	@./scripts/format.sh

src/secrets.scm: src/secrets.scm.gpg
	gpg -d $<

.PHONY: update deploy test
