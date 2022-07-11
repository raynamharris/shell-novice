---
title: "Finding Things"
teaching: 15
exercises: 5
questions:
- "How can I find files?"
- "How can I find things in files?"
objectives:
- "Use `grep` to select lines from text files that match simple patterns."
- "Use `find` to find files and directories whose names match simple patterns."
- "Use the output of one command as the command-line argument(s) to another command."
- "Explain what is meant by 'text' and 'binary' files, and why many common tools don't handle the latter well."
keypoints:
- "`find` finds files with specific properties that match patterns."
- "`grep` selects lines in files that match patterns."
- "`--help` is an option supported by many bash commands, and programs that can be run from within Bash, to display more information on how to use these commands or programs."
- "`man [command]` displays the manual page for a given command."
- "`$([command])` inserts a command's output in place."
---

In the same way that many of us now use 'Google' as a
verb meaning 'to find', Unix programmers often use the
word 'grep'.
'grep' is a contraction of 'global/regular expression/print',
a common sequence of operations in early Unix text editors.
It is also the name of a very useful command-line program.

`grep` finds and prints lines within files that match a pattern. 
`find` finds files whose name matches a particular pattern. 


For this example, let's explore the scripts in Neele's north pacific 
gyre directory

~~~
$ cd
$ cd ~/Desktop/shell-lesson-data/north-pacific-gyre
$ ls *.sh
~~~
{: .language-bash}

~~~
goodiff.sh	goostats.sh
~~~
{: .output}


We can quickly view both script with `cat`.

~~~
cat *,sh
~~~
{: .language-bash}



