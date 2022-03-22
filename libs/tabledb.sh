#!/bin/sh
# @name tabledb.sh
# @file tabledb.sh
# @author MXPSQL
# @brief A library that provides a wide column database
# This is a library that provides a wide column database, just like google's bigtable, in an ini based format.
# Not production ready!

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

# @brief Creates a new instance
# @param $1 The filename of the instance
# @stdout If there is a problem
# @exitcode 0 if successful
# @exitcode1 if not
# @usage 
#       mxpsql_shstuff_tabledb_instance_new "my_instance.tdb"
mxpsql_shstuff_tabledb_instane_new(){
    # set variables
    TABLE_DB_NAME="$1";

    # check if the database instance exists
    if test -f "$TABLE_DB_NAME"; then
        echo "The database instance already exists.";
        TABLE_DB_NAME=;
        return 1;
    fi

    # create the database instance
    touch "$TABLE_DB_NAME";

    # unset variables
    TABLE_DB_NAME=;

    return 0;
}

# @brief Deletes an instance
# @param $1 The filename of the instance
# @stdout if not successful
# @exitcode 0 if successful
# @exitcode 1 if not
# @usage
#       mxpsql_shstuff_tabledb_instance_delete "my_instance.tdb"
mxpsql_shstuff_tabledb_instance_dispose(){
    # set variables
    TABLE_DB_NAME="$1";

    # check if the database instance exists
    if ! test -f "$TABLE_DB_NAME"; then
        echo "The database instance does not exist.";
        TABLE_DB_NAME=;
        return 1;
    fi

    # dispose the database instance
    rm "$TABLE_DB_NAME";

    # unset variables
    TABLE_DB_NAME=;

    return 0;
}


# @brief Adds a new column to the database
# @param $1 The filename of the instance
# @param $2 The name of the column
# @stdout if not successful
# @exitcode 0 if successful
# @exitcode 1 if not
# @usage
#       mxpsql_shstuff_tabledb_column_add "my_instance.tdb" "my_column"
mxpsql_shstuff_tabledb_column_new(){
    # Set variables
    TABLE_DB_NAME="$1";
    TABLE_DB_COLUMN_NAME="$2";

    # check if the database instance exists
    if ! test -f "$TABLE_DB_NAME"; then
        echo "The database instance does not exist.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        return 1;
    fi

    # check if the column name is empty
    if test -z "$TABLE_DB_COLUMN_NAME"; then
        echo "The column name is empty.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        return 1;
    fi

    # grep the column and see if it is used
    grep -q "\[$TABLE_DB_COLUMN_NAME\]" "$TABLE_DB_NAME";

    # check if the column is used
    if test $? -eq 0; then
        echo "The column is already used.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        return 1;
    fi

    # add the column to the database
    echo "[$TABLE_DB_COLUMN_NAME]" >> "$TABLE_DB_NAME";

    # unset variables
    TABLE_DB_NAME=;
    TABLE_DB_COLUMN_NAME=;

    return 0;
}

# @brief Checks if a column exists
# @param $1 The filename of the instance
# @param $2 The name of the column
# @stdout message info
# @exitcode 0 exists
# @exitcode 1 does not exist
# @exitcode 2 if not successful
# @usage
#       if mxpsql_shstuff_tabledb_column_exists "my_instance.tdb" "my_column"; then ... fi
mxpsql_shstuff_tabledb_column_exists(){
    # Set variables
    TABLE_DB_NAME="$1";
    TABLE_DB_COLUMN_NAME="$2";

    # check if the database instance exists
    if ! test -f "$TABLE_DB_NAME"; then
        echo "The database instance does not exist.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        return 2;
    fi

    # check if the column name is empty
    if test -z "$TABLE_DB_COLUMN_NAME"; then
        echo "The column name is empty.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        return 2;
    fi

    # grep the column and see if it is used
    grep -q "\[$TABLE_DB_COLUMN_NAME\]" "$TABLE_DB_NAME";

    # check if the column is used
    if test $? -eq 0; then
        echo "The column exists.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        return 0;
    else
        echo "The column does not exist.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        return 1;
    fi
}

