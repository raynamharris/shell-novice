---
title: "Pipes and Filters"
teaching: 10
exercises: 10
questions:
- "How can I combine existing commands to do new things?"
objectives:
- "Redirect a command's output to a file."
- "Construct command pipelines with two or more stages."
- "Explain what usually happens if a program or pipeline isn't given any input to process."
- "Explain the advantage of linking commands with pipes and filters."
keypoints:
- "`wc` counts lines, words, and characters in its inputs."
- "`cat` displays the contents of its inputs."
- "`sort` sorts its inputs."
- "`head` displays the first 10 lines of its input."
- "`tail` displays the last 10 lines of its input."
- "`command > [file]` redirects a command's output to a file (overwriting any existing content)."
- "`command >> [file]` appends a command's output to a file."
- "`[first] | [second]` is a pipeline: the output of the first command is used as the input to the second."
- "The best way to use the shell is to use pipes to combine simple single-purpose programs (filters)."
---

Now that we know a few basic commands,
we can finally look at the shell's most powerful feature:
the ease with which it lets us combine existing programs in new ways.
We'll start with the directory `shell-lesson-data/north-pacific-gyre`. 
This directory contains  17 .txt files that start with "NENE" 
and two bash scripts.



~~~
$ cd ~/Desktop/shell-lesson-data/north-pacific-gyre
$ ls 
~~~
{: .language-bash}

~~~
NENE01729A.txt	NENE01751B.txt	NENE01971Z.txt	NENE02040A.txt	NENE02043B.txt
NENE01729B.txt	NENE01812A.txt	NENE01978A.txt	NENE02040B.txt	goodiff.sh
NENE01736A.txt	NENE01843A.txt	NENE01978B.txt	NENE02040Z.txt	goostats.sh
NENE01751A.txt	NENE01843B.txt	NENE02018B.txt	NENE02043A.txt
~~~
{: .output}

Nelle wants to quickly check the quality of her data.
One way to do that is to see if the files are the right size and length.


`wc` is the 'word count' command:
it counts the number of lines, words, and characters in files (from left to right, in that order).

If we run the command `wc *.txt`, the `*` in `*.txt` matches zero or more characters,
so the shell turns `*.txt` into a list of all `.txt` files in the current directory:

~~~
$ wc *.txt
~~~
{: .language-bash}

~~~
     300     300    4406 NENE01729A.txt
     300     300    4400 NENE01729B.txt
     300     300    4371 NENE01736A.txt
     300     300    4411 NENE01751A.txt
     300     300    4409 NENE01751B.txt
     300     300    4401 NENE01812A.txt
     300     300    4395 NENE01843A.txt
     300     300    4375 NENE01843B.txt
     300     300    4372 NENE01971Z.txt
     300     300    4381 NENE01978A.txt
     300     300    4389 NENE01978B.txt
     240     240    3517 NENE02018B.txt
     300     300    4391 NENE02040A.txt
     300     300    4367 NENE02040B.txt
     300     300    4381 NENE02040Z.txt
     300     300    4386 NENE02043A.txt
     300     300    4393 NENE02043B.txt
    5040    5040   73745 total
~~~
{: .output}

Note that `wc *.txt` also shows the total number of all lines in the last line of the output.

If we run `wc -l` instead of just `wc`,
the output shows only the number of lines per file:

~~~
$ wc -l *.txt
~~~
{: .language-bash}

~~~
     300 NENE01729A.txt
     300 NENE01729B.txt
     300 NENE01736A.txt
     300 NENE01751A.txt
     300 NENE01751B.txt
     300 NENE01812A.txt
     300 NENE01843A.txt
     300 NENE01843B.txt
     300 NENE01971Z.txt
     300 NENE01978A.txt
     300 NENE01978B.txt
     240 NENE02018B.txt
     300 NENE02040A.txt
     300 NENE02040B.txt
     300 NENE02040Z.txt
     300 NENE02043A.txt
     300 NENE02043B.txt
    5040 total
