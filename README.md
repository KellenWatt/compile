# Compile

A Ruby script to make compilation and pseudo-compilation semi-automatic.

## What it does

When run without any arguments (i.e. `compile`), compile first checks if there are any build tool files in the directory (currently 
only `make` and `rake`, more are welcome to be checked.) and runs the file, if it exists.
If nothing matches these, then compile counts the number of each type of file by extension(s) (specified in `lib/.languages.rb`) 
and executes the associated language's generic compiler script, as defined in `lib/<language>.rb`.

When run with an argument, compile assumes it is the name of a language, and runs that language's compile script directly, without counting.

## How does compilation work?

Compilation of any form usually is along the usual lines of:
1. Select the files
2. Validate code
3. Combine files into an executable form

How this is done within an individual compilation script can vary wildly however. Sometimes these processes are done entirely in 
the native compiler, and sometimes the compile script does the whole thing, and in other cases, there's a combination of the three steps. 

In the case of compiled languages, steps 2 and 3 are often done within the native compiler, whereas step 1 may or may not have to be 
done by compile script.

In the case of interpreted languages, step 1 must be done by the compile script, step 2 is usually optional, although it is highly 
recommended for rigour, and step 3 must be done by the compile script. Please note that a function is provided for combining interpretted 
files. The "executable" is the combined files, but writing to a file and setting permissions must be done by the script.
