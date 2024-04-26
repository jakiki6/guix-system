unexport LIVE_IMAGE

update: src/secrets.scm
	./scripts/update.sh

deploy: src/secrets.scm
	sudo $(shell which guix) system init os.scm /mnt

test: src/secrets.scm
	$(shell guix system vm os.scm) -m 6G -smp 4 --enable-kvm

format:
	@./scripts/format.sh

gc:
	guix gc
	sudo guix system delete-generations
	sudo python3 scripts/copy_kernel.py

src/secrets.scm: src/secrets.scm.gpg
	gpg -d $< > $@

.PHONY: update deploy test gc
