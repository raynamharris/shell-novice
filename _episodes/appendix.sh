# 01-intro.md


$
$ ls


# 02-filedir.md


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


# 03-pipefilter.md


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


# 04-create.md


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


# 05-coffeebreak.md




# 06-loop.md


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


# 07-script.md


$ cd ~/Desktp/shell-lesson-data/north-pacific-gyre
$ wc -l NENE01729A.txt | sort -n | head -n 1
$ bash middle.sh
$ nano middle.sh
$ bash middle.sh octane.pdb
$ bash middle.sh pentane.pdb
$ nano middle.sh
$ bash middle.sh pentane.pdb 15 5
$ bash middle.sh pentane.pdb 20 5
$ nano middle.sh
$ wc -l *.pdb | sort -n
$ nano sorted.sh
$ bash sorted.sh *.pdb ../creatures/*.dat
$ history | tail -n 5 > redo-figure-3.sh
$ cd ../../north-pacific-gyre/
$ nano do-stats.sh
$ bash do-stats.sh NENE*A.txt NENE*B.txt
$ bash do-stats.sh NENE*A.txt NENE*B.txt | wc -l


# 08-find.md


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
$ find . -name numbers.txt
$ find . -name "*.txt"
$ wc -l $(find . -name "*.txt")
$ wc -l ./writing/LittleWomen.txt ./writing/haiku.txt ./numbers.txt
$ grep "searching" $(find . -name "*.txt")


# 09-wrapup.md


$
$ ls
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
$ cd proteins
$ nano middle.sh
$ bash middle.sh
$ nano middle.sh
$ bash middle.sh octane.pdb
$ bash middle.sh pentane.pdb
$ nano middle.sh
$ bash middle.sh pentane.pdb 15 5
$ bash middle.sh pentane.pdb 20 5
$ nano middle.sh
$ wc -l *.pdb | sort -n
$ nano sorted.sh
$ bash sorted.sh *.pdb ../creatures/*.dat
$ history | tail -n 5 > redo-figure-3.sh
$ cd ../../north-pacific-gyre/
$ nano do-stats.sh
$ bash do-stats.sh NENE*A.txt NENE*B.txt
$ bash do-stats.sh NENE*A.txt NENE*B.txt | wc -l
$ head -n 5 basilisk.dat minotaur.dat unicorn.dat
$ for filename in basilisk.dat minotaur.dat unicorn.dat
$ for x in basilisk.dat minotaur.dat unicorn.dat
$ for temperature in basilisk.dat minotaur.dat unicorn.dat
$ for filename in *.dat
$ echo hello there
$ for filename in *.dat
$ cp *.dat original-*.dat
$ cp basilisk.dat minotaur.dat unicorn.dat original-*.dat
$ for filename in *.dat
$ cd north-pacific-gyre
$ for datafile in NENE*A.txt NENE*B.txt
$ for datafile in NENE*A.txt NENE*B.txt
$ for datafile in NENE*A.txt NENE*B.txt; do echo $datafile stats-$datafile; done
$ for datafile in NENE*A.txt NENE*B.txt; do bash goostats.sh $datafile stats-$datafile; done
$ for datafile in NENE*A.txt NENE*B.txt; do echo $datafile;
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
$ find . -name numbers.txt
$ find . -name "*.txt"
$ wc -l $(find . -name "*.txt")
$ wc -l ./writing/LittleWomen.txt ./writing/haiku.txt ./numbers.txt
$ grep "searching" $(find . -name "*.txt")


