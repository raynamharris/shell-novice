#!/bin/bash

rm appendix.sh
touch appendix.sh
for file in 0*md
do
	echo "# $file"  >> appendix.sh
	echo "\n" >> appendix.sh
	grep  '^\$' $file >> appendix.sh
	echo "\n" >> appendix.sh
done
cat appendix.sh
