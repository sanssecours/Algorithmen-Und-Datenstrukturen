#! /bin/bash

# -----------------------------------------------------------------------------
#   Converts sourcecode files to LaTeX files with syntax highlighting
#
#   Version:    6
#   Date:       2013-05-25
#   Author:     René Schwaiger (sanssecours@f-m.fm)
#
# -----------------------------------------------------------------------------

# -- Constants ----------------------------------------------------------------

# To check for successfull execution of a command
EXIT_SUCCESS="0"

# -- Functions ----------------------------------------------------------------

# -----------------------------------------------------------------------------
#   Checks the status of the last command and exits if there was an error.
#
#   Arguments:
#
#       $0 - The message which should be displayed if there was an error.
#
# -----------------------------------------------------------------------------
function exit_on_failure()
{
    if [ "$?" != "$EXIT_SUCCESS" ]; then
        echo -n "ERROR: "
        echo -e "${1}"
        exit 1
    fi
}

# -----------------------------------------------------------------------------
#   Convert source code files to (Xe)LaTeX files.
#
#   Converts the source code files given in the array input_files in the folder
#   input_dir array to LaTeX code with syntax highlithing naming the resulting
#   files with the names given in the array output_files storing them in the
#   directory given by output_dir.
#
#   Arguments:
#
#       input_dir    - The directory where the source code files are located.
#       input_files  - The file which should be converted.
#       output_dir   - The directory where the converted LaTeX files are saved.
#       output_files - The name of the converted files.
#
# -----------------------------------------------------------------------------
function convert_to_tex()
{
    # Use highlih to convert the files
    # --------------------------------
    # -o Latex          Generate LaTeX output
    # -f                Omit header and footer in output
    # -t 4              Tabsize = 4
    # -s rand01         Style = rand01
    # --no-trailing-nl  Omit trailing newline
    convert='highlight -O latex --encoding=utf8 --no-trailing-nl -f -t 4 -i'

    for (( file_index = 0 ; file_index < "${#input_files[@]}" ; file_index++ ))
        do
            code_file="$input_dir"${input_files[$file_index]}
            tex_file="$output_dir${output_files[$file_index]}.tex"

            # Convert single file
            $convert "$code_file" > "$tex_file"

            # Remove extra newline at the end of the generated code
            sed -n '1h;1!H;${;g;s/\\\\\n\\mbox/\\mbox/g;p;}' \
                "$tex_file" > tmp.txt
            mv tmp.txt "$tex_file"

            # Check for error
            exit_on_failure "Could not convert "${code_file}""

            # Display conversion step on success
            echo "${code_file} => ${tex_file}"
    done
}

# -- Main ---------------------------------------------------------------------

input_dir="Pseudocode/"
output_dir='Code/'
# e.g. hello.sh
input_files=(Add_Constant.c
             Aufgabe1a_2011_10_03.cc
             Aufgabe1b_2011_10_03.cc
             Independent_Loops.c
             Subtract.c
             Two_Dependent_Loops.c
             Two_Dependent_Loops_Quadratic.c)
# e.g. hello
output_files=(Add_Constant
              Aufgabe1a_2011_10_03
              Aufgabe1b_2011_10_03
              Independent_Loops
              Subtract
              Two_Dependent_Loops
              Two_Dependent_Loops_Quadratic)

# Create ouptut directory if it does not exist already
mkdir -p "$output_dir"
# Convert the files
convert_to_tex

echo "Done with conversion"
