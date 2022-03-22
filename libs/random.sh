#!/bin/sh

# @name random.sh
# @file random.sh
# @author MXPSQL
# @brief A random generator library
# This is a library that generates random numbers.
# That is the only thing it does and you have to source it due to no $_ in pure POSIX.
# 
# Done with AWK and date, the former to make the random number and make it an integer and the latter for the seed
# This is the very first component btw.

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

# @brief Generates a random number
# @param $1 The minimum number
# @param $2 The maximum number
# @param $3 Do you want an integer (1) or a float (0), by default it's an integer
# @returns The random number, by using echo
# @stdout The random number
# 
# @example
#       echo $(mxpsql_shstuff_random 1 10)
#       echo $(mxpsql_shstuff_random 1 10 0)
#       echo $(mxpsql_shstuff_random 1 10 1)
mxpsql_shstuff_random() {
        # Set variables
        LOWRANGE=$1; HIGHRANGE=$2; INTORNOT=$3;
        SEED=$(date +%s);

        if test -z "$3"; then
                INTORNOT=1
        fi

        # Result
        RES=$(echo | awk -v min="$LOWRANGE" -v max="$HIGHRANGE" -v seed="$SEED" 'BEGIN{srand(seed); print min+rand()*(max-min+1)}');

        # Make it integer or not
        if test "$INTORNOT" = "1"; then
                RES=$(echo | awk -v res="$RES" 'BEGIN{print int(res)}')
        fi

        # Blast the result
        echo "$RES";

        # Unset it
        LOWRANGE=;HIGHRANGE=;INTORNOT=;
        SEED=;

        RES=;

}


# Find a POSIX way to check if this is sourced or not