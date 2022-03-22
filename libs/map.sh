#!/bin/sh
# @name map.sh
# @file map.sh
# @author MXPSQL
# @brief A map library
# This is a library that provides a map (associative array)
# Yes, you heard it, a map, not a hashmap though.

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

# @brief Make a new map
# @noargs
# @returns The path to the map, by using echo
# @stdout The path to the map
# @example
#       MAP_PATH=$(mxpsql_shstuff_map)
mxpsql_shstuff_map_new(){
    echo "$(mktemp -d)";
}

# @brief Add a key/value pair to a map
# @param $1 The map path
# @param $2 The key
# @param $3 The value
# @returns A message is something is wrong
# @stdout A message is something is wrong if it happens
# @exitcode 0 if nothing is wrong
# @exitcode 1 if something is wrong
# @example
#       mxpsql_shstuff_map_set $MAP_PATH $KEY $VALUE
mxpsql_shstuff_map_set(){
    # Set variables
    MAP=$1; KEY=$2; VALUE=$3;
    # Check if the map exists
    if test -d "$MAP"; then
        # Check if the key exists
        if test -f "$MAP/$KEY"; then
            # Remove the key
            rm "$MAP/$KEY";
        fi
        # Set the key
        echo "$VALUE" > "$MAP/$KEY";
    else
        echo "The map doesn't exist";
        return 1;
    fi
    # Unset variables
    MAP=;KEY=;VALUE=;

    return 0;
}

# @brief Get a value from a map
# @param $1 The map path
# @param $2 The key
# @returns A message is something is wrong or the key value
# @stdout A message is something is wrong if it happens or the key value
# @exitcode 0 if nothing is wrong
# @exitcode 1 if something is wrong
# @example
#       echo $(mxpsql_shstuff_map_get $MAP_PATH $KEY)
mxpsql_shstuff_map_get(){
    # Set variables
    MAP=$1; KEY=$2;
    # Check if the map exists
    if test -d "$MAP"; then
        # Check if the key exists
        if test -f "$MAP/$KEY"; then
            # Get the value
            VALUE=$(cat "$MAP/$KEY");
            # Blast the value
            echo "$VALUE";
        else
            echo "The key doesn't exist";
            return 1;
        fi
    else
        echo "The map doesn't exist";
        return 1;
    fi
    # Unset variables
    MAP=;KEY=;VALUE=;

    return 0;
}

# @brief Remove a key/value pair from a map
# @param $1 The map path
# @param $2 The key
# @returns A message is something is wrong
# @stdout A message is something is wrong if it happens
# @exitcode 0 if nothing is wrong
# @exitcode 1 if something is wrong
# @example
#       mxpsql_shstuff_map_remove $MAP_PATH $KEY
mxpsql_shstuff_map_rem(){
    # Set variables
    MAP=$1; KEY=$2;
    # Check if the map exists
    if test -d "$MAP"; then
        # Check if the key exists
        if test -f "$MAP/$KEY"; then
            # Remove the key
            rm "$MAP/$KEY";
        else
            echo "The key doesn't exist";
            return 1;
        fi
    else
        echo "The map doesn't exist";
        return 1;
    fi
    # Unset variables
    MAP=;KEY=;

    return 0;
}

# @brief List all the keys from a map
# @param $1 The map path
# @returns A message is something is wrong, if not the list of keys as a path
# @stdout A message is something is wrong if it happens, if not the list of keys as a path
# @exitcode 0 if nothing is wrong
# @exitcode 1 if something is wrong
# @example
#       mxpsql_shstuff_map_keys $MAP_PATH
mxpsql_shstuff_map_list(){
    # Set variables
    MAP=$1;
    # Check if the map exists
    if test -d "$MAP"; then
        # List the keys in the map
        # Order the keys, separated by newlines
        # use find, sort and tail

        echo $(find "$MAP" | sort | tail -n +2);
    else
        echo "The map doesn't exist";
        return 1;
    fi
    # Unset variables
    MAP=;

    return 0;
}

# @brief Remove a map and it's keys
# @param $1 The map path
# @returns A message is something is wrong
# @stdout A message is something is wrong if it happens
# @exitcode 0 if nothing is wrong
# @exitcode 1 if something is wrong
# @example
#       mxpsql_shstuff_map_remove $MAP_PATH
mxpsql_shstuff_map_dispose(){
    # Set variables
    MAP=$1;
    # Check if the map exists
    if test -d "$MAP"; then
        # Remove the map
        rm -r "$MAP";
    else
        echo "The map doesn't exist";
        return 1;
    fi
    # Unset variables
    MAP=;KEY=;

    return 0;
}