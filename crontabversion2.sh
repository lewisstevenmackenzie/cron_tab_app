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

function choose_minute (){
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
       
        5)  pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                read value

                echo "Enter another value? (y/n)"
                read response

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                if [[ $response == "n" ]]; then
                pass=false
                fi
            done
            minute=$( IFS=$',';echo "${array_of_times[*]}" );;
    
        *) echo "invalid choice. Try Again!";;
    esac

}

function choose_hour (){

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
        5) pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                read value

                echo "Enter another value? (y/n)"
                read response

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                if [[ $response == "n" ]]; then
                pass=false
                fi
            done
            hour=$( IFS=$',';echo "${array_of_times[*]}" );;
        *) echo "invalid choice. Try Again!";;
    esac
}

function choose_day (){

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
            day=*/$day;;
        4) echo "enter x"
            read x
            echo "enter y"
            read y
            day=$x-$y;;
        5) pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                read value

                echo "Enter another value? (y/n)"
                read response

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                if [[ $response == "n" ]]; then
                pass=false
                fi
            done
            day=$( IFS=$',';echo "${array_of_times[*]}" );;
        *) echo "invalid choice. Try Again!";;
    esac
}

function choose_month (){

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
        5) pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                read value

                echo "Enter another value? (y/n)"
                read response

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                if [[ $response == "n" ]]; then
                pass=false
                fi
            done
            month=$( IFS=$',';echo "${array_of_times[*]}" );;
        *) echo "invalid choice. Try Again!";;
    esac

}

function choose_day_of_the_week (){
    # Choose day of the week
    echo "1. Single specific day of the week"
    echo "2. Every day of the week (*)"
    echo "3. Every x days of the week"
    echo "4. Between x and y days  of the week"
    echo "5. Multiple specific day(s) of the week"
    echo "Enter option (1-5)"

    read choice

    case $choice in 
    
        1) echo "enter a day" 
            read day_of_week;;
        2) day_of_week=*;;
        3) echo "Enter the frequency"
            read day_of_week
            day_of_week=*/$day_of_week;;
        4) echo "enter x"
            read x
            echo "enter y"
            read y
            day_of_week=$x-$y;;
        5) pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                read value

                echo "Enter another value? (y/n)"
                read response

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                if [[ $response == "n" ]]; then
                pass=false
                fi
            done
            day_of_week=$( IFS=$',';echo "${array_of_times[*]}" );;
        *) echo "invalid choice. Try Again!";;
    esac   
}

function display_cronetab_jobs () {
    echo "Displaying all jobs"
    crontab -l > mycron
    declare -a array
    while read -r line;
    do
        array+=("$(echo "$line")")
    done<mycron

    for i in "${array[@]}"
        do
            echo "$i"
        done
    rm mycron

}

function insert_a_job () {
    echo "Insert a job"

    choose_minute

    choose_hour

    choose_day

    choose_month

    choose_day_of_the_week

    # Command to be executed
    echo "Enter a command:"

    read input

    #write out current crontab
    crontab -l > mycron
    #echo new cron into cron file
    echo "$minute $hour $day $month $day_of_week $input" >> mycron
    #install new cron file
    crontab mycron  
    rm mycron
 }

function edit_a_job () {
  
    # Printing out the options menu
    echo "Which job would you like to edit?"
    
    crontab -l > mycron
    declare -a array

    while read -r line;
    do
        array+=("$(echo "$line")")
    done<mycron
    count=1

    for i in "${array[@]}"
        do
            echo "$count. $i"
            ((count=count+1))
        done

    echo "Enter job (1-x)"

    # Reading the user's input and storing it
    read choice
    ((choice=choice-1))
    
    IFS=' ' read -ra jobarray <<< "${array[$choice]}"

    for target in "${array[$choice]}"; do
        for i in "${!array[@]}"; do
            if [[ ${array[i]} = $target ]]; then
                unset 'array[i]'
            fi
        done
    done

    #Edit job number from array
    echo "What would you like to edit?"
    echo "1. Minute"
    echo "2. Hour"
    echo "3. Day"
    echo "4. Month"
    echo "5. Day of the week"
    echo "Enter option (1-5)"

    read decision
    ((edit=decision-1))

    unset jobarray[$edit]

    case $decision in 
    
        1) choose_minute 
            jobarray[0]=$minute;;
        2) choose_hour 
            jobarray[1]=$hour;;
        3) choose_day 
            jobarray[2]=$day;;
        4) choose_month 
            jobarray[3]=$month;;
        5) choose_day_of_the_week
            jobarray[4]=$day_of_week;;
        *) echo "invalid choice. Try Again!";;

    esac  

    array+=("${jobarray[0]} ${jobarray[1]} ${jobarray[2]} ${jobarray[3]} ${jobarray[4]} ${jobarray[5]}")

    rm mycron

    count=1
    for i in "${array[@]}"
        do
            echo "$count. $i"
            ((count=count+1))
        done

    printf "%s\n" "${array[@]}" > mycron
    crontab mycron
    rm mycron
}

#TODO
function remove_a_job () {
    echo "Remove a job"

    crontab -l > mycron
    declare -a array

    while read -r line;
    do
        array+=("$(echo "$line")")
    done<mycron
    count=1

    for i in "${array[@]}"
        do
            echo "$count. $i"
            ((count=count+1))
        done

    echo "Enter job (1-x)"

    # Reading the user's input and storing it
    read choice
    ((choice=choice-1))

    for target in "${array[$choice]}"; do
        for i in "${!array[@]}"; do
            if [[ ${array[i]} = $target ]]; then
                unset 'array[i]'
            fi
        done
    done

    rm mycron
    printf "%s\n" "${array[@]}" > mycron
    crontab mycron
    rm mycron
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

