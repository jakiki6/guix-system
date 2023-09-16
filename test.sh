#!/bin/sh

$(guix system vm config.scm) -m 6G -smp 4 --enable-kvm
