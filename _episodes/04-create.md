---
title: "Working With Files and Directories (aka Organization)"
teaching: 15
exercises: 5
questions:
- "cp"
- "mkdir"
- "mv"
- "nano"
- "rm"
- "rmdir"
objectives:
- "Create a directory hierarchy that matches a given diagram."
- "Create files in that hierarchy using an editor or by copying and renaming existing files."
- "Delete, copy and move specified files and/or directories."
keypoints:
- "`cp [old] [new]` copies a file."
- "`mkdir [path]` creates a new directory."
- "`mv [old] [new]` moves (renames) a file or directory."
- "`rm [path]` removes (deletes) a file."
- "`*` matches zero or more characters in a filename, so `*.txt` matches all files ending in `.txt`."
- "`?` matches any single character in a filename, so `?.txt` matches `a.txt` but not `any.txt`."
- "Use of the Control key may be described in many ways, including `Ctrl-X`, `Control-X`, and `^X`."
- "The shell does not have a trash bin: once something is deleted, it's really gone."
- "Most files' names are `something.extension`. The extension isn't required, and doesn't guarantee anything, but is normally used to indicate the type of data in the file."
- "Depending on the type of work you do, you may need a more powerful text editor than Nano."
---

## Creating directories

We now know how to explore files and directories,
but how do we create them in the first place?


We should still be in the `shell-lesson-data/north-pacific-gyre` 
directory on the Desktop, which we can check using:

~~~
$ pwd
~~~
{: .language-bash}

~~~
/Users/nelle/Desktop/shell-lesson-data/north-pacific-gyre
~~~
{: .output}

If necessary, navigate there with a command like the following:

~~~
$ cd ~/Desktop/shell-lesson-data/north-pacific-gyre
~~~
{:  .language-bash}

Since we created some files, this directory is now a mixture of 
raw data, summary data, and scripts. 

~~~
$ ls 
~~~
{: .language-bash}

~~~
NENE01729A.txt		NENE01843B.txt		NENE02043A.txt
NENE01729B.txt		NENE01971Z.txt		NENE02043B.txt
NENE01736A.txt		NENE01978A.txt		goodiff.sh
NENE01751A.txt		NENE01978B.txt		goostats.sh
NENE01751B.txt		NENE02040A.txt		lengths.txt
NENE01812A.txt		NENE02040B.txt		sorted-lengths.txt
NENE01843A.txt		NENE02040Z.txt
~~~
{: .output}

### Create a directory

Let's create a new directory called `results` using the command `mkdir results`
(which has no output):

~~~
$ mkdir results
~~~
{: .language-bash}

As you might guess from its name,
`mkdir` means 'make directory'.
Since `thesis` is a relative path
(i.e., does not have a leading slash, like `/what/ever/thesis`),
the new directory is created in the current working directory:

~~~
$ ls -F
~~~
{: .language-bash}

~~~
NENE01729A.txt		NENE01843B.txt		NENE02043A.txt
NENE01729B.txt		NENE01971Z.txt		NENE02043B.txt
NENE01736A.txt		NENE01978A.txt		goodiff.sh
NENE01751A.txt		NENE01978B.txt		goostats.sh
NENE01751B.txt		NENE02040A.txt		lengths.txt
NENE01812A.txt		NENE02040B.txt		results/
NENE01843A.txt		NENE02040Z.txt		sorted-lengths.txt
~~~
{: .output}

Since we've just created the `results` directory, there's nothing in it yet:

~~~
$ ls -F results
~~~
{: .language-bash}

Note that `mkdir` is not limited to creating single directories one at a time.
The `-p` option allows `mkdir` to create a directory with nested subdirectories
in a single operation:

~~~
$ mkdir -p results/lengths/2022-07/

~~~
{: .language-bash}



