#!/bin/sh
# @name fileutils.sh
# @file fileutils.sh
# @author MXPSQL
# @brief A file utilities library
# This is a library that provides some file utilities (reading and writting)

# MIT License
# 
# Copyright (c) 2022 MXPSQL
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# @brief read a file
# @param $1 The file path
# @param $2 The line number to read (ALL if you want all and that is the default)
# @returns The text or a line of the text
# @stdout The text or a line of the text
# @exitcode 0 if the file exists
# @exitcode 1 if the file doesn't exist
# @example
#       echo $(mxpsql_shstuff_fileutils_read $FILE_PATH $LINE_NUMBER)
mxpsql_shstuff_fileutils_read(){
    # Set variables
    FILE="$1";
    LINEREAD=$2;

    if test -z "$LINEREAD"; then
        LINEREAD="ALL";
    fi

    if test -f "$FILE"; then
        TEXT=$(cat "$FILE");
        if test "$LINEREAD" = "ALL"; then
            echo "$TEXT";
        else
            echo "$TEXT" | head -n "$LINEREAD" | tail -n 1;
        fi
    else
        echo "The file doesn't exist";
        return 1;
    fi

    # Unset variables
    FILE=;LINEREAD=;
    TEXT=;

    return 0;
}

# @brief write a file
# @param $1 The file path
# @param $2 The text to write
# @returns Nothing if there is no problem
# @stdout Nothing if there is no problem
# @exitcode 0 if there is no problem
# @exitcode 1 if there is a problem
# @example
#       mxpsql_shstuff_fileutils_write $FILE_PATH $TEXT
mxpsql_shstuff_fileutils_write(){
    # Set variables
    FILE="$1";
    TEXT="$2";

    if test -f "$FILE"; then
        echo "$TEXT" >> "$FILE";
    else
        echo "The file doesn't exist";
        return 1;
    fi

    # Unset variables
    FILE=;TEXT=;

    return 0;
}