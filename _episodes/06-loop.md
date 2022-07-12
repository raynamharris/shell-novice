---
title: "Loops"
teaching: 10
exercises: 10
questions:
- "How can I perform the same actions on many different files?"
objectives:
- "Write a loop that applies one or more commands separately to each file in a set of files."
- "Trace the values taken on by a loop variable during execution of the loop."
- "Explain the difference between a variable's name and its value."
- "Explain why spaces and some punctuation characters shouldn't be used in file names."
- "Demonstrate how to see what commands have recently been executed."
- "Re-run recently executed commands without retyping them."
keypoints:
- "A `for` loop repeats commands once for every thing in a list."
- "Every `for` loop needs a variable to refer to the thing it is currently operating on."
- "Use `$name` to expand a variable (i.e., get its value). `${name}` can also be used."
- "Do not use spaces, quotes, or wildcard characters such as '*' or '?' in filenames, as it complicates variable expansion."
- "Give files consistent names that are easy to match with wildcard patterns to make it easy to select them for looping."
- "Use the up-arrow key to scroll up through previous commands to edit and repeat them."
- "Use <kbd>Ctrl</kbd>+<kbd>R</kbd> to search through the previously entered commands."
- "Use `history` to display recent commands, and `![number]` to repeat a command by number."
---

**Loops** are a programming construct which allow us to repeat a command or set of commands
for each item in a list.

As such they are key to productivity improvements through automation.
Similar to wildcards and tab completion, using loops also reduces the
amount of typing required (and hence reduces the number of typing mistakes).


In a previous lesson, we learned how to pipe together commands 
to identify the smallest file. 


```
$ wc -l NENE*[AB].txt | sort -n   | head -n 1
```
{: .language-bash}


If you want to find the smallest entry within each file, you might try
the following command. This will give you the smallest entry
in all the files, but not the smallest entry in every file

```
$ sort -n  NENE*.txt | head -n 1
```
{: .language-bash}


```
0.000422950082062
```
{: .output}

For that task, we need a for loop. Shell loops look like this:

```
for thing in list_of_things
do
    operation_using $thing    # indentation is nice but not required
done
```
{: .language-bash}

and we can apply this to our example like this:

```
$ for file in NENE*[AB].txt
> do
>      sort -n $file | head -n 1
> done
```
{: .language-bash}

```
0.000727104356379
0.000422950082062
0.00140262849244
0.00194535354186
0.00224050924249
0.00278053248724
0.00551482529612
0.00284069578473
0.00112536860837
0.00487842954972
0.00464520333826
0.00180611947072
0.00428143068209
0.0071650810371
```
{: .output}


Sometimes it's nice to add an echo statment so you know what file is being processed

```
$ for file in NENE*[AB].txt
> do
>      echo $file 
>      sort -n $file | head -n 1
> done
```
{: .language-bash}



```
NENE01729A.txt
0.000727104356379
NENE01729B.txt
0.000422950082062
NENE01736A.txt
0.00140262849244
NENE01751A.txt
0.00194535354186
NENE01751B.txt
0.00224050924249
NENE01812A.txt
0.00278053248724
NENE01843A.txt
0.00551482529612
NENE01843B.txt
0.00284069578473
NENE01978A.txt
0.00112536860837
NENE01978B.txt
0.00487842954972
NENE02040A.txt
0.00464520333826
NENE02040B.txt
0.00180611947072
NENE02043A.txt
0.00428143068209
NENE02043B.txt
0.0071650810371
```
{: .output}




> ## Follow the Prompt
>
> The shell prompt changes from `$` to `>` and back again as we were
> typing in our loop. The second prompt, `>`, is different to remind
> us that we haven't finished typing a complete command yet. A semicolon, `;`,
> can be used to separate two commands written on a single line.
{: .callout}

When the shell sees the keyword `for`,
it knows to repeat a command (or group of commands) once for each item in a list.
Each time the loop runs (called an iteration), an item in the list is assigned in sequence to
the **variable**, and the commands inside the loop are executed, before moving on to
the next item in the list.
Inside the loop,
we call for the variable's value by putting `$` in front of it.
The `$` tells the shell interpreter to treat
the variable as a variable name and substitute its value in its place,
rather than treat it as text or an external command.