# @brief Deletes a column from the database
# @param $1 The filename of the instance
# @param $2 The name of the column
# @stdout if not successful
# @exitcode 0 if successful
# @exitcode 1 if not
# @usage
#       mxpsql_shstuff_tabledb_column_delete "my_instance.tdb" "my_column"
mxpsql_shstuff_tabledb_column_delete(){
    # Set variables
    TABLE_DB_NAME2="$1";
    TABLE_DB_COLUMN_NAME2="$2";

    # check if the database instance exists
    if ! test -f "$TABLE_DB_NAME2"; then
        echo "The database instance does not exist.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        return 1;
    fi

    # check if the column name is empty
    if test -z "$TABLE_DB_COLUMN_NAME2"; then
        echo "The column name is empty.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME2=;
        return 1;
    fi

    # check if the column exists
    grep -q "\[$TABLE_DB_COLUMN_NAME\]" "$TABLE_DB_NAME";
    if test $? -eq 0; then
        # remove the column from the database
        sed -i "/\[$TABLE_DB_COLUMN_NAME2\]/d" "$TABLE_DB_NAME2";
    else
        echo "The column does not exist.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME2=;
        return 1;
    fi

    # unset variables
    TABLE_DB_NAME2=;
    TABLE_DB_COLUMN_NAME2=;

    return 0;
}

mxpsql_shstuff_tabledb_row_set(){
    # Set variables
    TABLE_DB_NAME="$1";
    TABLE_DB_COLUMN_NAME="$2";
    TABLE_DB_ROW_NAME="$3";
    TABLE_DB_ROW_VALUE="$4";

    # check if the database instance exists
    if ! test -f "$TABLE_DB_NAME"; then
        echo "The database instance does not exist.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        TABLE_DB_ROW_NAME=;
        TABLE_DB_ROW_VALUE=;
        return 1;
    fi

    # check if the column name is empty
    if test -z "$TABLE_DB_COLUMN_NAME"; then
        echo "The column name is empty.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        TABLE_DB_ROW_NAME=;
        TABLE_DB_ROW_VALUE=;
        return 1;
    fi

    # check if the row name is empty
    if test -z "$TABLE_DB_ROW_NAME"; then
        echo "The row name is empty.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        TABLE_DB_ROW_NAME=;
        TABLE_DB_ROW_VALUE=;
        return 1;
    fi

    # check if the row value is empty
    if test -z "$TABLE_DB_ROW_VALUE"; then
        echo "The row value is empty.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        TABLE_DB_ROW_NAME=;
        TABLE_DB_ROW_VALUE=;
        return 1;
    fi

    # check if the column exists
    grep -q "\[$TABLE_DB_COLUMN_NAME\]" "$TABLE_DB_NAME";

    if test $? -eq 0; then
        # check if the row name exists in that column
        # key=value
        grep -q "\[$TABLE_DB_COLUMN_NAME\]\s*$TABLE_DB_ROW_NAME" "$TABLE_DB_NAME";

        if test $? -eq 0; then
            # delete the key and value
            sed -i "/\[$TABLE_DB_COLUMN_NAME\]\s*$TABLE_DB_ROW_NAME/d" "$TABLE_DB_NAME";
        fi

        sed -i "s/\[$TABLE_DB_ROW_NAME\]\s*=\s*.*/$TABLE_DB_ROW_NAME\s*=\s*$TABLE_DB_ROW_VALUE/" "$TABLE_DB_NAME";
    else
        echo "The column does not exist.";
        TABLE_DB_NAME=;
        TABLE_DB_COLUMN_NAME=;
        TABLE_DB_ROW_NAME=;
        TABLE_DB_ROW_VALUE=;
        return 1;
    fi
}