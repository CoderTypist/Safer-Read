#!/bin/bash

# Receives variable name
# Variable's contents are "trimmed" if an unsafe character is found
#
# USAGE:
#     read someVariable
#     strim someVariable
#
# EXAMPLE:
#     >> tvShow="Drake&Josh"
#     >> strim tvShow
#     >> echo "$tvShow"
#     Drake
#

strim(){
    
    # stores the received text
    oldCmd="${!1}"
    newCmd=""
    
    # loops through oldCmd letter by letter
    for(( iCmd=0 ; iCmd<${#oldCmd} ; iCmd++ )); do
        
        charCmd=${oldCmd:$iCmd:1}
        
        if [ "$charCmd" != "'" ] && \
           [ "$charCmd" != ';' ] && \
           [ "$charCmd" != '&' ] && \
           [ "$charCmd" != '|' ] && \
           [ "$charCmd" != '`' ] ; then
            
            # appends safe characters to newCmd
            newCmd="$newCmd$charCmd"
        
        # if an unsafe character was encountered
        # break and do not add it to newCmd
        else
            break
        fi

    done
    
    # sets a global variable
    # overrides the value in the calling function
    declare -g "$1=$newCmd"
}

# Receives variable name
# User is prompted for input if message was received as a parameter
# strim() is called to "trim" input
#
# USAGE:
#     sread someVariable
#
# EXAMPLES:
#
# NO PROMPT RECEIVED:
#     >> sread fileToMove
#     userInput;fromKeyboard
#     >> echo fileToMove
#     userInput
#
# PROMPT RECEIVED:
#    >> sread faveFood "What is your favorite food?"
#    pizza;cat file.txt
#    >> echo "$faveFood"
#    pizza
#

sread(){
    
    # prints prompt message if one was received
    if [ ! -z "$2" ] ; then
        echo "$2"
    fi
    
    # gets user input
    read "$1"
    # trims user input
    strim "$1"
}