> ## Same Symbols, Different Meanings
>
> Here we see `>` being used as a shell prompt, whereas `>` is also
> used to redirect output.
> Similarly, `$` is used as a shell prompt, but, as we saw earlier,
> it is also used to ask the shell to get the value of a variable.
>
> If the *shell* prints `>` or `$` then it expects you to type something,
> and the symbol is a prompt.
>
> If *you* type `>` or `$` yourself, it is an instruction from you that
> the shell should redirect output or get the value of a variable.
{: .callout}

When using variables it is also
possible to put the names into curly braces to clearly delimit the variable
name: `$file` is equivalent to `${file}`. 
You may find this notation in other people's programs.

We have called the variable in this loop `file`
in order to make its purpose clearer to human readers.
The shell itself doesn't care what the variable is called;
if we wrote this loop as:

~~~
$ for x in NENE*txt
> do
>     head -n 2 $x | tail -n 1
> done
~~~
{: .language-bash}


Programs are only useful if people can understand them,
so meaningless names (like `x`) or misleading names (like `temperature`)
increase the odds that the program won't do what its readers think it does.


Note also that loops can be used for other things than filenames, like a list of numbers
or a subset of data.

> ## Write your own loop
>
> How would you write a loop that echoes all 10 numbers from 0 to 9?
>
> > ## Solution
> >
> > ~~~
> > $ for loop_variable in 0 1 2 3 4 5 6 7 8 9
> > > do
> > >     echo $loop_variable
> > > done
> > ~~~
> > {: .language-bash}
> >
> > ```
> > 0
> > 1
> > 2
> > 3
> > 4
> > 5
> > 6
> > 7
> > 8
> > 9
> > ```
> > {: .output}
> {: .solution}
{: .challenge}

> ## Variables in Loops
>
> This exercise refers to the `shell-lesson-data/exercise-data/proteins` directory.
> `ls *.pdb` gives the following output:
>
> ~~~
> cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> ~~~
> {: .output}
>
> What is the output of the following code?
>
> ~~~
> $ for datafile in *.pdb
> > do
> >     ls *.pdb
> > done
> ~~~
> {: .language-bash}
>
> Now, what is the output of the following code?
>
> ~~~
> $ for datafile in *.pdb
> > do
> >     ls $datafile
> > done
> ~~~
> {: .language-bash}
>
> Why do these two loops give different outputs?
>
> > ## Solution
> > The first code block gives the same output on each iteration through
> > the loop.
> > Bash expands the wildcard `*.pdb` within the loop body (as well as
> > before the loop starts) to match all files ending in `.pdb`
> > and then lists them using `ls`.
> > The expanded loop would look like this:
> > ```
> > $ for datafile in cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> > > do
> > >     ls cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> > > done
> > ```
> > {: .language-bash}
> >
> > ```
> > cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> > cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> > cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> > cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> > cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> > cubane.pdb  ethane.pdb  methane.pdb  octane.pdb  pentane.pdb  propane.pdb
> > ```
> > {: .output}
> >
> > The second code block lists a different file on each loop iteration.
> > The value of the `datafile` variable is evaluated using `$datafile`,
> > and then listed using `ls`.
> >
> > ```
> > cubane.pdb
> > ethane.pdb
> > methane.pdb
> > octane.pdb
> > pentane.pdb
> > propane.pdb
> > ```
> > {: .output}
> {: .solution}
{: .challenge}