~~~
{: .output}

The `-c` and `-w` options can also be used with the `wc` command, to show
only the number of characters or words in the files.


## Capturing output from commands

Which of these files contains the fewest lines?
It's an easy question to answer when there are only six files,
but what if there were 6000?
Our first step toward a solution is to run the command:

~~~
$ wc -l *.txt > lengths.txt
~~~
{: .language-bash}

The greater than symbol, `>`, tells the shell to **redirect** the command's output
to a file instead of printing it to the screen. (This is why there is no screen output:
everything that `wc` would have printed has gone into the
file `lengths.txt` instead.)  The shell will create
the file if it doesn't exist. If the file exists, it will be
silently overwritten, which may lead to data loss and thus requires
some caution.
`ls lengths.txt` confirms that the file exists:

~~~
$ ls lengths.txt
~~~
{: .language-bash}

~~~
lengths.txt
~~~
{: .output}

We can now send the content of `lengths.txt` to the screen using `cat lengths.txt`.
The `cat` command gets its name from 'concatenate' i.e. join together,
and it prints the contents of files one after another.
There's only one file in this case,
so `cat` just shows us what it contains:

~~~
$ cat lengths.txt
~~~
{: .language-bash}

~~~
     300 NENE01729A.txt
     300 NENE01729B.txt
     300 NENE01736A.txt
     300 NENE01751A.txt
     300 NENE01751B.txt
     300 NENE01812A.txt
     300 NENE01843A.txt
     300 NENE01843B.txt
     300 NENE01971Z.txt
     300 NENE01978A.txt
     300 NENE01978B.txt
     240 NENE02018B.txt
     300 NENE02040A.txt
     300 NENE02040B.txt
     300 NENE02040Z.txt
     300 NENE02043A.txt
     300 NENE02043B.txt
    5040 total
~~~
{: .output}

> ## Output Page by Page
>
> We'll continue to use `cat` in this lesson, for convenience and consistency,
> but it has the disadvantage that it always dumps the whole file onto your screen.
> More useful in practice is the command `less`,
> which you use with `less lengths.txt`.
> This displays a screenful of the file, and then stops.
> You can go forward one screenful by pressing the spacebar,
> or back one by pressing `b`.  Press `q` to quit.
{: .callout}


## Filtering output

Next we'll use the `sort` command to sort the contents of 
the `lengths.txt` file. 
We will use the `-n` option to specify that the sort is
numerical instead of alphanumerical.
This does *not* change the file;
instead, it sends the sorted result to the screen:

~~~
$ sort -n lengths.txt
~~~
{: .language-bash}

~~~
     240 NENE02018B.txt
     300 NENE01729A.txt
     300 NENE01729B.txt
     300 NENE01736A.txt
     300 NENE01751A.txt
     300 NENE01751B.txt
     300 NENE01812A.txt
     300 NENE01843A.txt
     300 NENE01843B.txt
     300 NENE01971Z.txt
     300 NENE01978A.txt
     300 NENE01978B.txt
     300 NENE02040A.txt
     300 NENE02040B.txt
     300 NENE02040Z.txt
     300 NENE02043A.txt
     300 NENE02043B.txt
    5040 total
~~~
{: .output}


Now, we can easily see that one file is shorter than the rest.

We can put the sorted list of lines in another temporary file called `sorted-lengths.txt`
by putting `> sorted-lengths.txt` after the command,
just as we used `> lengths.txt` to put the output of `wc` into `lengths.txt`.
Once we've done that,
we can run another command called `head` to get the first few lines in `sorted-lengths.txt`:

~~~
$ sort -n lengths.txt > sorted-lengths.txt
$ head -n 1 sorted-lengths.txt
~~~
{: .language-bash}

~~~
  240 NENE02018B.txt
~~~
{: .output}

This tells us which file is shorter than the rest. 

