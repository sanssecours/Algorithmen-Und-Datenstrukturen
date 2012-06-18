#! /bin/bash

# ------------------------------------------------------------------------------
## @file		convert_code_to_tex.sh
## @group		Utilities
## @details		Converts sourcecode files to LaTeX files with syntax
##				highlighting
## @version		2
## @date		2012-06-11
## @author		René Schwaiger (sanssecours@f-m.fm)
# ------------------------------------------------------------------------------

# -- Constants -----------------------------------------------------------------

## To check for successfull execution of a command
EXIT_SUCCESS="0"

# -- Functions -----------------------------------------------------------------

## Checks the status of the last command and exits there was an error
##
## @reads	error_message
##				The message which should be displayed if there was an error
function exit_on_failure()
{
	if [ "$?" != "$EXIT_SUCCESS" ]; then
		echo -n "ERROR: "
		echo $error_message
		exit 1
	fi
}

## Converts the source code files given in the array input_files in the folder
## input_dir array to LaTeX code with syntax highlithing naming the resulting
## files with the names given in the array output_files storing them in the
## directory given by output_dir
##
## @reads input_dir
##			The directory where the source code files are located
## @reads input_files
##			The file which should be converted
## @reads output_dir
##			The directory where the converted LaTeX files are saved
## @reads output_files
## 			The name of the converted files
function convert_to_tex()
{
	# Use highlih to convert the files
	# --------------------------------
	# -o Latex		Generate LaTeX output
	# -f			Omit header and footer in output
	# -r			Replace double quotes by \dq{}
	# -t 4			Tabsize = 4
	# -s rand01		Style = rand01
	convert='highlight -O latex -f -r -t 4 -s rand01 -i'

	for (( file_index = 0 ; file_index < ${#input_files[@]} ; file_index++ ))
		do
			code_file="$input_dir"${input_files[$file_index]}
			tex_file="$output_dir${output_files[$file_index]}.tex"

			# Convert single file
			$convert "$code_file" > "$tex_file"

			# Check for error
			error_message="Could not convert "${tex_file}""
			exit_on_failure

			# Display conversion step on success
			echo "${code_file} => ${tex_file}"
	done
}

# -- Main ----------------------------------------------------------------------

input_dir="../Pseudocode/"
output_dir='../Code/'
# e.g. hello.sh
input_files=(Aufgabe1a_2011_10_03.cc
			Aufgabe1b_2011_10_03.cc)
# e.g. hello
output_files=(Aufgabe1a_2011_10_03
			Aufgabe1b_2011_10_03)

# Convert the files
convert_to_tex

echo "Done with conversion"