> ## Limiting Sets of Files
>
> What would be the output of running the following loop in the
> `shell-lesson-data/exercise-data/proteins` directory?
>
> ~~~
> $ for filename in c*
> > do
> >     ls $filename
> > done
> ~~~
> {: .language-bash}
>
> 1.  No files are listed.
> 2.  All files are listed.
> 3.  Only `cubane.pdb`, `octane.pdb` and `pentane.pdb` are listed.
> 4.  Only `cubane.pdb` is listed.
>
> > ## Solution
> > 4 is the correct answer. `*` matches zero or more characters, so any file name starting with
> > the letter c, followed by zero or more other characters will be matched.
> {: .solution}
>
> How would the output differ from using this command instead?
>
> ~~~
> $ for filename in *c*
> > do
> >     ls $filename
> > done
> ~~~
> {: .language-bash}
>
> 1.  The same files would be listed.
> 2.  All the files are listed this time.
> 3.  No files are listed this time.
> 4.  The files `cubane.pdb` and `octane.pdb` will be listed.
> 5.  Only the file `octane.pdb` will be listed.
>
> > ## Solution
> > 4 is the correct answer. `*` matches zero or more characters, so a file name with zero or more
> > characters before a letter c and zero or more characters after the letter c will be matched.
> {: .solution}
{: .challenge}

> ## Saving to a File in a Loop - Part One
>
> In the `shell-lesson-data/exercise-data/proteins` directory, what is the effect of this loop?
>
> ~~~
> for alkanes in *.pdb
> do
>     echo $alkanes
>     cat $alkanes > alkanes.pdb
> done
> ~~~
> {: .language-bash}
>
> 1.  Prints `cubane.pdb`, `ethane.pdb`, `methane.pdb`, `octane.pdb`, `pentane.pdb` and
>    `propane.pdb`, and the text from `propane.pdb` will be saved to a file called `alkanes.pdb`.
> 2.  Prints `cubane.pdb`, `ethane.pdb`, and `methane.pdb`, and the text from all three files
>     would be concatenated and saved to a file called `alkanes.pdb`.
> 3.  Prints `cubane.pdb`, `ethane.pdb`, `methane.pdb`, `octane.pdb`, and `pentane.pdb`,
>     and the text from `propane.pdb` will be saved to a file called `alkanes.pdb`.
> 4.  None of the above.
>
> > ## Solution
> > 1. The text from each file in turn gets written to the `alkanes.pdb` file.
> > However, the file gets overwritten on each loop iteration, so the final content of
> > `alkanes.pdb`
> > is the text from the `propane.pdb` file.
> {: .solution}
{: .challenge}

> ## Saving to a File in a Loop - Part Two
>
> Also in the `shell-lesson-data/exercise-data/proteins` directory,
> what would be the output of the following loop?
>
> ~~~
> for datafile in *.pdb
> do
>     cat $datafile >> all.pdb
> done
> ~~~
> {: .language-bash}
>
> 1.  All of the text from `cubane.pdb`, `ethane.pdb`, `methane.pdb`, `octane.pdb`, and
>     `pentane.pdb` would be concatenated and saved to a file called `all.pdb`.
> 2.  The text from `ethane.pdb` will be saved to a file called `all.pdb`.
> 3.  All of the text from `cubane.pdb`, `ethane.pdb`, `methane.pdb`, `octane.pdb`, `pentane.pdb`
>     and `propane.pdb` would be concatenated and saved to a file called `all.pdb`.
> 4.  All of the text from `cubane.pdb`, `ethane.pdb`, `methane.pdb`, `octane.pdb`, `pentane.pdb`
>     and `propane.pdb` would be printed to the screen and saved to a file called `all.pdb`.
>
> > ## Solution
> > 3 is the correct answer. `>>` appends to a file, rather than overwriting it with the redirected
> > output from a command.
> > Given the output from the `cat` command has been redirected, nothing is printed to the screen.
> {: .solution}
{: .challenge}

Let's continue with our example.
Here's a slightly more complicated loop:

~~~
$ for file in NENE*[AB].txt
> do
>     echo $file
>     head -3 $file
> done
~~~
{: .language-bash}

The shell starts by expanding `*.txt` to create the list of files 
it will process.
The **loop body**
then executes two commands for each of those files.
The first command, `echo`, prints its command-line arguments to standard output.
For example:

~~~
$ echo hello there
~~~
{: .language-bash}

prints:

~~~
hello there
~~~
{: .output}