Using `-n 1` with `head` tells it that
we only want the first line of the file;
`-n 20` would get the first 20,
and so on.
Since `sorted-lengths.txt` contains the lengths of our files ordered from least to greatest,
the output of `head` must be the file with the fewest lines.

> ## Redirecting to the same file
>
> It's a very bad idea to try redirecting
> the output of a command that operates on a file
> to the same file. For example:
>
> ~~~
> $ sort -n lengths.txt > lengths.txt
> ~~~
> {: .language-bash}
>
> Doing something like this may give you
> incorrect results and/or delete
> the contents of `lengths.txt`.
{: .callout}

> ## What Does `>>` Mean?
>
> We have seen the use of `>`, but there is a similar operator `>>`
> which works slightly differently.
> We'll learn about the differences between these two operators by printing some strings.
> We can use the `echo` command to print strings e.g.
>
> ~~~
> $ echo The echo command prints text
> ~~~
> {: .language-bash}
> ~~~
> The echo command prints text
> ~~~
> {: .output}
>
> Now test the commands below to reveal the difference between the two operators:
>
> ~~~
> $ echo hello > testfile01.txt
> ~~~
> {: .language-bash}
>
> and:
>
> ~~~
> $ echo hello >> testfile02.txt
> ~~~
> {: .language-bash}
>
> Hint: Try executing each command twice in a row and then examining the output files.
>
> > ## Solution
> > In the first example with `>`, the string 'hello' is written to `testfile01.txt`,
> > but the file gets overwritten each time we run the command.
> >
> > We see from the second example that the `>>` operator also writes 'hello' to a file
> > (in this case`testfile02.txt`),
> > but appends the string to the file if it already exists
> > (i.e. when we run it for the second time).
> {: .solution}
{: .challenge}

> ## Appending Data
>
> We have already met the `head` command, which prints lines from the start of a file.
> `tail` is similar, but prints lines from the end of a file instead.
>
> Consider the file `shell-lesson-data/exercise-data/animal-counts/animals.csv`.
> After these commands, select the answer that
> corresponds to the file `animals-subset.csv`:
>
> ~~~
> $ head -n 3 animals.csv > animals-subset.csv
> $ tail -n 2 animals.csv >> animals-subset.csv
> ~~~
> {: .language-bash}
>
> 1. The first three lines of `animals.csv`
> 2. The last two lines of `animals.csv`
> 3. The first three lines and the last two lines of `animals.csv`
> 4. The second and third lines of `animals.csv`
>
> > ## Solution
> > Option 3 is correct.
> > For option 1 to be correct we would only run the `head` command.
> > For option 2 to be correct we would only run the `tail` command.
> > For option 4 to be correct we would have to pipe the output of `head` into `tail -n 2`
> >  by doing `head -n 3 animals.csv | tail -n 2 > animals-subset.csv`
> {: .solution}
{: .challenge}


## Passing output to another command
In our example of finding the file with the fewest lines,
we are using two intermediate files `lengths.txt` and `sorted-lengths.txt` to store output.
This is a confusing way to work because
even once you understand what `wc`, `sort`, and `head` do,
those intermediate files make it hard to follow what's going on.
We can make it easier to understand by running `sort` and `head` together:

~~~
$ sort -n lengths.txt | head -n 1
~~~
{: .language-bash}

~~~
  240 NENE02018B.txt
~~~
{: .output}

The vertical bar, `|`, between the two commands is called a **pipe**.
It tells the shell that we want to use
the output of the command on the left
as the input to the command on the right.

This has removed the need for the `sorted-lengths.txt` file.

## Combining multiple commands

Nothing prevents us from chaining pipes consecutively.
We can for example send the output of `wc` directly to `sort`,
and then the resulting output to `head`.
This removes the need for any intermediate files.

We'll start by using a pipe to send the output of `wc` to `sort`:

~~~
$ wc -l *.txt | sort -n
~~~
{: .language-bash}

