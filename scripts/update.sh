#!/bin/sh

until sudo $(which guix) system reconfigure os.scm --allow-downgrades; do true; done
sudo python3 scripts/copy_kernel.py
until guix upgrade; do true; done