> ## Spaces in Names
>
> Spaces are used to separate the elements of the list
> that we are going to loop over. If one of those elements
> contains a space character, we need to surround it with
> quotes, and do the same thing to our loop variable.
> Suppose our data files are named:
>
> ~~~
> red dragon.dat
> purple unicorn.dat
> ~~~
> {: .source}
>
> To loop over these files, we would need to add double quotes like so:
>
> ~~~
> $ for filename in "red dragon.dat" "purple unicorn.dat"
> > do
> >     head -n 100 "$filename" | tail -n 20
> > done
> ~~~
> {: .language-bash}
>
> It is simpler to avoid using spaces (or other special characters) in filenames.
>
> The files above don't exist, so if we run the above code, the `head` command will be unable
> to find them, however the error message returned will show the name of the files it is
> expecting:
>
> ~~~
> head: cannot open ‘red dragon.dat’ for reading: No such file or directory
> head: cannot open ‘purple unicorn.dat’ for reading: No such file or directory
> ~~~
> {: .error}
>
> Try removing the quotes around `$filename` in the loop above to see the effect of the quote
> marks on spaces. Note that we get a result from the loop command for unicorn.dat
> when we run this code in the `creatures` directory:
>
> ~~~
> head: cannot open ‘red’ for reading: No such file or directory
> head: cannot open ‘dragon.dat’ for reading: No such file or directory
> head: cannot open ‘purple’ for reading: No such file or directory
> CGGTACCGAA
> AAGGGTCGCG
> CAAGTGTTCC
> ...
> ~~~
> {: .output}
{: .callout}

We would like to modify each of the files in `shell-lesson-data/exercise-data/creatures`,
but also save a version
of the original files, naming the copies `original-basilisk.dat` and `original-unicorn.dat`.
We can't use:

~~~
$ cp *.txt raw-*.txt
~~~
{: .language-bash}

because that would expand incorrectly.


This problem arises when `cp` receives more than one inputs. 
When this happens, itexpects the last input to be a directory
where it can copy all the files it was passed.
Since there is no directory named `original-*.dat` 
in the `creatures` directory we get an error.

Instead, we can use a loop:

~~~
$ for file in NENE*.txt
> do
>     cp $file raw-$file
> done
~~~
{: .language-bash}

This loop runs the `cp` command once for each filename.
The first time,
when `$file` expands to `NENE01729A.txt`,
the shell executes:

~~~
cp NENE01729A.txt raw-NENE01729A.txt
~~~
{: .language-bash}

The second time, the command is:

~~~
cp NENE01729B.txt raw-NENE01729B.txt
~~~
{: .language-bash}



Since the `cp` command does not normally produce any output, it's hard to check
that the loop is doing the correct thing.
However, we learned earlier how to print strings using `echo`, and we can modify the loop
to use `echo` to print our commands without actually executing them.
As such we can check what commands *would be* run in the unmodified loop.

~~~
$ for file in NENE*.txt
> do
>     echo $file raw-$file
>     cp $file raw-$file
> done
~~~
{: .language-bash}



```
NENE01729A.txt raw-NENE01729A.txt
NENE01729B.txt raw-NENE01729B.txt
NENE01736A.txt raw-NENE01736A.txt
NENE01751A.txt raw-NENE01751A.txt
NENE01751B.txt raw-NENE01751B.txt
NENE01812A.txt raw-NENE01812A.txt
NENE01843A.txt raw-NENE01843A.txt
NENE01843B.txt raw-NENE01843B.txt
NENE01971Z.txt raw-NENE01971Z.txt
NENE01978A.txt raw-NENE01978A.txt
NENE01978B.txt raw-NENE01978B.txt
NENE02040A.txt raw-NENE02040A.txt
NENE02040B.txt raw-NENE02040B.txt
NENE02043A.txt raw-NENE02043A.txt
NENE02043B.txt raw-NENE02043B.txt
```
{: .output}



The following diagram
shows what happens when the modified loop is executed, and demonstrates how the
judicious use of `echo` is a good debugging technique.

