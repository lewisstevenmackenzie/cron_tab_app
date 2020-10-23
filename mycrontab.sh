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


function display_cronetab_jobs () {
    echo "Displaying all jobs..."
    # This command lists all the records
    crontab -l

}

function insert_a_job () {
    echo "Type or paste your job in the correct format"
    # We read the job the user provides
    read new_job

    # We use a pipe to open the current list of jobs, we print it and add the new record
    # Then we take all the printed text and then we add it to the crontab file
    crontab -l | { cat; echo "$new_job"; } | crontab -
}

function edit_a_job () {
    echo "Type or paste the job you want to update"
    # We read the job the user wants to update
    read job_to_update

    echo "Type or paste the updated version of the job"
    # We get the uploaded version
    read updated_job

    # We delete the job using the same pipe as we used in the remove_a_job function
    crontab -l | grep -Fxv "$job_to_update" | crontab -
    #We add the  updated job provided by the user
    crontab -l | { cat; echo "$updated_job"; } | crontab -
}

function remove_a_job () {
    echo "Type or paste the job you want to delete in the correct format"
    read job_to_delete

    # We list the jobs, use grep all but the job that should be deleted and write it back to the file
    crontab -l | grep -Fxv "$job_to_delete" | crontab -
}


function remove_all_jobs () {
    echo "Removing all jobs..."
    # This command removes all the records
    crontab -r
}


function exit_app () {
    echo "Exiting..."
    #We change the flag so the program stops running
    is_running=false
}

# If the flag is set to 'true' the loop runs asking for commands
while $is_running
do
    # Printing out the options menu
    echo "1 . Display crontab jobs"
    echo "2 . Insert a job"
    echo "3 . Edit a job"
    echo "4 . Remove a job"
    echo "5 . Remove all jobs"
    echo "9 . Exit" 


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


