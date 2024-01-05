#!/bin/sh
for i in $(find . -type f | grep .scm$ | grep -v kernel); do
	cat $i | ./scripts/scmfmt > ${i}_
    cp ${i}_ /tmp/
	mv ${i}_ $i
	echo Formatted $i
done