> ## Two ways of doing the same thing
> Using the shell to create a directory is no different than using a file explorer.
> If you open the current directory using your operating system's graphical file explorer,
> the `thesis` directory will appear there too.
> While the shell and the file explorer are two different ways of interacting with the files,
> the files and directories themselves are the same.
{: .callout}

> ## Good names for files and directories
>
> Complicated names of files and directories can make your life painful
> when working on the command line. Here we provide a few useful
> tips for the names of your files and directories.
>
> 1. Don't use spaces.
>
>    Spaces can make a name more meaningful,
>    but since spaces are used to separate arguments on the command line
>    it is better to avoid them in names of files and directories.
>    You can use `-` or `_` instead (e.g. `north-pacific-gyre/` rather than `north pacific gyre/`).
>    To test this out, try typing `mkdir north pacific gyre`and see what directory (or directories!)
>    are made when you check with `ls -F`.
>
> 2. Don't begin the name with `-` (dash).
>
>    Commands treat names starting with `-` as options.
>
> 3. Stick with letters, numbers, `.` (period or 'full stop'), `-` (dash) and `_` (underscore).
>
>    Many other characters have special meanings on the command line.
>    We will learn about some of these during this lesson.
>    There are special characters that can cause your command to not work as
>    expected and can even result in data loss.
>
> If you need to refer to names of files or directories that have spaces
> or other special characters, you should surround the name in quotes (`""`).
{: .callout}

### Open a text file

Let's change our working directory to `thesis` using `cd`,
then run a text editor called Nano to create a file called `draft.txt`:

~~~
$ nano sorted-lengths.txt
~~~
{: .language-bash}

