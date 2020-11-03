    #!/bin/bash

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

    # Setting a flag which defines if the program runs or not
    is_running=true 
    declare -a cronjobs_array

    function split_cronjobs_into_array () {
        unset cronjobs_array

        # Echo current crontab into temporary file
        crontab -l > mycron

        #  Fill array with cron jobs 
        while read -r line;
        do
            cronjobs_array+=("$(echo "$line")")
        done<mycron
        rm mycron
    }

    function getMinute (){
        validation_running=true
        while $validation_running
        do
            local minute
            read minute
            if (( $minute >= 0 )) && (( $minute <= 59 )) && [[ "$minute" =~ [0-9]+$ ]];
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
            if (( $hour >= 0 )) && (( $hour <= 23 )) && [[ "$hour" =~ [0-9]+$ ]];
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
            if (( $day >= 1 )) && (( $day <= 31 )) && [[ "$day" =~ [0-9]+$ ]];
            then
                validation_running=false
            else 
                echo "Enter a valid number within the range 1-31">&2
            fi
        done
        echo $day
    }

    function getMonth (){
        month_list=("Jan" "Feb" "Mar" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
        validation_running=true
        while $validation_running
        do
            read month
            if [[ "${month_list[@]}" =~ "${month}" ]];
            then
                validation_running=false
            elif (( $month >= 1 )) && (( $month <= 12 )) && [[ "$month" =~ [0-9]+$ ]]; then
                validation_running=false
            else 
                echo "Enter a valid number within the range 1-12 OR Jan-Dec">&2
            fi
        done
        echo $month
    }

    function getDayOfWeek (){
        day_list=("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun")
        validation_running=true
        while $validation_running
        do
            read day_of_week
            if [[ "${day_list[@]}" =~ "${day_of_week}" ]];
            then
                validation_running=false
            elif (( $day_of_week >= 0 )) && (( $day_of_week <= 6 )) && [[ "$day_of_week" =~ [0-9]+$ ]]; then
                validation_running=false
            else 
                echo "Enter a valid number within the range 0-6 OR Sun-Mon">&2
            fi
        done
        echo $day_of_week
    }

    function multiple_selection (){
        pass=true
        array_of_times=()
        while $pass
        do
            echo "enter a value">&2
            value=$($1)

            if [[ "${array_of_times[@]}" =~ "${value}" ]]; then
                echo "can't duplicate value">&2
            else
                array_of_times+=("$value")
            fi

            echo "Enter 'yes' to input another value: (anything else will exit)">&2
            read response

            if [[ $response != "yes" ]]; then
                pass=false
            fi
        done
        day=$( IFS=',';echo "${array_of_times[*]}" )
        echo $day

    }

    function choose_minute (){
        # Choose minute type
        echo "1. Single specific minute"
        echo "2. Every minute (*)"
        echo "3. Every x minutes"
        echo "4. Between x and y minutes"
        echo "5. Multiple specific minute(s)"
        echo "Enter option (1-5)"

        # Check if the user enters a valid choice 1-5 otherwise loop
        validation=false
        while ! $validation;
        do
            validation=true
            read choice
            
            case $choice in 
            
                1) echo "enter a minute" 
                    minute=$(getMinute);;
                2) minute=*;;
                3) echo "Enter the frequency"
                    minute=*/$(getMinute);;
                4) echo "enter x"
                    x=$(getMinute)
                    echo "enter y"
                    y=$(getMinute)
                    minute=$x-$y;;
                5)  minute=$(multiple_selection getMinute);;            
                *) echo "invalid choice. Try Again!"
                    validation=false;;
            esac
        done
    }

    function choose_hour (){
        # Choose hour type
        echo "1. Single specific hour"
        echo "2. Every hour (*)"
        echo "3. Every x hours"
        echo "4. Between x and y hours"
        echo "5. Multiple specific hour(s)"
        echo "Enter option (1-5)"
        # Run validation to ensure the user enters 1-5 otherwise loop
        validation=false
        while ! $validation;
        do
            validation=true
            read choice

            case $choice in 
            
                1) echo "enter a hour" 
                    hour=$(getHour);;
                2) hour=*;;
                3) echo "Enter the frequency"
                    hour=*/$(getHour);;
                4) echo "enter x"
                    x=$(getHour)
                    echo "enter y"
                    y=$(getHour)
                    hour=$x-$y;;
                5) hour=$(multiple_selection getHour);;
                *) echo "invalid choice. Try Again!"
                    validation=false;;
            esac
        done
    }

    function choose_day (){
        # Choose day type
        echo "1. Single specific day"
        echo "2. Every day (*)"
        echo "3. Every x days"
        echo "4. Between x and y days"
        echo "5. Multiple specific day(s)"
        echo "Enter option (1-5)"
        # Run validation to ensure user enters 1-5 otherwise loop
        validation=false
        while ! $validation;
        do
            validation=true
            read choice

            case $choice in 
            
                1) echo "enter a day" 
                    day=$(getDay);;
                2) day=*;;
                3) echo "Enter the frequency"
                    day=*/$(getDay);;
                4) echo "enter x"
                    x=$(getDay)
                    echo "enter y"
                    y=$(getDay)
                    day=$x-$y;;
                5) day=$(multiple_selection getDay);;
                *) echo "invalid choice. Try Again!"
                    validation=false;;
            esac
        done
    }

    function choose_month (){
        # Choose month type
        echo "1. Single specific month"
        echo "2. Every month (*)"
        echo "3. Every x month(s)"
        echo "4. Between x and y months"
        echo "5. Multiple specific month(s)"
        echo "Enter option (1-5)"
        # Run validation to ensure user enter 1-5 otherwise loop
        validation=false
        while ! $validation;
        do
            validation=true
            read choice

            case $choice in 
            
                1) echo "enter a month" 
                    month=$(getMonth);;
                2) month=*;;
                3) echo "Enter the frequency"
                    month=*/$(getMonth);;
                4) echo "enter x"
                    x=$(getMonth)
                    echo "enter y"
                    y=$(getMonth)
                    month=$x-$y;;
                5) month=$(multiple_selection getMonth);;
                *) echo "invalid choice. Try Again!"
                    validation=false;;
            esac
        done
    }

    function choose_day_of_the_week (){
        # Choose day of the week type 
        echo "1. Single specific day of the week"
        echo "2. Every day of the week (*)"
        echo "3. Every x days of the week"
        echo "4. Between x and y days  of the week"
        echo "5. Multiple specific day(s) of the week"
        echo "Enter option (1-5)"

        # Run validation to ensure user enter 1-5 otherwise loop
        validation=false
        while ! $validation;
        do
            validation=true
            read choice

            case $choice in 
            
                1) echo "enter a day" 
                    day_of_week=$(getDayOfWeek);;
                2) day_of_week=*;;
                3) echo "Enter the frequency"
                    day_of_week=*/$(getDayOfWeek);;
                4) echo "enter x"
                    x=$(getDayOfWeek)
                    echo "enter y"
                    y=$(getDayOfWeek)
                    day_of_week=$x-$y;;
                5) day_of_week=$(multiple_selection getDayOfWeek);;
                *) echo "invalid choice. Try Again!"
                    validation=false;;
            esac 
        done  
    }

    function display_crontab_jobs () {
        echo "Displaying all jobs"

        split_cronjobs_into_array 

        # Display all cron jobs
        count=1
        clear
        echo -e "Key: \n* = every \n- = between \n, = specific \n/ = frequency \n"
        echo -e "# \t Min \t Hour \t Day \t Month \t DoW \t Command"
        echo "------------------------------------------------------------"
        for i in "${cronjobs_array[@]}"
        do
            i=${i//'*'/"every"}
            IFS=' ' read -ra words <<< "$i"
            echo -e "$count \t ${words[0]} \t ${words[1]} \t ${words[2]} \t ${words[3]} \t ${words[4]} \t ${words[5]} \t ${words[6]} "
            ((count=count+1))
        done  
    }

    function insert_a_job () {
        echo "Insert a job"

        # Run various function to return the periodicity
        choose_minute

        choose_hour

        choose_day

        choose_month

        choose_day_of_the_week

        # Command to be executed
        echo "Enter a command:"

        read job_command

        crontab -l > mycron
        # Echo new cron into cron file
        echo "$minute $hour $day $month $day_of_week $job_command" >> mycron
        #install new cron file
        crontab mycron  
        rm mycron
    }

    function edit_a_job () {
    
        echo "Which job would you like to edit?"
        
        split_cronjobs_into_array 
        display_crontab_jobs  

        # Run validation to ensure the user enter a valid job to edit
        valid_job_number=false
        while ! $valid_job_number;
        do
            echo "Enter job number (1-x)"

            # Choose a job to edit and check if it's valid
            read choice

            if (( $choice > ${#cronjobs_array[@]} )) || (( $choice < 1 )) ; then
                echo "enter a valid job"
            else
                valid_job_number=true
            fi
        done

        # Store the job to edit into a new array
        ((choice=choice-1))
        IFS=' ' read -ra cronjob_to_edit <<< "${cronjobs_array[$choice]}"
        # Remove job from array of all jobs 
        for target in "${cronjobs_array[$choice]}"; do
            for i in "${!cronjobs_array[@]}"; do
                if [[ ${cronjobs_array[i]} = $target ]]; then
                    unset 'cronjobs_array[i]'
                fi
            done
        done

        # Chose what to edit in the job
        echo "What would you like to edit?"
        echo "1. Minute"
        echo "2. Hour"
        echo "3. Day"
        echo "4. Month"
        echo "5. Day of the week"
        echo "Enter option (1-5)"
        # Input validation: Ensure the user enter 1-5 otherwise loop
        validation=false
        while ! $validation;
        do
            validation=true
            read decision
            ((index=decision-1))

            unset cronjob_to_edit[$index]

            case $decision in 
            
                1) choose_minute 
                    cronjob_to_edit[0]=$minute;;
                2) choose_hour 
                    cronjob_to_edit[1]=$hour;;
                3) choose_day 
                    cronjob_to_edit[2]=$day;;
                4) choose_month 
                    cronjob_to_edit[3]=$month;;
                5) choose_day_of_the_week
                    cronjob_to_edit[4]=$day_of_week;;
                *) echo "invalid choice. Try Again!"
                    validation=false;;
            esac  
        done

        # Store the edited cronjob back into the array of all jobs
        cronjobs_array+=("${cronjob_to_edit[0]} ${cronjob_to_edit[1]} ${cronjob_to_edit[2]} ${cronjob_to_edit[3]} ${cronjob_to_edit[4]} ${cronjob_to_edit[5]}")

        # Store edited jobs array into mycron then crontab
        printf "%s\n" "${cronjobs_array[@]}" > mycron
        crontab mycron
        rm mycron
    }

    function remove_a_job () {
        echo "Remove a job"

        split_cronjobs_into_array   

        echo "Enter job (1-x)"

        # Read the user's input and remove the indexed job from the array
        read choice
        ((choice=choice-1))

        for target in "${cronjobs_array[$choice]}"; do
            for i in "${!cronjobs_array[@]}"; do
                if [[ ${cronjobs_array[i]} = $target ]]; then
                    unset 'cronjobs_array[i]'
                fi
            done
        done
        # Store cronjobs into temp file then crontab
        printf "%s\n" "${cronjobs_array[@]}" > mycron
        crontab mycron
        rm mycron
    }

    function remove_all_jobs () {
        echo "Remove all jobs"
        crontab -r
    }

    function exit_app () {
        echo "Exiting..."
        is_running=false
    }

    # Program start point
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
        echo ""

        # Invoking a function based on the provided user's choice
        case $choice in 
            1) display_crontab_jobs;;
            2) insert_a_job;;
            3) edit_a_job;;
            4) remove_a_job;;
            5) remove_all_jobs;;
            9) exit_app;;
            *) echo "Invalid choice. Try again!";;
        esac
    done    
