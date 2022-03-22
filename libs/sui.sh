#!/bin/sh
# @name sui.sh
# @file sui.sh
# @author MXPSQL
# @brief A simple user interface library, very simple
# This is a library that provides some simple user interface functions (colors, terminal sizes, etc)

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


# Terminal controls

# @brief get terminal size
# @noargs
# @return as variables LINES and COLUMNS
# @example
#       mxpsql_shstuff_sui_get_terminal_size
#       echo "Lines: $LINES"
#       echo "Columns: $COLUMNS"
mxpsql_shstuff_sui_term_get_size(){
    # Get terminal size ('stty' is POSIX and always available).
    # This can't be done reliably across all bash versions in pure bash.
    STTY=$(stty size);
    LINES=$(echo "$STTY" | cut -d ' ' -f 1);
    COLUMNS=$(echo "$STTY" | cut -d ' ' -f 2);
    # Unset variables
    STTY=;
}

# @brief show or hide cursor
# @param $1 true to show, false to hide
# @example
#       mxpsql_shstuff_sui_show_cursor true
mxpsql_shstuff_sui_term_cursor_visible(){
    # Show or hide cursor
    if test "$1" = true; then
        printf '\e[?25h';
    else
        printf '\e[?25l';
    fi
}

# @brief Move the cursor to a position
# @param $1 line
# @param $2 column
# @example
#       mxpsql_shstuff_sui_term_cursor_move_goto 5 10
mxpsql_shstuff_sui_term_cursor_move_goto(){
    # Set variables
    LINE=$1;
    COLUMN=$2;

    if test -z "$LINE"; then
        LINE=0;
    fi

    if test -z "$COLUMN"; then
        COLUMN=0;
    fi

    # Move cursor to a specific position
    printf '\e[%s;%sH' "$LINE" "$COLUMN";

    # Unset variables
    LINE=;
    COLUMN=;
}

# @brief Move the cursor vertically
# @param $1 true for up, false for down
# @param $2 how much to move?
# @example
#       mxpsql_shstuff_sui_term_cursor_move_line true 5
mxpsql_shstuff_sui_term_cursor_move_line(){
    if test "$1" = true; then
        printf '\e[%sA' "$2";
    else
        printf '\e[%sB' "$2";
    fi
}

# @brief Move the cursor horizontally
# @param $1 true for left, false for right
# @param $2 how much to move?
# @example
#       mxpsql_shstuff_sui_term_cursor_move_column true 5
mxpsql_shstuff_sui_term_cursor_move_column(){
    if test "$1" = true; then
        printf '\e[%sC' "$2";
    else
        printf '\e[%sD' "$2";
    fi
}

# @brief Move cursor to bottom
# @noargs
# @example
#       mxpsql_shstuff_sui_term_cursor_move_bottom
mxpsql_shstuff_sui_term_cursor_goto_bottom(){
    mxpsql_shstuff_sui_term_get_size;
    printf '\e[%sH' "$LINES";
}

# @brief enable or disable line wrapping
# @param $1 true to enable, false to disable
# @example
#       mxpsql_shstuff_sui_line_wrap true
mxpsql_shstuff_sui_term_linewrap(){
    if test "$1" = true; then
        printf '\e[?7h';
    else
        printf '\e[?7l';
    fi
}

# @brief set the scroll limit
# @param $1 the first point, empty to set to default
# @param $2 the last point, empty to set to default
# @example
#       mxpsql_shstuff_sui_scroll_limit 1 10
#       mxpsql_shstuff_sui_scroll_limit
mxpsql_shstuff_sui_term_scroll_limit(){
    if test -z "$1" && test -z "$2"; then
        printf '\e[%s;%sr' "$1" "$2";
    else
        printf '\e[r';
    fi
}

# @brief Clear the screen
# @param $1 mimic the clear command by setting the cursor to 0, 0?
# @example
#       mxpsql_shstuff_sui_term_clear true
#       mxpsql_shstuff_sui_term_clear
mxpsql_shstuff_sui_term_clear(){
    if test "$1" = true; then
        printf '\e[2J\e[H';
    else
        printf '\e[2J';
    fi
}


# widgets

# @brief print a line as long as the terminal's width
# @param $1 the character to use
# @example
#       mxpsql_shstuff_sui_widget_line '-'
mxpsql_shstuff_sui_widget_line(){
    # print a charcter of choice as much as the terminal's width
    printf '%*s' "${COLUMNS:-$(tput cols)}" '' | tr ' ' "$1";
}

# @brief print a text bar
# @param $@ the text to print
# @example
#       mxpsql_shstuff_sui_widget_textbar "This is a text bar"
mxpsql_shstuff_sui_widget_textbar(){
    mxpsql_shstuff_sui_widget_line "#";
    echo "$@";
    mxpsql_shstuff_sui_widget_line "#";
}