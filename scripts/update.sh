#!/bin/sh

until sudo $(which guix) system reconfigure $(hostname).scm --allow-downgrades; do sleep 5; done
sudo python3 scripts/copy_kernel.py
until guix upgrade; do sleep 5; done