~~~
      18 lengths.txt
      18 sorted-lengths.txt
     240 NENE02018B.txt
     300 NENE01729A.txt
     300 NENE01729B.txt
     300 NENE01736A.txt
     300 NENE01751A.txt
     300 NENE01751B.txt
     300 NENE01812A.txt
     300 NENE01843A.txt
     300 NENE01843B.txt
     300 NENE01971Z.txt
     300 NENE01978A.txt
     300 NENE01978B.txt
     300 NENE02040A.txt
     300 NENE02040B.txt
     300 NENE02040Z.txt
     300 NENE02043A.txt
     300 NENE02043B.txt
    5076 total
~~~
{: .output}

We can then send that output through another pipe, to `head`, so that the full pipeline becomes:

~~~
$ wc -l NENE*.txt | sort -n | head -n 1
~~~
{: .language-bash}

~~~
240 NENE02018B.txt

~~~
{: .output}


The redirection and pipes used in the last few commands are illustrated below:

![Redirects and Pipes of different commands: "wc -l *.pdb" will direct the
output to the shell. "wc -l *.pdb > lengths" will direct output to the file
"lengths". "wc -l *.pdb | sort -n | head -n 1" will build a pipeline where the
output of the "wc" command is the input to the "sort" command, the output of
the "sort" command is the input to the "head" command and the output of the
"head" command is directed to the shell](../fig/redirects-and-pipes.svg)

> ## Piping Commands Together
>
> In our current directory, we want to find the 3 files which have the least number of
> lines. Which command listed below would work?
>
> 1. `wc -l * > sort -n > head -n 3`
> 2. `wc -l * | sort -n | head -n 1-3`
> 3. `wc -l * | head -n 3 | sort -n`
> 4. `wc -l * | sort -n | head -n 3`
>
> > ## Solution
> > Option 4 is the solution.
> > The pipe character `|` is used to connect the output from one command to
> > the input of another.
> > `>` is used to redirect standard output to a file.
> > Try it in the `shell-lesson-data/exercise-data/proteins` directory!
> {: .solution}
{: .challenge}


## Tools designed to work together

This idea of linking programs together is why Unix has been so successful.
Instead of creating enormous programs that try to do many different things,
Unix programmers focus on creating lots of simple tools that each do one job well,
and that work well with each other.
This programming model is called 'pipes and filters'.
We've already seen pipes;
a **filter** is a program like `wc` or `sort`
that transforms a stream of input into a stream of output.
Almost all of the standard Unix tools can work this way:
unless told to do otherwise,
they read from standard input,
do something with what they've read,
and write to standard output.

The key is that any program that reads lines of text from standard input
and writes lines of text to standard output
can be combined with every other program that behaves this way as well.
You can *and should* write your programs this way
so that you and other people can put those programs into pipes to multiply their power.


## Checking for unusual file names


Did you notice that most but not all files are names A or B but two are named Z?


~~~
$ ls *Z.txt
~~~
{: .language-bash}

~~~
NENE01971Z.txt    NENE02040Z.txt
~~~
{: .output}

Sure enough,
when Nelle checks the log on her laptop,
there's no depth recorded for either of those samples.
Since it's too late to get the information any other way,
she must exclude those two files from her analysis.
She could delete them using `rm`,
but there are actually some analyses she might do later where 
depth doesn't matter,
so instead, she'll have to be careful later on to select files 
using the wildcard expressions `NENE*A.txt NENE*B.txt`.

~~~
$ ls NENE*[AB].txt
~~~
{: .language-bash}

~~~
NENE01729A.txt	NENE01751B.txt	NENE01978A.txt	NENE02040B.txt
NENE01729B.txt	NENE01812A.txt	NENE01978B.txt	NENE02043A.txt
NENE01736A.txt	NENE01843A.txt	NENE02018B.txt	NENE02043B.txt
NENE01751A.txt	NENE01843B.txt	NENE02040A.txt
~~~
{: .output}



{% include links.md %}