~~~
$ # check for the right number of input arguments
if [ $# -ne 2 ]
  then
    echo "goodiff file1 file2"
    echo "call goodiff with two arguments"
    exit 1
fi


# difference of two input files
# demo version, just return a random number or "files are identical"
if [ "$1" == "$2" ]
then
    echo "files are identical"
else
    echo 0.$RANDOM
fi
# check for the right number of input arguments
if [ $# -ne 2 ]
  then
    echo "goostats file1 file2"
    echo "call goostats with two arguments"
    exit 1
fi

sleep 2
head -n 3 $1 | cut -d , -f 1 | sort | uniq > $2

~~~
{: .output}


Cat is useful when looking at small files, but when working with large files, sometimes you want to focus on specific parts.

Many scripts have echo statements that print useful messages to the screen. Let's use grep to print just the echo statements to the screen. 

~~~
$ grep "echo" *sh
~~~
{: .language-bash}

~~~
goodiff.sh:    echo "goodiff file1 file2"
goodiff.sh:    echo "call goodiff with two arguments"
goodiff.sh:    echo "files are identical"
goodiff.sh:    echo 0.$RANDOM
goostats.sh:    echo "goostats file1 file2"
goostats.sh:    echo "call goostats with two arguments"
~~~
{: .output}

We see four echo statements in goodiff.sh and two in goostats.sh. Notice that one echo statment has "random" and the other has "RANDOM". By default grep match the case, but we can use the option `-i` to ignore case.

~~~
$ grep -i "random" *.sh
~~~
{: .language-bash}

~~~
goodiff.sh:# demo version, just return a random number or "files are identical"
goodiff.sh:    echo 0.$RANDOM
~~~
{: .output}

When search for patterns, grep by default will match words that have more
character that specified by the pattern. For instance, the pattern "file" 
is in  "files" and "file1". 

~~~
$ grep "file" *sh
~~~
{: .language-bash}

~~~
goodiff.sh:    echo "goodiff file1 file2"
goodiff.sh:# difference of two input files
goodiff.sh:# demo version, just return a random number or "files are identical"
goodiff.sh:    echo "files are identical"
goostats.sh:    echo "goostats file1 file2"
~~~
{: .output}

You can add the option `-w` to match the pattern as a word exactly. Because "file" doesn't occur in either script, this will return nothing.

~~~
$ grep -w "file" *sh
~~~
{: .language-bash}

~~~

~~~
{: .output}



We've now seen that you don't have to have quotes around single words,
but it is useful to use quotes when searching for multiple words.
It also helps to make it easier to distinguish between the search term or phrase
and the file being searched.
We will use quotes in the remaining examples.

Another useful option is `-n`, which will print the line number
were the pattern was found:

~~~
$ grep -n "file" *.sh
~~~
{: .language-bash}

~~~
goodiff.sh:4:    echo "goodiff file1 file2"
goodiff.sh:10:# difference of two input files
goodiff.sh:11:# demo version, just return a random number or "files are identical"
goodiff.sh:14:    echo "files are identical"
goostats.sh:4:    echo "goostats file1 file2"
~~~
{: .output}

Here, we can see that lines 5, 9, and 10 contain the letters 'it'.

We can combine options (i.e. flags) as we do with other Unix commands.
For example, let's find the lines that contain the word 'the'.

It is often useful to print the lines before or after the line with 
the matching pattern by adding the options  `-B 1` and `-A 1`. 

~~~
$ grep -B 1 -A 1 "echo" *sh
~~~
{: .language-bash}

~~~
goodiff.sh-3-  then
goodiff.sh:4:    echo "goodiff file1 file2"
goodiff.sh:5:    echo "call goodiff with two arguments"
goodiff.sh-6-    exit 1
--
--
goodiff.sh-13-then
goodiff.sh:14:    echo "files are identical"
goodiff.sh-15-else
--
--
goodiff.sh-15-else
goodiff.sh:16:    echo 0.$RANDOM
goodiff.sh-17-fi
--
--
goostats.sh-3-  then
goostats.sh:4:    echo "goostats file1 file2"
goostats.sh:5:    echo "call goostats with two arguments"
goostats.sh-6-    exit 1
~~~
{: .output}




`grep` has lots of other options. To find out what they are, we can type:

~~~
$ grep --help
~~~
{: .language-bash}

~~~
Usage: grep [OPTION]... PATTERN [FILE]...
Search for PATTERN in each FILE or standard input.
PATTERN is, by default, a basic regular expression (BRE).
Example: grep -i 'hello world' menu.h main.c

Regexp selection and interpretation:
  -E, --extended-regexp     PATTERN is an extended regular expression (ERE)
  -F, --fixed-strings       PATTERN is a set of newline-separated fixed strings
  -G, --basic-regexp        PATTERN is a basic regular expression (BRE)
  -P, --perl-regexp         PATTERN is a Perl regular expression
  -e, --regexp=PATTERN      use PATTERN for matching
  -f, --file=FILE           obtain PATTERN from FILE
  -i, --ignore-case         ignore case distinctions
  -w, --word-regexp         force PATTERN to match only whole words
  -x, --line-regexp         force PATTERN to match only whole lines
  -z, --null-data           a data line ends in 0 byte, not newline

Miscellaneous:
...        ...        ...
~~~
{: .output}

> ## Using `grep`
>
> Which command would result in the following output:
>
> ~~~
> and the presence of absence:
> ~~~
> {: .output}
>
> 1. `grep "of" haiku.txt`
> 2. `grep -E "of" haiku.txt`
> 3. `grep -w "of" haiku.txt`
> 4. `grep -i "of" haiku.txt`
>
> > ## Solution
> > The correct answer is 3, because the `-w` option looks only for whole-word matches.
> > The other options will also match 'of' when part of another word.
> {: .solution}
{: .challenge}

> ## Wildcards
>
> `grep`'s real power doesn't come from its options, though; it comes from
> the fact that patterns can include wildcards. (The technical name for
> these is **regular expressions**, which
> is what the 're' in 'grep' stands for.) Regular expressions are both complex
> and powerful; if you want to do complex searches, please look at the lesson
> on [our website](http://v4.software-carpentry.org/regexp/index.html). As a taster, we can
> find lines that have an 'o' in the second position like this:
>
> ~~~
> $ grep -E "^.o" haiku.txt
> ~~~
> {: .language-bash}
>
> ~~~
> You bring fresh toner.
> Today it is not working
> Software is like that.
> ~~~
> {: .output}
>
> We use the `-E` option and put the pattern in quotes to prevent the shell
> from trying to interpret it. (If the pattern contained a `*`, for
> example, the shell would try to expand it before running `grep`.) The
> `^` in the pattern anchors the match to the start of the line. The `.`
> matches a single character (just like `?` in the shell), while the `o`
> matches an actual 'o'.
{: .callout}

> ## Tracking a Species
>
> Leah has several hundred
> data files saved in one directory, each of which is formatted like this:
>
> ~~~
> 2012-11-05,deer,5
> 2012-11-05,rabbit,22
> 2012-11-05,raccoon,7
> 2012-11-06,rabbit,19
> 2012-11-06,deer,2
> 2012-11-06,fox,4
> 2012-11-07,rabbit,16
> 2012-11-07,bear,1
> ~~~
> {: .source}
>
> She wants to write a shell script that takes a species as the first command-line argument
> and a directory as the second argument. The script should return one file called `<species>.txt`
> containing a list of dates and the number of that species seen on each date.
> For example using the data shown above, `rabbit.txt` would contain:
>
> ~~~
> 2012-11-05,22
> 2012-11-06,19
> 2012-11-07,16
> ~~~
> {: .source}
>
> Below, each line contains an individual command, or pipe.  Arrange their
> sequence in one command in order to achieve Leah's goal:
>
> ~~~
> cut -d : -f 2
> >
> |
> grep -w $1 -r $2
> |
> $1.txt
> cut -d , -f 1,3
> ~~~
> {: .language-bash}
>
> Hint: use `man grep` to look for how to grep text recursively in a directory
> and `man cut` to select more than one field in a line.
>
> An example of such a file is provided in
> `shell-lesson-data/exercise-data/animal-counts/animals.csv`
>
> > ## Solution
> >
> > ```
> > grep -w $1 -r $2 | cut -d : -f 2 | cut -d , -f 1,3 > $1.txt
> > ```
> > {: .source}
> >
> > Actually, you can swap the order of the two cut commands and it still works. At the
> > command line, try changing the order of the cut commands, and have a look at the output
> > from each step to see why this is the case.
> >
> > You would call the script above like this:
> >
> > ```
> > $ bash count-species.sh bear .
> > ```
> > {: .language-bash}
> {: .solution}
{: .challenge}

> ## Little Women
>
> You and your friend, having just finished reading *Little Women* by
> Louisa May Alcott, are in an argument.  Of the four sisters in the
> book, Jo, Meg, Beth, and Amy, your friend thinks that Jo was the
> most mentioned.  You, however, are certain it was Amy.  Luckily, you
> have a file `LittleWomen.txt` containing the full text of the novel
> (`shell-lesson-data/exercise-data/writing/LittleWomen.txt`).
> Using a `for` loop, how would you tabulate the number of times each
> of the four sisters is mentioned?
>
> Hint: one solution might employ
> the commands `grep` and `wc` and a `|`, while another might utilize
> `grep` options.
> There is often more than one way to solve a programming task, so a
> particular solution is usually chosen based on a combination of
> yielding the correct result, elegance, readability, and speed.
>
> > ## Solutions
> > ```
> > for sis in Jo Meg Beth Amy
> > do
> >     echo $sis:
> >     grep -ow $sis LittleWomen.txt | wc -l
> > done
> > ```
> > {: .source}
> >
> > Alternative, slightly inferior solution:
> > ```
> > for sis in Jo Meg Beth Amy
> > do
> >     echo $sis:
> >     grep -ocw $sis LittleWomen.txt
> > done
> > ```
> > {: .source}
> >
> > This solution is inferior because `grep -c` only reports the number of lines matched.
> > The total number of matches reported by this method will be lower if there is more
> > than one match per line.
> >
> > Perceptive observers may have noticed that character names sometimes appear in all-uppercase
> > in chapter titles (e.g. 'MEG GOES TO VANITY FAIR').
> > If you wanted to count these as well, you could add the `-i` option for case-insensitivity
> > (though in this case, it doesn't affect the answer to which sister is mentioned
> > most frequently).
> {: .solution}
{: .challenge}

While `grep` finds lines in files,
the `find` command finds files themselves.
Again,
it has a lot of options;
to show how the simplest ones work, we'll use the `shell-lesson-data/exercise-data`
directory tree shown below.

~~~
.
├── animal-counts/
│   └── animals.csv
├── creatures/
│   ├── basilisk.dat
│   ├── minotaur.dat
│   └── unicorn.dat
├── numbers.txt
├── proteins/
│   ├── cubane.pdb
│   ├── ethane.pdb
│   ├── methane.pdb
│   ├── octane.pdb
│   ├── pentane.pdb
│   └── propane.pdb
└── writing/
    ├── haiku.txt
    └── LittleWomen.txt
~~~
{: .output}

The `exercise-data` directory contains one file, `numbers.txt` and four directories:
`animal-counts`, `creatures`, `proteins` and `writing` containing various files.


For our first command,
let's run `find .` (remember to run this command from the `shell-lesson-data/exercise-data` folder).

~~~
$ find .
~~~
{: .language-bash}

~~~
.
./writing
./writing/LittleWomen.txt
./writing/haiku.txt
./creatures
./creatures/basilisk.dat
./creatures/unicorn.dat
./creatures/minotaur.dat
./animal-counts
./animal-counts/animals.csv
./numbers.txt
./proteins
./proteins/ethane.pdb
./proteins/propane.pdb
./proteins/octane.pdb
./proteins/pentane.pdb
./proteins/methane.pdb
./proteins/cubane.pdb
~~~
{: .output}


As always, the `.` on its own means the current working directory,
which is where we want our search to start.
`find`'s output is the names of every file **and** directory
under the current working directory.
This can seem useless at first but `find` has many options
to filter the output and in this lesson we will discover some
of them.

The first option in our list is
`-type d` that means 'things that are directories'.
Sure enough, `find`'s output is the names of the five directories (including `.`):

~~~
$ find . -type d
~~~
{: .language-bash}

~~~
.
./writing
./creatures
./animal-counts
./proteins
~~~
{: .output}

Notice that the objects `find` finds are not listed in any particular order.
If we change `-type d` to `-type f`,
we get a listing of all the files instead:

~~~
$ find . -type f
~~~
{: .language-bash}

~~~
./writing/LittleWomen.txt
./writing/haiku.txt
./creatures/basilisk.dat
./creatures/unicorn.dat
./creatures/minotaur.dat
./animal-counts/animals.csv
./numbers.txt
./proteins/ethane.pdb
./proteins/propane.pdb
./proteins/octane.pdb
./proteins/pentane.pdb
./proteins/methane.pdb
./proteins/cubane.pdb
~~~
{: .output}

Now let's try matching by name:

~~~
$ find . -name *.txt
~~~
{: .language-bash}

~~~
./numbers.txt
~~~
{: .output}

We expected it to find all the text files,
but it only prints out `./numbers.txt`.
The problem is that the shell expands wildcard characters like `*` *before* commands run.
Since `*.txt` in the current directory expands to `./numbers.txt`,
the command we actually ran was:

~~~
$ find . -name numbers.txt
~~~
{: .language-bash}

`find` did what we asked; we just asked for the wrong thing.

To get what we want,
let's do what we did with `grep`:
put `*.txt` in quotes to prevent the shell from expanding the `*` wildcard.
This way,
`find` actually gets the pattern `*.txt`, not the expanded filename `numbers.txt`:

~~~
$ find . -name "*.txt"
~~~
{: .language-bash}

~~~
./writing/LittleWomen.txt
./writing/haiku.txt
./numbers.txt
~~~
{: .output}

> ## Listing vs. Finding
>
> `ls` and `find` can be made to do similar things given the right options,
> but under normal circumstances,
> `ls` lists everything it can,
> while `find` searches for things with certain properties and shows them.
{: .callout}

As we said earlier,
the command line's power lies in combining tools.
We've seen how to do that with pipes;
let's look at another technique.
As we just saw,
`find . -name "*.txt"` gives us a list of all text files in or below the current directory.
How can we combine that with `wc -l` to count the lines in all those files?

The simplest way is to put the `find` command inside `$()`:

~~~
$ wc -l $(find . -name "*.txt")
~~~
{: .language-bash}

~~~
  21022 ./writing/LittleWomen.txt
     11 ./writing/haiku.txt
      5 ./numbers.txt
  21038 total
~~~
{: .output}

When the shell executes this command,
the first thing it does is run whatever is inside the `$()`.
It then replaces the `$()` expression with that command's output.
Since the output of `find` is the three filenames `./writing/LittleWomen.txt`,
`./writing/haiku.txt`, and `./numbers.txt`, the shell constructs the command:

~~~
$ wc -l ./writing/LittleWomen.txt ./writing/haiku.txt ./numbers.txt
~~~
{: .language-bash}

which is what we wanted.
This expansion is exactly what the shell does when it expands wildcards like `*` and `?`,
but lets us use any command we want as our own 'wildcard'.

It's very common to use `find` and `grep` together.
The first finds files that match a pattern;
the second looks for lines inside those files that match another pattern.
Here, for example, we can find txt files that contain the word "searching"
by looking for the string 'searching' in all the `.txt` files in the current directory:

~~~
$ grep "searching" $(find . -name "*.txt")
~~~
{: .language-bash}

~~~
./writing/LittleWomen.txt:sitting on the top step, affected to be searching for her book, but was
./writing/haiku.txt:With searching comes loss
~~~
{: .output}

> ## Matching and Subtracting
>
> The `-v` option to `grep` inverts pattern matching, so that only lines
> which do *not* match the pattern are printed. Given that, which of
> the following commands will find all .dat files in `creatures`
> except `unicorn.dat`?
> Once you have thought about your answer, you can test the commands in the
> `shell-lesson-data/exercise-data` directory.
>
> 1.  `find creatures -name "*.dat" | grep -v unicorn`
> 2.  `find creatures -name *.dat | grep -v unicorn`
> 3.  `grep -v "unicorn" $(find creatures -name "*.dat")`
> 4.  None of the above.
>
> > ## Solution
> > Option 1. is correct. Putting the match expression in quotes prevents the shell
> > expanding it, so it gets passed to the `find` command.
> >
> > Option 2 is also works in this instance because the shell tries to expand `*.dat`
> > but there are no `*.dat` files in the current directory,
> > so the wildcard expression gets passed to `find`.
> > We encounter this in
> > [episode 6]({{ page.root }}{% link _episodes/06-create.md %}/#wildcards).
> >
> > Option 3 is incorrect because it searches the contents of the files for lines which
> > do not match 'unicorn', rather than searching the file names.
> {: .solution}
{: .challenge}

> ## Binary Files
>
> We have focused exclusively on finding patterns in text files. What if
> your data is stored as images, in databases, or in some other format?
>
> A handful of tools extend `grep` to handle a few non text formats. But a
> more generalizable approach is to convert the data to text, or
> extract the text-like elements from the data. On the one hand, it makes simple
> things easy to do. On the other hand, complex things are usually impossible. For
> example, it's easy enough to write a program that will extract X and Y
> dimensions from image files for `grep` to play with, but how would you
> write something to find values in a spreadsheet whose cells contained
> formulas?
>
> A last option is to recognize that the shell and text processing have
> their limits, and to use another programming language.
> When the time comes to do this, don't be too hard on the shell: many
> modern programming languages have borrowed a lot of
> ideas from it, and imitation is also the sincerest form of praise.
{: .callout}

The Unix shell is older than most of the people who use it. It has
survived so long because it is one of the most productive programming
environments ever created --- maybe even *the* most productive. Its syntax
may be cryptic, but people who have mastered it can experiment with
different commands interactively, then use what they have learned to
automate their work. Graphical user interfaces may be easier to use at
first, but once learned, the productivity in the shell is unbeatable.
And as Alfred North Whitehead wrote in 1911, 'Civilization advances by
extending the number of important operations which we can perform
without thinking about them.'

> ## `find` Pipeline Reading Comprehension
> 
> Write a short explanatory comment for the following shell script:
>
> ~~~
> wc -l $(find . -name "*.dat") | sort -n
> ~~~
> {: .language-bash}
>
> > ## Solution
> > 1. Find all files with a `.dat` extension recursively from the current directory
> > 2. Count the number of lines each of these files contains
> > 3. Sort the output from step 2. numerically
> {: .solution}
{: .challenge}


{% include links.md %}
