#!/bin/sh


# @name deargv0.sh
# @file deargv0.sh
# @author MXPSQL
# @brief A script to remove the first argument of the command line
# This is a script that removes the first argument of the command line.
#
# Uses AWK

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

# @brief Removes the first argument of the command line
# @param $@ All the argument
# @returns The result of the command line without the first argument
# @stdout The result of the command line without the first argument
#
# @example
#       echo $(mxpsql_shstuff_deargv0 "1" "2" "3")
#       echo $(mxpsql_shstuff_deargv0 "1" "2" "3" "4" "5")
#       echo $(mxpsql_shstuff_deargv0 "1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
mxpsql_shstuff_deargv0(){
    # remove the argv0 in AWK

    # Set variables
    ARGV="$*";

    # Result
    RES=$(echo | awk -v str="$ARGV" 'BEGIN{print substr(str,3)}');

    # Blast the result
    echo "$RES";

    # Unset it
    ARGV=;

    RES=;
}