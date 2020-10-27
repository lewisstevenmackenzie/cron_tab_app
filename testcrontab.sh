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
    echo "Displaying all jobs"
    crontab -l
}

#TODO
function insert_a_job () {
    echo "Insert a job"

    # Choose minutes
    echo "1. Single specific minute"
    echo "2. Every minute (*)"
    echo "3. Every x minutes"
    echo "4. Between x and y minutes"
    echo "5. Multiple specific minute(s)"
    echo "Enter option (1-5)"
    minute=5
    read choice
    
    case $choice in 
    
        1) echo "enter a minute" 
            read minute;;
        2) minute=*;;
        3) echo "Enter the frequency"
            read minute
            minute=*/$minute;;
        4) echo "enter x"
            read x
            echo "enter y"
            read y
            minute=$x-$y;;
        5) #FUCK OFFFFFFF
            ;;
        *) echo "invalid choice. Try Again!";;
    esac

    # Choose hours
    echo "1. Single specific hour"
    echo "2. Every hour (*)"
    echo "3. Every x hours"
    echo "4. Between x and y hours"
    echo "5. Multiple specific hour(s)"
    echo "Enter option (1-5)"

    read choice

    case $choice in 
    
        1) echo "enter a hour" 
            read hour;;
        2) hour=*;;
        3) echo "Enter the frequency"
            read hour
            hour=*/$hour;;
        4) echo "enter x"
            read x
            echo "enter y"
            read y
            hour=$x-$y;;
        5) #FUCK OFFFFFFF
            ;;
        *) echo "invalid choice. Try Again!";;
    esac

    # Choose days
    echo "1. Single specific day"
    echo "2. Every day (*)"
    echo "3. Every x days"
    echo "4. Between x and y days"
    echo "5. Multiple specific day(s)"
    echo "Enter option (1-5)"

    read choice

    case $choice in 
    
        1) echo "enter a day" 
            read day;;
        2) day=*;;
        3) echo "Enter the frequency"
            read day
            day=*/$minute;;
        4) echo "enter x"
            read x
            echo "enter y"
            read y
            day=$x-$y;;
        5) #FUCK OFFFFFFF
            ;;
        *) echo "invalid choice. Try Again!";;
    esac

    # Choose months
    echo "1. Single specific month"
    echo "2. Every month (*)"
    echo "3. Every x month(s)"
    echo "4. Between x and y months"
    echo "5. Multiple specific month(s)"
    echo "Enter option (1-5)"

    read choice

    case $choice in 
    
        1) echo "enter a month" 
            read month;;
        2) month=*;;
        3) echo "Enter the frequency"
            read month
            month=*/$minute;;
        4) echo "enter x"
            read x
            echo "enter y"
            read y
            month=$x-$y;;
        5) #FUCK OFFFFFFF
            ;;
        *) echo "invalid choice. Try Again!";;
    esac

    # Command
    echo "Enter a command:"

    read input

    #write out current crontab
    crontab -l > mycron
    #echo new cron into cron file
    echo "$minute $hour $day $month * $input" >> mycron
    #install new cron file
    crontab mycron  
    rm mycron
 }

#TODO
function edit_a_job () {
    echo "Edit a job"

    # Printing out the options menu
    echo "Which job would you like to edit?"
    echo "list of jobs"
    echo "Enter job (1-x)"

    # Reading the user's input and storing it
    read choice

    # Invoking a function based on the provided user's choice
    case $choice in 
        1) display_cronetab_jobs;;

        *) echo "Invalid choice. Try again!";;
    esac
}

#TODO
function remove_a_job () {
    echo "Remove a job"
}

function remove_all_jobs () {
    echo "Remove all jobs"
    crontab -r
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
