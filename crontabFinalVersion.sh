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

function getMinute (){
    validation_running=true
    while $validation_running
    do
		local minute
        read minute
        if (( $minute >= 0 )) && (( $minute <= 59 ))
        then
            validation_running=false
        else 
            echo "Enter a valid number within the range 0-59">&2
        fi
    done

    echo $minute
}

function getHour (){
    validation_running=true
    while $validation_running
    do
        read hour
        if (( $hour >= 0 )) && (( $hour <= 23 ))
        then
            validation_running=false
        else 
            echo "Enter a valid number within the range 0-23">&2
        fi
    done

    echo $hour
}

function getDay (){

    validation_running=true
    while $validation_running
    do
        read day
        if (( $day >= 1 )) && (( $day <= 31	 ))
        then
            validation_running=false
        else 
            echo "Enter a valid number within the range 1-31">&2
        fi
    done

    echo $day
}

function getMonth (){

	monthlist=("Jan" "Feb" "Mar" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
    validation_running=true
    while $validation_running
    do
        read month
        if [[ "${array[@]}" =~ "${monthlist}" ]]
        then
            validation_running=false
		elif (( $month >= 1 )) && (( $month <= 12 )); then
			validation_running=false
        else 
            echo "Enter a valid number within the range 1-12 OR Jan-Dec">&2
        fi
    done

    echo $month
}

function getDayOfWeek (){

	daylist=("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun")
    validation_running=true
    while $validation_running
    do
        read dayofweek
        if [[ "${array[@]}" =~ "${dayofweek}" ]];
        then
            validation_running=false
		elif (( $dayofweek >= 0 )) && (( $dayofweek <= 6 )); then
			validation_running=false
        else 
            echo "Enter a valid number within the range 0-6 OR Sun-Mon">&2
        fi
    done

    echo $dayofweek
}

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
            minute=$(getMinute);;
        2) minute=*;;
        3) echo "Enter the frequency"
            minute=$(getMinute)
            minute=*/$minute;;
        4) echo "enter x"
            x=$(getMinute)
            echo "enter y"
            y=$(getMinute)
            minute=$x-$y;;
        5)  pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                value=$(getMinute)

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi
                
                echo "Enter another value? (y/n)"
                read response

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
            hour=$(getHour);;
        2) hour=*;;
        3) echo "Enter the frequency"
            hour=$(getHour)
            hour=*/$hour;;
        4) echo "enter x"
            x=$(getHour)
            echo "enter y"
            y=$(getHour)
            hour=$x-$y;;
        5) pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                value=$(getHour)

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                echo "Enter another value? (y/n)"
                read response

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
            day=$(getDay);;
        2) day=*;;
        3) echo "Enter the frequency"
            day=$(getDay)
            day=*/$day;;
        4) echo "enter x"
            x=$(getDay)
            echo "enter y"
            y=$(getDay)
            day=$x-$y;;
        5) pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                value=$(getDay)

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                echo "Enter another value? (y/n)"
                read response

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
            month=$(getMonth);;
        2) month=*;;
        3) echo "Enter the frequency"
            month=$(getMonth)
            month=*/$minute;;
        4) echo "enter x"
            x=$(getMonth)
            echo "enter y"
            y=$(getMonth)
            month=$x-$y;;
        5) pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                value=$(getMonth)

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                echo "Enter another value? (y/n)"
                read response

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
            day_of_week=$(getDayOfWeek);;
        2) day_of_week=*;;
        3) echo "Enter the frequency"
            day_of_week=$(getDayOfWeek)
            day_of_week=*/$day_of_week;;
        4) echo "enter x"
            x=$(getDayOfWeek)
            echo "enter y"
            y=$(getDayOfWeek)
            day_of_week=$x-$y;;
        5) pass=true
            array_of_times=()
            while $pass
            do
                echo "enter a value">&2
                value=$(getDayOfWeek)

                if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                    echo "can't duplicate value">&2
                else
                array_of_times+=("$value")
                fi

                echo "Enter another value? (y/n)"
                read response

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

    validjobnum=true
    while $validjobnum;
    do
        echo "Enter job (1-x)"

        # Reading the user's input and storing it
        read choice

        if (( $choice > ${#array[@]} )) || (( $choice < 1 )) ; then
            echo "enter a valid job"
        else
            validjobnum=false
        fi
    done

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