> ## Which Editor?
>
> When we say, '`nano` is a text editor' we really do mean 'text': it can
> only work with plain character data, not tables, images, or any other
> human-friendly media. We use it in examples because it is one of the
> least complex text editors. However, because of this trait, it may
> not be powerful enough or flexible enough for the work you need to do
> after this workshop. On Unix systems (such as Linux and macOS),
> many programmers use [Emacs](http://www.gnu.org/software/emacs/) or
> [Vim](http://www.vim.org/) (both of which require more time to learn),
> or a graphical editor such as
> [Gedit](http://projects.gnome.org/gedit/). On Windows, you may wish to
> use [Notepad++](http://notepad-plus-plus.org/).  Windows also has a built-in
> editor called `notepad` that can be run from the command line in the same
> way as `nano` for the purposes of this lesson.
>
> No matter what editor you use, you will need to know where it searches
> for and saves files. If you start it from the shell, it will (probably)
> use your current working directory as its default location. If you use
> your computer's start menu, it may want to save files in your desktop or
> documents directory instead. You can change this by navigating to
> another directory the first time you 'Save As...'
{: .callout}

Let's type in a few lines of text.
Once we're happy with our text, we can press <kbd>Ctrl</kbd>+<kbd>O</kbd>
(press the <kbd>Ctrl</kbd> or <kbd>Control</kbd> key and, while
holding it down, press the <kbd>O</kbd> key) to write our data to disk
(we'll be asked what file we want to save this to:
press <kbd>Return</kbd> 
to accept the suggested default of `sorted-lengths.txt`).

<div style="width:80%; margin: auto;"><img alt="screenshot of nano text editor in action"
src="../fig/nano-screenshot.png"></div>

Once our file is saved, we can use <kbd>Ctrl</kbd>+<kbd>X</kbd> to quit the editor and
return to the shell.

> ## Control, Ctrl, or ^ Key
>
> The Control key is also called the 'Ctrl' key. There are various ways
> in which using the Control key may be described. For example, you may
> see an instruction to press the <kbd>Control</kbd> key and, while holding it down,
> press the <kbd>X</kbd> key, described as any of:
>
> * `Control-X`
> * `Control+X`
> * `Ctrl-X`
> * `Ctrl+X`
> * `^X`
> * `C-x`
>
> In nano, along the bottom of the screen you'll see `^G Get Help ^O WriteOut`.
> This means that you can use `Control-G` to get help and `Control-O` to save your
> file.
{: .callout}




> ## What's In A Name?
>
> You may have noticed that all of Nelle's files are named 'something dot
> something', and in this part of the lesson, we always used the extension
> `.txt`.  This is just a convention: we can call a file `mythesis` or
> almost anything else we want. However, most people use two-part names
> most of the time to help them (and their programs) tell different kinds
> of files apart. The second part of such a name is called the
> **filename extension** and indicates
> what type of data the file holds: `.txt` signals a plain text file, `.pdf`
> indicates a PDF document, `.cfg` is a configuration file full of parameters
> for some program or other, `.png` is a PNG image, and so on.
>
> This is just a convention, albeit an important one. Files contain
> bytes: it's up to us and our programs to interpret those bytes
> according to the rules for plain text files, PDF documents, configuration
> files, images, and so on.
>
> Naming a PNG image of a whale as `whale.mp3` doesn't somehow
> magically turn it into a recording of whale song, though it *might*
> cause the operating system to try to open it with a music player
> when someone double-clicks it.
{: .callout}



## Moving files and directories

We can use the `mv` command to move files from the working directory to the results directory.


~~~
$ mv lengths.txt results
$ mv sorted-lengths.txt results
~~~
{: .language-bash}

The first argument tells `mv` what we're 'moving',
while the second is where it's to go.
In this case,
we're moving `thesis/draft.txt` to `thesis/quotes.txt`,
which has the same effect as renaming the file.
Sure enough,
`ls` shows us that `thesis` now contains one file called `quotes.txt`:

~~~
$ ls results
~~~
{: .language-bash}

~~~
lengths.txt		sorted-lengths.txt
~~~
{: .output}

One must be careful when specifying the target file name, since `mv` will
silently overwrite any existing file with the same name, which could
lead to data loss. An additional option, `mv -i` (or `mv --interactive`),
can be used to make `mv` ask you for confirmation before overwriting.

Note that `mv` also works on directories.


## Copying files and directories

It is good practice to save a copy of your raw data.
This ensures that data can be recovered if lost or modified.

The `cp` command works very much like `mv`,
except it copies a file instead of moving it.
We can check that it did the right thing using `ls`.
Let's make a directory called `raw-data` and copy all the NENE*txt files there.


~~~
$ mkdir raw-data
$ cp NENE*txt raw-data
$ ls raw-data
~~~
{: .language-bash}

~~~
NENE01729A.txt	NENE01751B.txt	NENE01971Z.txt	NENE02040B.txt
NENE01729B.txt	NENE01812A.txt	NENE01978A.txt	NENE02040Z.txt
NENE01736A.txt	NENE01843A.txt	NENE01978B.txt	NENE02043A.txt
NENE01751A.txt	NENE01843B.txt	NENE02040A.txt	NENE02043B.txt
~~~
{: .output}



> ## Renaming Files
>
> Suppose that you created a plain-text file in your current directory to contain a list of the
> statistical tests you will need to do to analyze your data, and named it: `statstics.txt`
>
> After creating and saving this file you realize you misspelled the filename! You want to
> correct the mistake, which of the following commands could you use to do so?
>
> 1. `cp statstics.txt statistics.txt`
> 2. `mv statstics.txt statistics.txt`
> 3. `mv statstics.txt .`
> 4. `cp statstics.txt .`
>
> > ## Solution
> > 1. No.  While this would create a file with the correct name,
> > the incorrectly named file still exists in the directory
> > and would need to be deleted.
> > 2. Yes, this would work to rename the file.
> > 3. No, the period(.) indicates where to move the file, but does not provide a new file name;
> > identical file names
> > cannot be created.
> > 4. No, the period(.) indicates where to copy the file, but does not provide a new file name;
> > identical file names cannot be created.
> {: .solution}
{: .challenge}


## Removing files and directories

Returning to the `shell-lesson-data/exercise-data/writing` directory,
let's tidy up this directory by removing the `quotes.txt` file we created.
The Unix command we'll use for this is `rm` (short for 'remove'):

~~~
$ rm NENE02040Z.txt
~~~
{: .language-bash}

We can confirm the file has gone using `ls`:

~~~
$ ls NENE02040Z.txt
~~~
{: .language-bash}

```
ls: cannot access 'quotes.txt': No such file or directory
```
{: .error}

> ## Deleting Is Forever
>
> The Unix shell doesn't have a trash bin that we can recover deleted
> files from (though most graphical interfaces to Unix do).  Instead,
> when we delete files, they are unlinked from the file system so that
> their storage space on disk can be recycled. Tools for finding and
> recovering deleted files do exist, but there's no guarantee they'll
> work in any particular situation, since the computer may recycle the
> file's disk space right away.
{: .callout}


If we try to remove the `thesis` directory using `rm thesis`,
we get an error message:

~~~
$ rm results
~~~
{: .language-bash}

~~~
rm: cannot remove 'thesis': Is a directory 
~~~
{: .error}


This happens because `rm` by default only works on files, not directories.

`rm` can remove a directory *and all its contents* if we use the
recursive option `-r`, and it will do so *without any confirmation prompts*:

~~~
$ rm -r results
~~~
{: .language-bash}


Given that there is no way to retrieve files deleted using the shell,
`rm -r` *should be used with great caution*
(you might consider adding the interactive option `rm -r -i`).

## Operations with multiple files and directories

Oftentimes one needs to copy or move several files at once.
This can be done by providing a list of individual filenames,
or specifying a naming pattern using wildcards.

> ## Copy with Multiple Filenames
>
> For this exercise, you can test the commands in the `shell-lesson-data/exercise-data` directory.
>
> In the example below, what does `cp` do when given several filenames and a directory name?
>
> ~~~
> $ mkdir backup
> $ cp creatures/minotaur.dat creatures/unicorn.dat backup/
> ~~~
> {: .language-bash}
>
> In the example below, what does `cp` do when given three or more file names?
>
> ~~~
> $ cd creatures
> $ ls -F
> ~~~
> {: .language-bash}
> ~~~
> basilisk.dat  minotaur.dat  unicorn.dat
> ~~~
> {: .output}
> ~~~
> $ cp minotaur.dat unicorn.dat basilisk.dat
> ~~~
> {: .language-bash}
>
> > ## Solution
> > If given more than one file name followed by a directory name
> > (i.e. the destination directory must be the last argument),
> > `cp` copies the files to the named directory.
> >
> > If given three file names, `cp` throws an error such as the one below,
> > because it is expecting a directory name as the last argument.
> >
> > ```
> > cp: target 'basilisk.dat' is not a directory
> > ```
> > {: .error}
> {: .solution}
{: .challenge}

### Using wildcards for accessing multiple files at once

> ## Wildcards
>
> `*` is a **wildcard**, which matches zero or more  characters.
> Let's consider the `shell-lesson-data/exercise-data/proteins` directory:
> `*.pdb` matches `ethane.pdb`, `propane.pdb`, and every
> file that ends with '.pdb'. On the other hand, `p*.pdb` only matches
> `pentane.pdb` and `propane.pdb`, because the 'p' at the front only
> matches filenames that begin with the letter 'p'.
>
> `?` is also a wildcard, but it matches exactly one character.
> So `?ethane.pdb` would match `methane.pdb` whereas
> `*ethane.pdb` matches both `ethane.pdb`, and `methane.pdb`.
>
> Wildcards can be used in combination with each other
> e.g. `???ane.pdb` matches three characters followed by `ane.pdb`,
> giving `cubane.pdb  ethane.pdb  octane.pdb`.
>
> When the shell sees a wildcard, it expands the wildcard to create a
> list of matching filenames *before* running the command that was
> asked for. As an exception, if a wildcard expression does not match
> any file, Bash will pass the expression as an argument to the command
> as it is. For example, typing `ls *.pdf` in the `proteins` directory
> (which contains only files with names ending with `.pdb`) results in
> an error message that there is no file called `*.pdf`.
> However, generally commands like `wc` and `ls` see the lists of
> file names matching these expressions, but not the wildcards
> themselves. It is the shell, not the other programs, that deals with
> expanding wildcards.
{: .callout}

> ## List filenames matching a pattern
>
> When run in the `proteins` directory, which `ls` command(s) will
> produce this output?
>
> `ethane.pdb   methane.pdb`
>
> 1. `ls *t*ane.pdb`
> 2. `ls *t?ne.*`
> 3. `ls *t??ne.pdb`
> 4. `ls ethane.*`
>
> > ## Solution
>>  The solution is `3.`
>>
>> `1.` shows all files whose names contain zero or more characters (`*`)
>> followed by the letter `t`,
>> then zero or more characters (`*`) followed by `ane.pdb`.
>> This gives `ethane.pdb  methane.pdb  octane.pdb  pentane.pdb`.
>>
>> `2.` shows all files whose names start with zero or more characters (`*`) followed by
>> the letter `t`,
>> then a single character (`?`), then `ne.` followed by zero or more characters (`*`).
>> This will give us `octane.pdb` and `pentane.pdb` but doesn't match anything
>> which ends in `thane.pdb`.
>>
>> `3.` fixes the problems of option 2 by matching two characters (`??`) between `t` and `ne`.
>> This is the solution.
>>
>> `4.` only shows files starting with `ethane.`.
> {: .solution}
{: .challenge}

> ## More on Wildcards
>
> Sam has a directory containing calibration data, datasets, and descriptions of
> the datasets:
>
> ~~~
> .
> ├── 2015-10-23-calibration.txt
> ├── 2015-10-23-dataset1.txt
> ├── 2015-10-23-dataset2.txt
> ├── 2015-10-23-dataset_overview.txt
> ├── 2015-10-26-calibration.txt
> ├── 2015-10-26-dataset1.txt
> ├── 2015-10-26-dataset2.txt
> ├── 2015-10-26-dataset_overview.txt
> ├── 2015-11-23-calibration.txt
> ├── 2015-11-23-dataset1.txt
> ├── 2015-11-23-dataset2.txt
> ├── 2015-11-23-dataset_overview.txt
> ├── backup
> │   ├── calibration
> │   └── datasets
> └── send_to_bob
>     ├── all_datasets_created_on_a_23rd
>     └── all_november_files
> ~~~
> {: .language-bash}
>
> Before heading off to another field trip, she wants to back up her data and
> send some datasets to her colleague Bob. Sam uses the following commands
> to get the job done:
>
> ~~~
> $ cp *dataset* backup/datasets
> $ cp ____calibration____ backup/calibration
> $ cp 2015-____-____ send_to_bob/all_november_files/
> $ cp ____ send_to_bob/all_datasets_created_on_a_23rd/
> ~~~
> {: .language-bash}
>
> Help Sam by filling in the blanks.
>
> The resulting directory structure should look like this
> ```
> .
> ├── 2015-10-23-calibration.txt
> ├── 2015-10-23-dataset1.txt
> ├── 2015-10-23-dataset2.txt
> ├── 2015-10-23-dataset_overview.txt
> ├── 2015-10-26-calibration.txt
> ├── 2015-10-26-dataset1.txt
> ├── 2015-10-26-dataset2.txt
> ├── 2015-10-26-dataset_overview.txt
> ├── 2015-11-23-calibration.txt
> ├── 2015-11-23-dataset1.txt
> ├── 2015-11-23-dataset2.txt
> ├── 2015-11-23-dataset_overview.txt
> ├── backup
> │   ├── calibration
> │   │   ├── 2015-10-23-calibration.txt
> │   │   ├── 2015-10-26-calibration.txt
> │   │   └── 2015-11-23-calibration.txt
> │   └── datasets
> │       ├── 2015-10-23-dataset1.txt
> │       ├── 2015-10-23-dataset2.txt
> │       ├── 2015-10-23-dataset_overview.txt
> │       ├── 2015-10-26-dataset1.txt
> │       ├── 2015-10-26-dataset2.txt
> │       ├── 2015-10-26-dataset_overview.txt
> │       ├── 2015-11-23-dataset1.txt
> │       ├── 2015-11-23-dataset2.txt
> │       └── 2015-11-23-dataset_overview.txt
> └── send_to_bob
>     ├── all_datasets_created_on_a_23rd
>     │   ├── 2015-10-23-dataset1.txt
>     │   ├── 2015-10-23-dataset2.txt
>     │   ├── 2015-10-23-dataset_overview.txt
>     │   ├── 2015-11-23-dataset1.txt
>     │   ├── 2015-11-23-dataset2.txt
>     │   └── 2015-11-23-dataset_overview.txt
>     └── all_november_files
>         ├── 2015-11-23-calibration.txt
>         ├── 2015-11-23-dataset1.txt
>         ├── 2015-11-23-dataset2.txt
>         └── 2015-11-23-dataset_overview.txt
> ```
> {: .language-bash}
>
> > ## Solution
> > ```
> > $ cp *calibration.txt backup/calibration
> > $ cp 2015-11-* send_to_bob/all_november_files/
> > $ cp *-23-dataset* send_to_bob/all_datasets_created_on_a_23rd/
> > ```
> > {: .language-bash}
> {: .solution}
{: .challenge}


> ## Reproduce a folder structure
>
> You're starting a new experiment and would like to duplicate the directory
> structure from your previous experiment so you can add new data.
>
> Assume that the previous experiment is in a folder called `2016-05-18`,
> which contains a `data` folder that in turn contains folders named `raw` and
> `processed` that contain data files.  The goal is to copy the folder structure
> of the `2016-05-18` folder into a folder called `2016-05-20`
> so that your final directory structure looks like this:
>
> ~~~
> 2016-05-20/
> └── data
>    ├── processed
>    └── raw
> ~~~
> {: .output}
>
> Which of the following set of commands would achieve this objective?
> What would the other commands do?
>
> ~~~
> $ mkdir 2016-05-20
> $ mkdir 2016-05-20/data
> $ mkdir 2016-05-20/data/processed
> $ mkdir 2016-05-20/data/raw
> ~~~
> {: .language-bash}
> ~~~
> $ mkdir 2016-05-20
> $ cd 2016-05-20
> $ mkdir data
> $ cd data
> $ mkdir raw processed
> ~~~
> {: .language-bash}
> ~~~
> $ mkdir 2016-05-20/data/raw
> $ mkdir 2016-05-20/data/processed
> ~~~
> {: .language-bash}
> ~~~
> $ mkdir -p 2016-05-20/data/raw
> $ mkdir -p 2016-05-20/data/processed
> ~~~
> {: .language-bash}
> ~~~
> $ mkdir 2016-05-20
> $ cd 2016-05-20
> $ mkdir data
> $ mkdir raw processed
> ~~~
> {: .language-bash}
> >
> > ## Solution
> > The first two sets of commands achieve this objective.
> > The first set uses relative paths to create the top-level directory before
> > the subdirectories.
> >
> > The third set of commands will give an error because the default behavior of `mkdir`
> > won't create a subdirectory of a non-existent directory:
> > the intermediate level folders must be created first.
> >
> > The fourth set of commands achieve this objective. Remember, the `-p` option,
> > followed by a path of one or more
> > directories, will cause `mkdir` to create any intermediate subdirectories as required.
> >
> > The final set of commands generates the 'raw' and 'processed' directories at the same level
> > as the 'data' directory.
> {: .solution}
{: .challenge}

{% include links.md %}
