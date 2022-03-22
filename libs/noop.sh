#!/bin/sh

# @name noop.sh
# @file noop.sh
# @author MXPSQL
# @brief A noop library
# This is a library that does nothing.
# It contains a function that does nothing, not even changing the return value.
# Does not process any arguments.
#
# done with $? and return

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

# @brief Does nothing. Useless on it's own, unless you have a function that will require another function, but you want it to do nothing
# @noargs
# @returns last $?
# @example
#       echo $(noop)
#       # The $? depends if the last one is true or false
#       if noop; then 
#              echo "noop is true"
#       else
#              echo "noop is false"
#       fi
mxpsql_shstuff_noop(){
    return $?;
}