![The for loop "for filename in *.dat; do echo cp $filename original-$filename;
done" will successively assign the names of all "*.dat" files in your current
directory to the variable "$filename" and then execute the command. With the
files "basilisk.dat", "minotaur.dat" and "unicorn.dat" in the current directory
the loop will successively call the echo command three times and print three
lines: "cp basislisk.dat original-basilisk.dat", then "cp minotaur.dat
original-minotaur.dat" and finally "cp unicorn.dat
original-unicorn.dat"](../fig/shell_script_for_loop_flow_chart.svg)

## Processing Files

Nelle is now ready to process her data files using `goostats.sh` ---
a shell script written by her supervisor.
This calculates some statistics from a protein sample file, and takes two arguments:

1. an input file (containing the raw data)
2. an output file (to store the calculated statistics)

Since she's still learning how to use the shell,
she decides to build up the required commands in stages.
Her first step is to make sure that she can select the right input files --- remember,
these are ones whose names end in 'A' or 'B', rather than 'Z'.
Starting from her home directory, Nelle types:

~~~
$ cd north-pacific-gyre
$ for datafile in NENE*A.txt NENE*B.txt
> do
>     echo $datafile
> done
~~~
{: .language-bash}

~~~
NENE01729A.txt
NENE01729B.txt
NENE01736A.txt
...
NENE02043A.txt
NENE02043B.txt
~~~
{: .output}

Her next step is to decide
what to call the files that the `goostats.sh` analysis program will create.
Prefixing each input file's name with 'stats' seems simple,
so she modifies her loop to do that:

~~~
$ for datafile in NENE*A.txt NENE*B.txt
> do
>     echo $datafile stats-$datafile
> done
~~~
{: .language-bash}

~~~
NENE01729A.txt stats-NENE01729A.txt
NENE01729B.txt stats-NENE01729B.txt
NENE01736A.txt stats-NENE01736A.txt
...
NENE02043A.txt stats-NENE02043A.txt
NENE02043B.txt stats-NENE02043B.txt
~~~
{: .output}

She hasn't actually run `goostats.sh` yet,
but now she's sure she can select the right files and generate the right output filenames.

Typing in commands over and over again is becoming tedious,
though,
and Nelle is worried about making mistakes,
so instead of re-entering her loop,
she presses <kbd>↑</kbd>.
In response,
the shell redisplays the whole loop on one line
(using semi-colons to separate the pieces):

~~~
$ for datafile in NENE*A.txt NENE*B.txt; do echo $datafile stats-$datafile; done
~~~
{: .language-bash}

Using the left arrow key,
Nelle backs up and changes the command `echo` to `bash goostats.sh`:

~~~
$ for datafile in NENE*A.txt NENE*B.txt; do bash goostats.sh $datafile stats-$datafile; done
~~~
{: .language-bash}

When she presses <kbd>Enter</kbd>,
the shell runs the modified command.
However, nothing appears to happen --- there is no output.
After a moment, Nelle realizes that since her script doesn't print anything to the screen
any longer, she has no idea whether it is running, much less how quickly.
She kills the running command by typing <kbd>Ctrl</kbd>+<kbd>C</kbd>,
uses <kbd>↑</kbd> to repeat the command,
and edits it to read:

~~~
$ for datafile in NENE*A.txt NENE*B.txt; do echo $datafile;
bash goostats.sh $datafile stats-$datafile; done
~~~
{: .language-bash}

> ## Beginning and End
>
> We can move to the beginning of a line in the shell by typing <kbd>Ctrl</kbd>+<kbd>A</kbd>
> and to the end using <kbd>Ctrl</kbd>+<kbd>E</kbd>.
{: .callout}

When she runs her program now,
it produces one line of output every five seconds or so:

~~~
NENE01729A.txt
NENE01729B.txt
NENE01736A.txt
...
~~~
{: .output}

1518 times 5 seconds,
divided by 60,
tells her that her script will take about two hours to run.
As a final check,
she opens another terminal window,
goes into `north-pacific-gyre`,
and uses `cat stats-NENE01729B.txt`
to examine one of the output files.
It looks good,
so she decides to get some coffee and catch up on her reading.

> ## Those Who Know History Can Choose to Repeat It
>
> Another way to repeat previous work is to use the `history` command to
> get a list of the last few hundred commands that have been executed, and
> then to use `!123` (where '123' is replaced by the command number) to
> repeat one of those commands. For example, if Nelle types this:
>
> ~~~
> $ history | tail -n 5
> ~~~
> {: .language-bash}
> ~~~
>   456  ls -l NENE0*.txt
>   457  rm stats-NENE01729B.txt.txt
>   458  bash goostats.sh NENE01729B.txt stats-NENE01729B.txt
>   459  ls -l NENE0*.txt
>   460  history
> ~~~
> {: .output}
>
> then she can re-run `goostats.sh` on `NENE01729B.txt` simply by typing
> `!458`.
{: .callout}

> ## Other History Commands
>
> There are a number of other shortcut commands for getting at the history.
>
> - <kbd>Ctrl</kbd>+<kbd>R</kbd> enters a history search mode 'reverse-i-search' and finds the
> most recent command in your history that matches the text you enter next.
> Press <kbd>Ctrl</kbd>+<kbd>R</kbd> one or more additional times to search for earlier matches.
> You can then use the left and right arrow keys to choose that line and edit
> it then hit <kbd>Return</kbd> to run the command.
> - `!!` retrieves the immediately preceding command
> (you may or may not find this more convenient than using <kbd>↑</kbd>)
> - `!$` retrieves the last word of the last command.
> That's useful more often than you might expect: after
> `bash goostats.sh NENE01729B.txt stats-NENE01729B.txt`, you can type
> `less !$` to look at the file `stats-NENE01729B.txt`, which is
> quicker than doing <kbd>↑</kbd> and editing the command-line.
{: .callout}

> ## Doing a Dry Run
>
> A loop is a way to do many things at once --- or to make many mistakes at
> once if it does the wrong thing. One way to check what a loop *would* do
> is to `echo` the commands it would run instead of actually running them.
>
> Suppose we want to preview the commands the following loop will execute
> without actually running those commands:
>
> ~~~
> $ for datafile in *.pdb
> > do
> >     cat $datafile >> all.pdb
> > done
> ~~~
> {: .language-bash}
>
> What is the difference between the two loops below, and which one would we
> want to run?
>
> ~~~
> # Version 1
> $ for datafile in *.pdb
> > do
> >     echo cat $datafile >> all.pdb
> > done
> ~~~
> {: .language-bash}
>
> ~~~
> # Version 2
> $ for datafile in *.pdb
> > do
> >     echo "cat $datafile >> all.pdb"
> > done
> ~~~
> {: .language-bash}
>
> > ## Solution
> > The second version is the one we want to run.
> > This prints to screen everything enclosed in the quote marks, expanding the
> > loop variable name because we have prefixed it with a dollar sign.
> > It also *does not* modify nor create the file `all.pdb`, as the `>>`
> > is treated literally as part of a string rather than as a
> > redirection instruction.
> >
> > The first version appends the output from the command `echo cat $datafile`
> > to the file, `all.pdb`. This file will just contain the list;
> > `cat cubane.pdb`, `cat ethane.pdb`, `cat methane.pdb` etc.
> >
> > Try both versions for yourself to see the output! Be sure to open the
> > `all.pdb` file to view its contents.
> {: .solution}
{: .challenge}

> ## Nested Loops
>
> Suppose we want to set up a directory structure to organize
> some experiments measuring reaction rate constants with different compounds
> *and* different temperatures.  What would be the
> result of the following code:
>
> ~~~
> $ for species in cubane ethane methane
> > do
> >     for temperature in 25 30 37 40
> >     do
> >         mkdir $species-$temperature
> >     done
> > done
> ~~~
> {: .language-bash}
>
> > ## Solution
> > We have a nested loop, i.e. contained within another loop, so for each species
> > in the outer loop, the inner loop (the nested loop) iterates over the list of
> > temperatures, and creates a new directory for each combination.
> >
> > Try running the code for yourself to see which directories are created!
> {: .solution}
{: .challenge}

{% include links.md %}
