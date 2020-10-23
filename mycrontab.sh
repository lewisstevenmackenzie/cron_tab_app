#! /bin/bash

# CSN08116 Operating Systems - Coursework (mycrontab)
# --------------------------------------------------
# Version 0.1
# --------------------------------------------------
# Group 39
# --------------------------------------------------
# Authors:
# * Albert Hadacek
# * Lewis Mackenzie
# * Ewan Robertson
# --------------------------------------------------
# License: MIT

# Setting a flag which defines if the program runs or not
is_running=true 

#TODO
function display_cronetab_jobs () {
    echo "Display jobs"
}

#TODO
function insert_a_job () {
    echo "Insert a job"
}

#TODO
function edit_a_job () {
    echo "Edit a job"
}

#TODO
function remove_a_job () {
    echo "Remove a job"
}

#TODO
function remove_all_jobs () {
    echo "Remove all jobs"
}

# Done (Albert, 23.10.)
function exit_app () {
    echo "Exiting..."
    is_running=false
}

# If the flag is set to 'true' the loop runs asking for commands
while $is_running
do
# Printing out the options menu
cat << END_TEXT
1 . Display crontab jobs
2 . Insert a job
3 . Edit a job
4 . Remove a job
5 . Remove all jobs
9 . Exit 
END_TEXT

# Reading the user's input and storing it
read choice

# Invoking a function based on the provided user's choice
case $choice in 
1) display_cronetab_jobs;;
2) insert_a_job;;
3) edit_a_job;;
4) remove_a_job;;
5) remove_all_jobs;;
9) exit_app;;
*) echo "Invalid choice. Try again!";;
esac

done    
