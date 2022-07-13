---
title: "Wrap Up"
teaching: 5
exercises: 0
questions:
- " "
objectives:
- "See a history of what you learned today"
keypoints:
- "Use history to see all the commands you typed recently"
---

## Appendix

Here is a summary of all the commands we typed today:


```
# Introduction


$ ls


# Navigating directories


$ pwd
$ ls
$ ls -F /
$ ls -F /
$ ls -F
$ ls --help
$ man ls
$ ls -F Desktop
$ ls -F Desktop/shell-lesson-data
$ cd Desktop
$ cd shell-lesson-data
$ cd north-pacific-gyre/
$ pwd
$ ls -F
$ cd shell-lesson-data
$ cd ..
$ pwd
$ ls -F -a
$ cd
$ pwd
$ cd Desktop/shell-lesson-data/north-pacific-gyre
$ pwd
$ cd /Users/nelle/Desktop/shell-lesson-data
$ ls north-pacific-gyre/
$ ls nor
$ ls north-pacific-gyre/
$ ls north-pacific-gyre/goo
$ ls -s north-pacific-gyre
$ ls -S north-pacific-gyre


# Pipes and filters


$ cd ~/Desktop/shell-lesson-data/north-pacific-gyre
$ ls 
$ wc *.txt
$ wc -l *.txt
$ wc -l *.txt > lengths.txt
$ ls lengths.txt
$ cat lengths.txt
$ sort -n lengths.txt
$ sort -n lengths.txt > sorted-lengths.txt
$ head -n 1 sorted-lengths.txt
$ sort -n lengths.txt | head -n 1
$ wc -l *.txt | sort -n
$ wc -l NENE*.txt | sort -n | head -n 1
$ ls *Z.txt
$ ls NENE*[AB].txt


# Working with files and directories


$ pwd
$ cd ~/Desktop/shell-lesson-data/north-pacific-gyre
$ ls 
$ mkdir results
$ ls -F
$ ls -F results
$ mkdir -p results/lengths/2022-07/
$ nano sorted-lengths.txt
$ mv lengths.txt results
$ mv sorted-lengths.txt results
$ ls results
$ mkdir raw-data
$ cp NENE*txt raw-data
$ ls raw-data
$ rm NENE02040Z.txt
$ ls NENE02040Z.txt
$ rm results
$ rm -r results


# Break

# Loops


$ wc -l NENE*[AB].txt | sort -n   | head -n 1
$ sort -n  NENE*.txt | head -n 1
$ for file in NENE*[AB].txt
$ for file in NENE*[AB].txt
$ for x in NENE*txt
$ for file in NENE*[AB].txt
$ echo hello there
$ cp *.txt raw-*.txt
$ for file in NENE*.txt
$ for file in NENE*.txt
$ cd north-pacific-gyre
$ for datafile in NENE*A.txt NENE*B.txt
$ for datafile in NENE*A.txt NENE*B.txt
$ for datafile in NENE*A.txt NENE*B.txt; do echo $datafile stats-$datafile; done
$ for datafile in NENE*A.txt NENE*B.txt; do bash goostats.sh $datafile stats-$datafile; done
$ for datafile in NENE*A.txt NENE*B.txt; do echo $datafile;


# Scripts


$ cd ~/Desktp/shell-lesson-data/north-pacific-gyre
$ wc -l NENE01729A.txt | sort -n | head -n 1
$ nano do-stats.sh
$ bash do-stats.sh NENE*A.txt NENE*B.txt
$ bash do-stats.sh NENE*A.txt NENE*B.txt | wc -l


# Finding things


$ cd
$ cd ~/Desktop/shell-lesson-data/north-pacific-gyre
$ ls *.sh
$ # check for the right number of input arguments
$ grep "echo" *sh
$ grep -i "random" *.sh
$ grep "file" *sh
$ grep -w "file" *sh
$ grep -n "file" *.sh
$ grep -B 1 -A 1 "echo" *sh
$ grep --help
$ find .
$ find . -type d
$ find . -type f
$ find . -name *.txt
$ find . -name "*.txt"
$ wc -l $(find . -name "*.txt")
$ grep "searching" $(find . -name "*.txt")

```
{: .language-bash}


## History

To view all the commands you typed recently, use the command `history`. 

```
history
```
{: .language-bash}


## Surveys

Please complete this survey on Friday

[Post-workshop Survey](https://carpentries.typeform.com/to/UgVdRQ?slug=2022-07-13-upr-online)


{% include links.md %}
