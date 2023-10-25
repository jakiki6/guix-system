#!/bin/sh
for i in $(find . -type f | grep .scm$); do
	cat $i | scmfmt > ${i}_
	mv ${i}_ $i
	echo Formatted $i
done
