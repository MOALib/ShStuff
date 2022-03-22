#!/bin/sh
# @name config.sh
# @file config.sh
# @author MXPSQL
# @brief A library that provides a config file parsing library
# This is a library that provides a config file parsing library

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

# @brief Parses a config string
# @param $1 The config string
# @param $2 The config key to get
# @returns The config value
# @stdout The config value
# @exitcode 0 nothing wrong, successful parsing
# @exitcode 1 config key not found
# 
# @example
#       echo $(mxpsql_shstuff_config "key1=value1\nkey2=value2\nkey3=value3" "key2")
mxpsql_shstuff_config_parse_str(){
    # set variables
    config_str="$1";
    config_key="$2";

    # get the value
    config_value=$(echo "$config_str" | grep -oP "(?<=^$config_key=).*");

    if test $? -ne 0; then
        echo "";
        return 1;
    fi    

    # return the value
    echo "$config_value";

    # unset variables
    config_str=;
    config_key=;
    config_value=;

    return 0;
}

# @brief Parses a config file
# @param $1 The config file
# @param $2 The config key to get
# @returns The config value
# @stdout The config value
# @exitcode 0 nothing wrong, successful parsing
# @exitcode 1 config key not found
# @exitcode 2 config file not found
#
# @example
#       echo $(mxpsql_shstuff_config "config.txt" "key2")
mxpsql_shstuff_config_parse_file(){
    # set variables
    config_file="$1";
    config_key="$2";

    # check if the file exists
    if ! test -f "$config_file"; then
        echo "File $config_file does not exist";
        return 2;
    fi

    # parse config
    if mxpsql_shstuff_config_parse_str "$(cat "$config_file")" "$config_key"; then
        # return the value
        echo "$config_value";
    else
        # return nothing
        echo "";
        return 1;
    fi

    # unset variables
    config_file=;
    config_key=;
    config_value=;

    return 1;
}