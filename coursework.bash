function getMinute (){

    validation_running=true
    while $validation_running
    do
		local minute
        read minute
        if (( $minute >= 0 )) && (( $minute <= 59 ))
        then
            validation_running=false
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
        fi
    done

    echo $hour

}

function getDay (){

    validation_running=true
    while $validation_running
    do
        read day
        if (( $day >= 0 )) && (( $day <= 31	 ))
        then
            validation_running=false
        fi
    done

    echo $day
}

function getDayOfWeek (){

	daylist=("Mon" "Tue" "Wed" "Thu" "Fri" "Sat" "Sun")
    validation_running=true
    while $validation_running
    do
        read dayofweek
        if [[ "${array[@]}" =~ "${dayofweek}"]]
        then
            validation_running=false
		elif (( $dayofweek >= 0 )) && (( $dayofweek <= 6))
			validation_running=false
        fi
    done

    echo $dayofweek
}

function getMonth (){

	monthlist=("Jan" "Feb" "Mar" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
    validation_running=true
    while $validation_running
    do
        read month
        if [[ "${array[@]}" =~ "${dayofweek}"]]
        then
            validation_running=false
		elif (( $month >= 1 )) && (( $day <= 12 ))
			validation_running=false
        fi
    done

    echo $month
}