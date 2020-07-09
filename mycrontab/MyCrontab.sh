#!/bin/sh

#A draft menu for the OS system crontab course work
#version: 2.5

#FUNCTION TO LIST ALL CRON JOBS

list_jobs() {
    file1=/home/$(whoami)/cron.tmp #temporary file for formatting the display
    file=/var/spool/cron/crontabs/$(whoami) #variable for crontab file location
    if [ -f  "$file" ]; then
        if [ -s "$file" ]; then #if statments to test that the crontab file exists and isn't empty
            echo
            sed "s/*/every/g" $file > $file1 #replaces all the '*' with every
            disp="\e[92mminute(s) hour(s) day(s)_of_month month(s) day(s)_of_week Job&ID ${IFS}\e[0m" #column headers to make crontab display more user friendly
            var1=$(cat $file1) #Formats crontab file into a string
            rm $file1 #removing the temporary file
            disp1="${disp}\n${var1}" #joins the column headers with the crontab string

            echo "$disp1" | sed -r 's/\s+/ /g' | column -t -s' ' #formats and displlays the disp1 variable so each time varient is in a seperate column so it's easy to read
        else                                                    # sed: -r is used for extended regular expresions(cleaner)
				        										# 's/\s+/ /g' selects blank spaces
            echo "no jobs running currently"                    # column: -t for creating tables -s to set seperator

        fi
    else
        echo "no jobs running currently" #else statments for when the job doesn't exist or is empty
    fi
}

#FUCNTION TO INSERT NEW CRON JOBS


insert_job() {

    file=/var/spool/cron/crontabs/$(whoami) #variable for the crontab file location
    clear
    echo "Welcome to the time setting utility"
    echo
    while [ i = i ]; # While loop(1) for selecting minute selection for error handling
    do
        echo "Would you like to set the minutes for the job to fire \e[92m(y/n)\e[0m"
        echo "\e[91m(If not set the job will fire every minute)\e[0m"
        echo
        read -p ">> " MIN_OPT # Reading users input
        case $MIN_OPT in # Case statment to reply to user input


            y|Y|yes)
                clear
                while [ i = i ]; # While loop(2) for y reply for error handeling
                do
                    echo "Select an option for firing the job:"
                    echo
                    echo "\e[92m[1] Fire on set times\e[0m"
                    echo
                    echo "\e[92m[2] Fire at recurring intervals\e[0m"
                    echo
                    read -p ">> " MIN_OPT # read user menu selection
                    case $MIN_OPT in #case statment to reply to user input


                        1)
                            clear
                            while [ i = i ]; #while loop(3) for menu selection for error handling
                            do
                                echo "You have selected to fire on set minute"
                                echo
                                echo "Please enter the minute you want the job to fire \e[92m[0-59]\e[0m"
                                read -p ">> " MIN1 #reads user minute selectio
                                if [ "$MIN1" -ge 0 -a "$MIN1" -le 59 ]; #tests if input is within parameters
                                then
                                    clear
                                    echo "Thank you"
                                    echo
                                    while [ i = i ]; do #while loop(4) for menu selection for error handling
                                        echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                        read -p ">> " MIN_OPT #reads input to check if user wants to input more numbers
                                        clear
                                        if [ $MIN_OPT = y ]; then #tests if reply is 'y'
                                            MIN1="${MIN1},"
                                            MIN2="${MIN2}${MIN1}" #formats selection so it's usable by crontab. loop continues
                                            echo $MIN2
                                            echo
                                            break #escapes loop(4) and then loops(3)
                                        elif [ $MIN_OPT = n ]; then #tests if reply is 'n'
                                            MIN2="${MIN2}${MIN1}" #formats user selection so it's usable by crontab
                                            echo $MIN2
                                            echo
                                            break 2 #escapes loop(3) and loop(4)
                                        else # error handling for when both ifs return false
                                            clear
                                            echo "That is not a valid option. Please try again" #informs user that input was invalid. loops(3)
                                            echo
                                        fi #end of if statment
                                    done #end of loop(4)
                                else # error handling for when input isn't within the parameters
                                    clear
                                    echo "That is not a valid option. Please try again"
                                    echo
                                fi #end of if statment
                            done #end of loop(3)
                            break #escaping of loop(2)
                            ;;


                        2)
                            clear
                            echo "You have selected to fire the job at intervals"
                            echo
                            while [ i = i ]; do #while loop(5) for menu selection for error handling
                                echo "Please enter how often you want the code to run in minutes\e[92m(1-30)\e[0m"
                                read -p ">> " MIN1 # reads in user
                                if [  "$MIN1" -ge 1 -a "$MIN1" -le 30 ]; then #tests if input is within parameters
                                    MIN2="*/${MIN1}" #formats input so it's usable by crontab
                                    clear
                                    echo "You've selected to fire the job every $MIN1 minutes"
                                    echo $MIN2
                                    echo
                                    break #escapes loop(5)
                                else # error handling for when input isn't within the parameters
                                    clear
                                    echo "This is not a valid option. Please try again"
                                    echo
                                fi #end of if statment
                            done #end of loop(5)
                            break #escapes
                            ;;


                        *)  #wildcard for when input isn't correct for error handling
                            clear
                            echo "This is not a valid option. Please try again"
                            echo
                            ;; #loops(2)
                    esac # end of case statment
                done #end of loop(2)
                break #escapes loop(1)
                ;;


            n|N|no)
                MIN2="*" #minute option for when user doesn't want to set a time
                clear
                echo "You have selected not to set the minutes"
                echo "The job will fire at every minute"
                echo
                echo
                break #escapes loop(1)
                ;;


            *) #wildcard for when input isn't correct for error handling
                clear
                echo "This is not a valid option please try again"
                echo
                ;; #loops(1)


        esac #end of case statment
    done #end of loop(1)
    while [ i = i ]; # While loop(6) for selecting minute selection for error handling
    do
        echo "Would you like to set the hours for the job to fire \e[92m(y/n)\e[0m"
        echo "\e[91m(If not set the job will fire every hour)\e[0m"
        echo
        read -p ">> " HR_OPT # Reading users input
        case $HR_OPT in # Case statment to reply to user input

            y|Y|yes)
                clear
                while [ i = i ]; #while loop(7) for menu selection and error handling
                do
                    echo "Select an option for firing the job:"
                    echo
                    echo "\e[92m[1] Fire on set times\e[0m"
                    echo
                    echo "\e[92m[2] Fire at recurring intervals\e[0m"
                    echo
                    read -p ">> " HR_OPT #reading user selection
                    case $HR_OPT in  #case statment to reply to user selection


                        1)
                            clear
                            while [ i = i ]; #while loop(8) for user input and error handling
                            do
                                echo "You have selected to fire on set hours"
                                echo
                                echo "Please enter the hour you want the job to fire \e[92m[0-23]\e[0m"
                                read -p ">> " HR1 #reads user hour input
                                if [ "$HR1" -ge 0 -a "$HR1" -le 23 ]; #tests user input to see if it's within the parameters
                                then
                                    clear
                                    echo "Thank you"
                                    echo
                                    while [ i = i ]; do #while loop(9) for user selection error handeling
                                        echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                        read -p ">> " HR_OPT #reads user input
                                        clear
                                        if [ $HR_OPT = y ]; then #tests for if user input is y
                                            HR1="${HR1},"
                                            HR2="${HR2}${HR1}" #formats hour selection for another time to be added
                                            echo $HR2
                                            echo
                                            break #escapes loop(9)
                                        elif [ $HR_OPT = n ]; then #tests for if user input is n
                                            HR2="${HR2}${HR1}" #formats hour selection for crontab to use
                                            echo $HR2
                                            echo
                                            break 2 #escapes loop(9) and loop(8)
                                        else #else for error handling for when user doesn't enter y/n
                                            clear
                                            echo "That is not a valid option. Please try again"
                                            echo
                                        fi #end of if statment
                                    done #end of loop(9)
                                else #error handling for when user hour input isn't within the parameters
                                    clear
                                    echo "That is not a valid option. Please try again"
                                    echo
                                fi #end of if statment
                            done #end of loop(8)
                            break #escapes loop(7)
                            ;;


                        2)
                            clear
                            echo "You have selected to fire the job at intervals"
                            echo
                            while [ i = i ]; do #while loop(10) for user selection and error handling
                                echo "Please enter how often you want the code to run in hours\e[92m(1-12)\e[0m"
                                read -p ">> " HR1 #reads users hour input
                                if [  "$HR1" -ge 1 -a "$HR1" -le 12 ]; then #tests whether user input is within parameters
                                    HR2="*/${HR1}" #formats input for crontab to use
                                    clear
                                    echo "You've selected to fire the job every $HR1 hours"
                                    echo $HR2
                                    echo
                                    break #escapes loop(10)
                                else #else statment for when input isn't within the parameters
                                    clear
                                    echo "This is not a valid option. Please try again"
                                    echo
                                fi #end of if statment
                            done #end of loop(10)
                            break #escapes loop(7)
                            ;;


                        *) #wildcard for when input isn't correct for error handling
                            clear
                            echo "This is not a valid option. Please try again"
                            echo
                            ;; #loops(7)


                    esac #end of case statment
                done #end of loop(7)
                break #escapes loop(6)
                ;;


            n|N|no)
                HR2="*" #hour option for when user doesn't want to set a time
                clear
                echo "You have selected not to set the hours"
                echo "The job will fire at every hour"
                echo
                break #escapes loop(6)
                ;;


            *) #wildcard for when input isn't correct for error handling
                clear
                echo "This is not a valid option please try again"
                echo
                ;; #loops(6)


        esac #end of case statment
    done #end of loop(6)
    while [ i = i ]; #while loop(11) for user menu selection and error handling
    do
        echo "How would you like to set the days:"
        echo
        echo "\e[92m[1] Monthly\e[0m"
        echo
        echo "\e[92m[2] Weekly\e[0m"
        echo
        echo "\e[92m[3] I would not like to set the days\e[0m"
        echo "\e[91m(if not set the job will fire every day)\e[0m"
        echo
        read -p ">> " DAY_OPT #reads users menu selection
        case $DAY_OPT in #replys to user menu selection


            1)
                clear
                echo "You have selected to set the job to fire monthly"
                echo
                while [ i = i ]; #while loop(12) for user selection and error handeling
                do
                    echo "Select an option for firing the job:"
                    echo
                    echo "\e[92m[1] Fire on set days\e[0m"
                    echo
                    echo "\e[92m[2] Fire at recurring intervals\e[0m"
                    echo
                    read -p ">> " MNT_OPT #reads user menu selection
                    case $MNT_OPT in #case statment to reply to user menu selection


                        1)
                            clear
                            while [ i = i ]; #while loop(13) for time input and error correction
                            do
                                echo "You have selected to fire on set days"
                                echo
                                echo "Please enter the day you want the job to fire \e[92m[1-31]\e[0m"
                                read -p ">> " MNT1 #reads user day input
                                if [ "$MNT1" -ge 1 -a "$MNT1" -le 31 ]; #tests if user input is within parameters
                                then
                                    clear
                                    echo "Thank you"
                                    echo
                                    while [ i = i ]; do #while loop(14) for user selection and error handling
                                        echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                        read -p ">> " MNT_OPT #reads user selection
                                        clear
                                        if [ $MNT_OPT = y ]; then #tests for if user input is y
                                            MNT1="${MNT1},"
                                            MNT2="${MNT2}${MNT1}" #formats days selection for another time to be added
                                            echo $MNT2
                                            echo
                                            break #escapes loop(14)
                                        elif [ $MNT_OPT = n ]; then #tests for if user input is n
                                            MNT2="${MNT2}${MNT1}" #foramts days selection for crontab
                                            echo $MNT2
                                            break 2 #escapes loop(14) and loop(13)
                                        else #else statment for when input isn't correct
                                            clear
                                            echo "That is not a valid option. Please try again"
                                            echo #loops(14)
                                        fi #end of if statment
                                    done #end of loop(14)
                                else #else statment for when input isn't within the parameters
                                    clear
                                    echo "That is not a valid option. Please try again"
                                    echo #loops(13)
                                fi #end of if statment
                            done #end of loop(13)
                            break #escapes loop(12)
                            ;;


                        2)
                            clear
                            while [ i = i ]; do #while loop(15) for time input and error correction
                                echo "You have selected to fire the job at intervals"
                                echo
                                echo "Please enter how often you want the code to run in days\e[92m(1-14)\e[0m"
                                read -p ">> " MNT1 #reads users day input
                                if [  "$MNT1" -ge 1 -a "$MNT1" -le 14 ]; then #tests if input is within the parameters
                                    MNT2="*/${MNT1}" #formats for crontab
                                    clear
                                    echo "You've selected to fire the job every $MNT1 days"
                                    echo $MNT2
                                    echo
                                    break #escapes loop(15)
                                else #else statament for when input is not within the parameters
                                    clear
                                    echo "This is not a valid option. Please try again"
                                    echo #loops(15)
                                fi #end of if statment
                            done #end of loop(15)
                            break #escapes loop(12)
                            ;;


                        *) #wildcard for when input isn't correct for error handling
                            clear
                            echo "This is not a valid option. Please try again"
                            echo #loops(12)
                            ;;


                    esac #end of case statment
                done #end of loop(12)
                WK2="*" #formats weeks for crontab when months are selected
                break #escapes loop(11)
                ;;


            2)
                clear
                echo "You have selected to set the job to fire weekly"
                echo
                while [ i = i ]; do #while loop(16) for time input and error correction
                    echo "Please enter the day you want the job to fire \e[92m[1-7]\e[0m"
                    read -p ">> " WK1 #gets in users day input
                    if [ "$WK1" -ge 1 -a "$WK1" -le 7 ]; #tests whether input is within parameters
                    then
                        clear
                        echo "Thank you"
                        echo
                        while [ i = i ]; do # while loop(17) for user selection and error handling
                            echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                            read -p ">> " WK_OPT #reads in user selection
                            clear
                            if [ $WK_OPT = y ]; then  #tests for if user input is y
                                WK1="${WK1},"
                                WK2="${WK2}${WK1}" #formats days selection for another time to be added
                                echo $WK2
                                break #escapes loop(17)
                            elif [ $WK_OPT = n ]; then #tests for if user input is n
                                WK2="${WK2}${WK1}" #foramts days selection for crontab
                                echo $WK2
                                break 2 #escapes loop(17) and loop(16)
                            else  #else statement for when input is not correct
                                clear
                                echo "That is not a valid option. Please try again"
                                echo #loops(17)
                            fi #end of if statement
                        done #end of loop(17)
                    else  #else statement for when input is not within the parameters
                        clear
                        echo "That is not a valid option. Please try again"
                        echo #loops(16 )
                    fi #end of if statement
                done #end of loop(16)
                MNT2="*" #formats months for crontab when weeks are selected
                break #escapes loop(11)
                ;;


            3)
                MNT2="*" #month option for when user doesn't want to set a time
                WK2="*"  #week option for when user doesn't want to set a time
                clear
                echo "You have selected not to set the days"
                echo "The job will fire every day"
                echo
                echo
                break #escapes loop(11)
                ;;


            *) #wildcard for when input isn't correct for error handling
                clear
                echo "This is not a valid option please try again"
                echo #loops(11)
                ;;


        esac #end of case statement
    done #end of loop(11)
    while [ i = i ]; #while loop(18) for user selection and error handling
    do
        echo "Would you like to set the months for the job to fire \e[92m(y/n)\e[0m"
        echo "\e[91m(If not set the job will fire every month)\e[0m"
        echo
        read -p ">> " MNT_OPT #reads in users input
        case $MNT_OPT in #case statement to respond to user input


            y|Y|yes)
                clear
                while [ i = i ]; #while loop(19) for user menu selection and error handling
                do
                    echo "Select an option for firing the job:"
                    echo
                    echo "\e[92m[1] Fire on set times\e[0m"
                    echo
                    echo "\e[92m[2] Fire at recurring intervals\e[0m"
                    echo
                    read -p ">> " YR_OPT #reads in user menu selection
                    case $YR_OPT in #case statement to respond to users menu selection
                        1)
                            clear
                            while [ i = i ]; #while loop(20) for users month selection and error handling
                            do
                                echo "You have selected to fire on set month"
                                echo
                                echo "Please enter the month you want the job to fire \e[92m[1-12]\e[0m"
                                read -p ">> " YR1 #reads in user month input
                                if [ "$YR1" -ge 1 -a "$YR1" -le 12 ]; #tests whether user input is within parameters
                                then
                                    clear
                                    echo "Thank you"
                                    echo
                                    while [ i = i ]; do #while loop(21) for user selection and erreor handling
                                        echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                        read -p ">> " YR_OPT #reads in user selection
                                        clear
                                        if [ $YR_OPT = y ]; then #tests for if user input is y
                                            YR1="${YR1},"
                                            YR2="${YR2}${YR1}" #formats month selection for another time to be added
                                            echo $YR2
                                            echo
                                            break #escapes loop(21)
                                        elif [ $YR_OPT = n ]; then #tests for if user input is n
                                            YR2="${YR2}${YR1}" #formats user month selection for crontab
                                            echo $YR2
                                            break 2 #escapes loop(21) and loop(20)
                                        else #else statement for when selection is not within the parameters
                                            clear
                                            echo "That is not a valid option. Please try again"
                                            echo  #loops(21)
                                        fi #end of if statement
                                    done #end of loop(21)
                                else #else statement for when selection is not within the parameters
                                    clear
                                    echo "That is not a valid option. Please try again"
                                    echo #loops(20)
                                fi #end of if statement
                            done #end of loop(20)
                            break #escapes loop(19)
                            ;;


                        2)
                            clear
                            while [ i = i ]; do #while loop(22) for month input and error handling
                                echo "You have selected to fire the job at intervals"
                                echo
                                echo "Please enter how often you want the code to run in months\e[92m(1-6)\e[0m"
                                read -p ">> " YR1 #reads in user month option
                                if [  "$YR1" -ge 1 -a "$YR1" -le 6 ]; then #tests whether user input is within parameters
                                    YR2="*/${YR1}" #formats user input for crontab
                                    clear
                                    echo "You've selected to fire the job every $YR1 months"
                                    echo $YR2
                                    echo
                                    break #escapes loop(22)
                                else #else statement for when selection is not within the parameters
                                    clear
                                    echo "This is not a valid option. Please try again"
                                    echo #loops(22)
                                fi #end of if statement
                            done  #end of loop(22)
                            break #escapes loop(19)
                            ;;


                        *)
                            clear
                            echo "This is not a valid option. Please try again"
                            echo #loops(19)
                            ;;


                    esac #end of case statement
                done #end of loop(19)
                break #escapes loop(18)
                ;;


            n|N|no)
                YR2="*" #year option for when user doesn't want to set a time
                clear
                echo "You have selected not to set the months"
                echo "The job will fire at every month"
                echo
                echo
                break #escapes loop(18)
                ;;


            *) #wildcard for when input isn't correct for error handling
                clear
                echo "This is not a valid option please try again"
                echo #loops(18)
                ;;


        esac #end of case statement
    done #end of loop(18)
    clear
    job_time="${MIN2} ${HR2} ${MNT2} ${YR2} ${WK2}" #formats all the user time inputs for the full crontab time setting
    echo
    echo "Welcome to the cron's command/script installation utility "
    echo
    while [ i = i ]; do #while loop(23) for error handling
        echo "\e[92m[1] Use a system command\e[0m" #\e[92m \e[0m used to colour menu
        echo
        echo "\e[92m[2] Use your own/custom script\e[0m" #Creates a visual menu for the user to interact with.
        echo
        read -p ">> " opt #Takes in the users menu option
        case $opt in #Replies to users menu selection
            1)
                clear
                while [ i = i ]; do #while loop(24) for error handling
                    echo "Enter the command you want to execute"
                    read -p ">>" cmd #reads in user command to install
                    if [ -z "$cmd" ]; then #tests if user input is empty
                        clear
                        echo "This is not a valid input. Please try again"
                        echo
                    elif command -v $cmd >/dev/null; then #tests whether command exists
                        clear
                        task=$cmd #changes variable for installation
                        echo "job installed successfully."
                        echo "$task"
                        echo
                        break 2 #escapes loop(24) and loop(23)
                    else #else for when command doesn't exist
                        clear
                        echo "This is not a valid command. Please try again"
                        echo
                    fi
                done #end of loop(24)
                ;;
            2)
                clear
                while [ i = i ]; do #while loop(25) for error handling
                    echo
                    echo "Enter the path of the script"
                    read -p ">>" spath #reads in scripts path
                    if [ -f "$spath" ]; then #tests whether script exists
                        task=$spath #changes variable for installation
                        echo "job installed successfully"
                        echo "$task"
                        echo
                        break 2 #escapes loop(25) and loop(23)
                    else #else for when script doesn't exist
                        clear
                        echo "No such file exists. Please try again"
                        echo
                    fi
                done #end of loop(25)
                ;;
            *) #wildcard for when user selection isn't valid
                clear
                echo "This is not a valid input"
                echo "Please try again"
                echo
                ;;
        esac #End of case statment
    done #end of loop(23)
    clear
    echo "Welcome to the job_id assignment utility"
    echo
    while [ i = i ]; do #while loop(26) for error handling 
        echo "Enter a job ID for the cronjob"
        echo
        read -p ">> " jid #reads in user job id selection
        clear
        job_id="#$jid" #formats job id
        if [ -z "$jid" ]; then #checks whether user input is empty
            clear
            echo "This is not a valid input"
            echo
        elif grep -w "$job_id" $file 2> /dev/null; then #tests whether the selected job id is already taken & sends stderr to the black hole (/dev/nul)
            clear
            echo "This job ID is already taken."
            echo
        else
            cron_line="$job_time $task $job_id" #formats the user inputs for crontab
            echo "$cron_line"
            echo "$cron_line" >> $file #inputs the cron_line variable into the crontab file
            echo "2" | echo ":wq" | crontab -e #opens the crontab file, writes it, and then quits. This is done to install the new jobs.
            #"2" is inputted in case crontab hasn't been used before. it selects vi for editor
            sed -i '/^# /d' $file #deletes every line in the crontab file that starts with "#". This is done so we can test whether there are any jobs or not
            #also required to display jobs in a nice format
            clear
            break #escapes loop(26)
        fi
    done #end of loop(26)
}

edit_job() {
    file=/var/spool/cron/crontabs/$(whoami)
    if [ -f  "$file" ]; then
        if [ -s "$file" ]; then #tests whether crontab file exists and isn't empty
            while [ i = i ]; do #while loop(0)
                list_jobs #calls list_jobs function
                echo "Enter the job ID of the job you want to edit"
                echo
                read -p ">>" job_id #reads in job ID for job to be edited
                editthis="#$job_id" #formats the job id
                if grep -w "$editthis" $file; then #tests whether input is a job id
                    sed -i "/$editthis$/d" $file #removes the job, so that an edit can be inputed
                    clear
                    echo "You will now set a new time for the job"
                    echo
                    while [ i = i ]; # While loop(1) for selecting minute selection for error handling
                    do
                        echo "Would you like to set the minutes for the job to fire \e[92m(y/n)\e[0m"
                        echo "\e[91m(If not set the job will fire every minute)\e[0m"
                        echo
                        read -p ">> " MIN_OPT # Reading users input
                        case $MIN_OPT in # Case statment to reply to user input


                            y|Y|yes)
                                clear
                                while [ i = i ]; # While loop(2) for y reply for error handeling
                                do
                                    echo "Select an option for firing the job:"
                                    echo
                                    echo "\e[92m[1] Fire on set times\e[0m"
                                    echo
                                    echo "\e[92m[2] Fire at recurring intervals\e[0m"
                                    echo
                                    read -p ">> " MIN_OPT # read user menu selection
                                    case $MIN_OPT in #case statment to reply to user input


                                        1)
                                            clear
                                            while [ i = i ]; #while loop(3) for menu selection for error handling
                                            do
                                                echo "You have selected to fire on set minute"
                                                echo
                                                echo "Please enter the minute you want the job to fire \e[92m[0-59]\e[0m"
                                                read -p ">> " MIN1 #reads user minute selectio
                                                if [ "$MIN1" -ge 0 -a "$MIN1" -le 59 ]; #tests if input is within parameters
                                                then
                                                    clear
                                                    echo "Thank you"
                                                    echo
                                                    while [ i = i ]; do #while loop(4) for menu selection for error handling
                                                        echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                                        read -p ">> " MIN_OPT #reads input to check if user wants to input more numbers
                                                        clear
                                                        if [ $MIN_OPT = y ]; then #tests if reply is 'y'
                                                            MIN1="${MIN1},"
                                                            MIN2="${MIN2}${MIN1}" #formats selection so it's usable by crontab. loop continues
                                                            echo $MIN2
                                                            echo
                                                            break #escapes loop(4) and then loops(3)
                                                        elif [ $MIN_OPT = n ]; then #tests if reply is 'n'
                                                            MIN2="${MIN2}${MIN1}" #formats user selection so it's usable by crontab
                                                            echo $MIN2
                                                            echo
                                                            break 2 #escapes loop(3) and loop(4)
                                                        else # error handling for when both ifs return false
                                                            clear
                                                            echo "That is not a valid option. Please try again" #informs user that input was invalid. loops(3)
                                                            echo
                                                        fi #end of if statment
                                                    done #end of loop(4)
                                                else # error handling for when input isn't within the parameters
                                                    clear
                                                    echo "That is not a valid option. Please try again"
                                                    echo
                                                fi #end of if statment
                                            done #end of loop(3)
                                            break #escaping of loop(2)
                                            ;;


                                        2)
                                            clear
                                            echo "You have selected to fire the job at intervals"
                                            echo
                                            while [ i = i ]; do #while loop(5) for menu selection for error handling
                                                echo "Please enter how often you want the code to run in minutes\e[92m(1-30)\e[0m"
                                                read -p ">> " MIN1 # reads in user
                                                if [  "$MIN1" -ge 1 -a "$MIN1" -le 30 ]; then #tests if input is within parameters
                                                    MIN2="*/${MIN1}" #formats input so it's usable by crontab
                                                    clear
                                                    echo "You've selected to fire the job every $MIN1 minutes"
                                                    echo $MIN2
                                                    echo
                                                    break #escapes loop(5)
                                                else # error handling for when input isn't within the parameters
                                                    clear
                                                    echo "This is not a valid option. Please try again"
                                                    echo
                                                fi #end of if statment
                                            done #end of loop(5)
                                            break #escapes
                                            ;;


                                        *)  #wildcard for when input isn't correct for error handling
                                            clear
                                            echo "This is not a valid option. Please try again"
                                            echo
                                            ;; #loops(2)
                                    esac # end of case statment
                                done #end of loop(2)
                                break #escapes loop(1)
                                ;;


                            n|N|no)
                                MIN2="*" #minute option for when user doesn't want to set a time
                                clear
                                echo "You have selected not to set the minutes"
                                echo "The job will fire at every minute"
                                echo
                                echo
                                break #escapes loop(1)
                                ;;


                            *) #wildcard for when input isn't correct for error handling
                                clear
                                echo "This is not a valid option please try again"
                                echo
                                ;; #loops(1)


                        esac #end of case statment
                    done #end of loop(1)
                    while [ i = i ]; # While loop(6) for selecting minute selection for error handling
                    do
                        echo "Would you like to set the hours for the job to fire \e[92m(y/n)\e[0m"
                        echo "\e[91m(If not set the job will fire every hour)\e[0m"
                        echo
                        read -p ">> " HR_OPT # Reading users input
                        case $HR_OPT in # Case statment to reply to user input

                            y|Y|yes)
                                clear
                                while [ i = i ]; #while loop(7) for menu selection and error handling
                                do
                                    echo "Select an option for firing the job:"
                                    echo
                                    echo "\e[92m[1] Fire on set times\e[0m"
                                    echo
                                    echo "\e[92m[2] Fire at recurring intervals\e[0m"
                                    echo
                                    read -p ">> " HR_OPT #reading user selection
                                    case $HR_OPT in  #case statment to reply to user selection


                                        1)
                                            clear
                                            while [ i = i ]; #while loop(8) for user input and error handling
                                            do
                                                echo "You have selected to fire on set hours"
                                                echo
                                                echo "Please enter the hour you want the job to fire \e[92m[0-23]\e[0m"
                                                read -p ">> " HR1 #reads user hour input
                                                if [ "$HR1" -ge 0 -a "$HR1" -le 23 ]; #tests user input to see if it's within the parameters
                                                then
                                                    clear
                                                    echo "Thank you"
                                                    echo
                                                    while [ i = i ]; do #while loop(9) for user selection error handeling
                                                        echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                                        read -p ">> " HR_OPT #reads user input
                                                        clear
                                                        if [ $HR_OPT = y ]; then #tests for if user input is y
                                                            HR1="${HR1},"
                                                            HR2="${HR2}${HR1}" #formats hour selection for another time to be added
                                                            echo $HR2
                                                            echo
                                                            break #escapes loop(9)
                                                        elif [ $HR_OPT = n ]; then #tests for if user input is n
                                                            HR2="${HR2}${HR1}" #formats hour selection for crontab to use
                                                            echo $HR2
                                                            echo
                                                            break 2 #escapes loop(9) and loop(8)
                                                        else #else for error handling for when user doesn't enter y/n
                                                            clear
                                                            echo "That is not a valid option. Please try again"
                                                            echo
                                                        fi #end of if statment
                                                    done #end of loop(9)
                                                else #error handling for when user hour input isn't within the parameters
                                                    clear
                                                    echo "That is not a valid option. Please try again"
                                                    echo
                                                fi #end of if statment
                                            done #end of loop(8)
                                            break #escapes loop(7)
                                            ;;


                                        2)
                                            clear
                                            echo "You have selected to fire the job at intervals"
                                            echo
                                            while [ i = i ]; do #while loop(10) for user selection and error handling
                                                echo "Please enter how often you want the code to run in hours\e[92m(1-12)\e[0m"
                                                read -p ">> " HR1 #reads users hour input
                                                if [  "$HR1" -ge 1 -a "$HR1" -le 12 ]; then #tests whether user input is within parameters
                                                    HR2="*/${HR1}" #formats input for crontab to use
                                                    clear
                                                    echo "You've selected to fire the job every $HR1 hours"
                                                    echo $HR2
                                                    echo
                                                    break #escapes loop(10)
                                                else #else statment for when input isn't within the parameters
                                                    clear
                                                    echo "This is not a valid option. Please try again"
                                                    echo
                                                fi #end of if statment
                                            done #end of loop(10)
                                            break #escapes loop(7)
                                            ;;


                                        *) #wildcard for when input isn't correct for error handling
                                            clear
                                            echo "This is not a valid option. Please try again"
                                            echo
                                            ;; #loops(7)


                                    esac #end of case statment
                                done #end of loop(7)
                                break #escapes loop(6)
                                ;;


                            n|N|no)
                                HR2="*" #hour option for when user doesn't want to set a time
                                clear
                                echo "You have selected not to set the hours"
                                echo "The job will fire at every hour"
                                echo
                                break #escapes loop(6)
                                ;;


                            *) #wildcard for when input isn't correct for error handling
                                clear
                                echo "This is not a valid option please try again"
                                echo
                                ;; #loops(6)


                        esac #end of case statment
                    done #end of loop(6)
                    while [ i = i ]; #while loop(11) for user menu selection and error handling
                    do
                        echo "How would you like to set the days:"
                        echo
                        echo "\e[92m[1] Monthly\e[0m"
                        echo
                        echo "\e[92m[2] Weekly\e[0m"
                        echo
                        echo "\e[92m[3] I would not like to set the days\e[0m"
                        echo "\e[91m(if not set the job will fire every day)\e[0m"
                        echo
                        read -p ">> " DAY_OPT #reads users menu selection
                        case $DAY_OPT in #replys to user menu selection


                            1)
                                clear
                                echo "You have selected to set the job to fire monthly"
                                echo
                                while [ i = i ]; #while loop(12) for user selection and error handeling
                                do
                                    echo "Select an option for firing the job:"
                                    echo
                                    echo "\e[92m[1] Fire on set days\e[0m"
                                    echo
                                    echo "\e[92m[2] Fire at recurring intervals\e[0m"
                                    echo
                                    read -p ">> " MNT_OPT #reads user menu selection
                                    case $MNT_OPT in #case statment to reply to user menu selection


                                        1)
                                            clear
                                            while [ i = i ]; #while loop(13) for time input and error correction
                                            do
                                                echo "You have selected to fire on set days"
                                                echo
                                                echo "Please enter the day you want the job to fire \e[92m[1-31]\e[0m"
                                                read -p ">> " MNT1 #reads user day input
                                                if [ "$MNT1" -ge 1 -a "$MNT1" -le 31 ]; #tests if user input is within parameters
                                                then
                                                    clear
                                                    echo "Thank you"
                                                    echo
                                                    while [ i = i ]; do #while loop(14) for user selection and error handling
                                                        echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                                        read -p ">> " MNT_OPT #reads user selection
                                                        clear
                                                        if [ $MNT_OPT = y ]; then #tests for if user input is y
                                                            MNT1="${MNT1},"
                                                            MNT2="${MNT2}${MNT1}" #formats days selection for another time to be added
                                                            echo $MNT2
                                                            echo
                                                            break #escapes loop(14)
                                                        elif [ $MNT_OPT = n ]; then #tests for if user input is n
                                                            MNT2="${MNT2}${MNT1}" #foramts days selection for crontab
                                                            echo $MNT2
                                                            break 2 #escapes loop(14) and loop(13)
                                                        else #else statment for when input isn't correct
                                                            clear
                                                            echo "That is not a valid option. Please try again"
                                                            echo #loops(14)
                                                        fi #end of if statment
                                                    done #end of loop(14)
                                                else #else statment for when input isn't within the parameters
                                                    clear
                                                    echo "That is not a valid option. Please try again"
                                                    echo #loops(13)
                                                fi #end of if statment
                                            done #end of loop(13)
                                            break #escapes loop(12)
                                            ;;


                                        2)
                                            clear
                                            while [ i = i ]; do #while loop(15) for time input and error correction
                                                echo "You have selected to fire the job at intervals"
                                                echo
                                                echo "Please enter how often you want the code to run in days\e[92m(1-14)\e[0m"
                                                read -p ">> " MNT1 #reads users day input
                                                if [  "$MNT1" -ge 1 -a "$MNT1" -le 14 ]; then #tests if input is within the parameters
                                                    MNT2="*/${MNT1}" #formats for crontab
                                                    clear
                                                    echo "You've selected to fire the job every $MNT1 days"
                                                    echo $MNT2
                                                    echo
                                                    break #escapes loop(15)
                                                else #else statament for when input is not within the parameters
                                                    clear
                                                    echo "This is not a valid option. Please try again"
                                                    echo #loops(15)
                                                fi #end of if statment
                                            done #end of loop(15)
                                            break #escapes loop(12)
                                            ;;


                                        *) #wildcard for when input isn't correct for error handling
                                            clear
                                            echo "This is not a valid option. Please try again"
                                            echo #loops(12)
                                            ;;


                                    esac #end of case statment
                                done #end of loop(12)
                                WK2="*" #formats weeks for crontab when months are selected
                                break #escapes loop(11)
                                ;;


                            2)
                                clear
                                echo "You have selected to set the job to fire weekly"
                                echo
                                while [ i = i ]; do #while loop(16) for time input and error correction
                                    echo "Please enter the day you want the job to fire \e[92m[1-7]\e[0m"
                                    read -p ">> " WK1 #gets in users day input
                                    if [ "$WK1" -ge 1 -a "$WK1" -le 7 ]; #tests whether input is within parameters
                                    then
                                        clear
                                        echo "Thank you"
                                        echo
                                        while [ i = i ]; do # while loop(17) for user selection and error handling
                                            echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                            read -p ">> " WK_OPT #reads in user selection
                                            clear
                                            if [ $WK_OPT = y ]; then  #tests for if user input is y
                                                WK1="${WK1},"
                                                WK2="${WK2}${WK1}" #formats days selection for another time to be added
                                                echo $WK2
                                                break #escapes loop(17)
                                            elif [ $WK_OPT = n ]; then #tests for if user input is n
                                                WK2="${WK2}${WK1}" #foramts days selection for crontab
                                                echo $WK2
                                                break 2 #escapes loop(17) and loop(16)
                                            else  #else statement for when input is not correct
                                                clear
                                                echo "That is not a valid option. Please try again"
                                                echo #loops(17)
                                            fi #end of if statement
                                        done #end of loop(17)
                                    else  #else statement for when input is not within the parameters
                                        clear
                                        echo "That is not a valid option. Please try again"
                                        echo #loops(16 )
                                    fi #end of if statement
                                done #end of loop(16)
                                MNT2="*" #formats months for crontab when weeks are selected
                                break #escapes loop(11)
                                ;;


                            3)
                                MNT2="*" #month option for when user doesn't want to set a time
                                WK2="*"  #week option for when user doesn't want to set a time
                                clear
                                echo "You have selected not to set the days"
                                echo "The job will fire every day"
                                echo
                                echo
                                break #escapes loop(11)
                                ;;


                            *) #wildcard for when input isn't correct for error handling
                                clear
                                echo "This is not a valid option please try again"
                                echo #loops(11)
                                ;;


                        esac #end of case statement
                    done #end of loop(11)
                    while [ i = i ]; #while loop(18) for user selection and error handling
                    do
                        echo "Would you like to set the months for the job to fire \e[92m(y/n)\e[0m"
                        echo "\e[91m(If not set the job will fire every month)\e[0m"
                        echo
                        read -p ">> " MNT_OPT #reads in users input
                        case $MNT_OPT in #case statement to respond to user input


                            y|Y|yes)
                                clear
                                while [ i = i ]; #while loop(19) for user menu selection and error handling
                                do
                                    echo "Select an option for firing the job:"
                                    echo
                                    echo "\e[92m[1] Fire on set times\e[0m"
                                    echo
                                    echo "\e[92m[2] Fire at recurring intervals\e[0m"
                                    echo
                                    read -p ">> " YR_OPT #reads in user menu selection
                                    case $YR_OPT in #case statement to respond to users menu selection
                                        1)
                                            clear
                                            while [ i = i ]; #while loop(20) for users month selection and error handling
                                            do
                                                echo "You have selected to fire on set month"
                                                echo
                                                echo "Please enter the month you want the job to fire \e[92m[1-12]\e[0m"
                                                read -p ">> " YR1 #reads in user month input
                                                if [ "$YR1" -ge 1 -a "$YR1" -le 12 ]; #tests whether user input is within parameters
                                                then
                                                    clear
                                                    echo "Thank you"
                                                    echo
                                                    while [ i = i ]; do #while loop(21) for user selection and erreor handling
                                                        echo "Would you like to add another time for the job to fire? \e[92m(y/n)\e[0m"
                                                        read -p ">> " YR_OPT #reads in user selection
                                                        clear
                                                        if [ $YR_OPT = y ]; then #tests for if user input is y
                                                            YR1="${YR1},"
                                                            YR2="${YR2}${YR1}" #formats month selection for another time to be added
                                                            echo $YR2
                                                            echo
                                                            break #escapes loop(21)
                                                        elif [ $YR_OPT = n ]; then #tests for if user input is n
                                                            YR2="${YR2}${YR1}" #formats user month selection for crontab
                                                            echo $YR2
                                                            break 2 #escapes loop(21) and loop(20)
                                                        else #else statement for when selection is not within the parameters
                                                            clear
                                                            echo "That is not a valid option. Please try again"
                                                            echo  #loops(21)
                                                        fi #end of if statement
                                                    done #end of loop(21)
                                                else #else statement for when selection is not within the parameters
                                                    clear
                                                    echo "That is not a valid option. Please try again"
                                                    echo #loops(20)
                                                fi #end of if statement
                                            done #end of loop(20)
                                            break #escapes loop(19)
                                            ;;


                                        2)
                                            clear
                                            while [ i = i ]; do #while loop(22) for month input and error handling
                                                echo "You have selected to fire the job at intervals"
                                                echo
                                                echo "Please enter how often you want the code to run in months\e[92m(1-6)\e[0m"
                                                read -p ">> " YR1 #reads in user month option
                                                if [  "$YR1" -ge 1 -a "$YR1" -le 6 ]; then #tests whether user input is within parameters
                                                    YR2="*/${YR1}" #formats user input for crontab
                                                    clear
                                                    echo "You've selected to fire the job every $YR1 months"
                                                    echo $YR2
                                                    echo
                                                    break #escapes loop(22)
                                                else #else statement for when selection is not within the parameters
                                                    clear
                                                    echo "This is not a valid option. Please try again"
                                                    echo #loops(22)
                                                fi #end of if statement
                                            done  #end of loop(22)
                                            break #escapes loop(19)
                                            ;;


                                        *)
                                            clear
                                            echo "This is not a valid option. Please try again"
                                            echo #loops(19)
                                            ;;


                                    esac #end of case statement
                                done #end of loop(19)
                                break #escapes loop(18)
                                ;;


                            n|N|no)
                                YR2="*" #year option for when user doesn't want to set a time
                                clear
                                echo "You have selected not to set the months"
                                echo "The job will fire at every month"
                                echo
                                echo
                                break #escapes loop(18)
                                ;;


                            *) #wildcard for when input isn't correct for error handling
                                clear
                                echo "This is not a valid option please try again"
                                echo #loops(18)
                                ;;


                        esac #end of case statement
                    done #end of loop(18)
                    clear
                    job_time="${MIN2} ${HR2} ${MNT2} ${YR2} ${WK2}" #formats all the user time inputs for the full crontab time setting
                    echo "$job_time"
                    echo
                    echo "You will now set a new job"
                    echo
                    while [ i = i ]; do #while loop(23) for error handling
                        echo "\e[92m[1] Use a system command\e[0m" #\e[92m \e[0m used to colour menu
                        echo
                        echo "\e[92m[2] Use your own/custom script\e[0m" #Creates a visual menu for the user to interact with.
                        echo
                        read -p ">> " opt #Takes in the users menu option
                        case $opt in #Replies to users menu selection
                            1)
                                clear
                                while [ i = i ]; do #while loop(24) for error handling
                                    echo "Enter the command you want to execute"
                                    read -p ">>" cmd #reads in users command
                                    if [ -z "$cmd" ]; then #tests if user input is empty
                                        clear
                                        echo "This is not a valid input. Please try again"
                                        echo
                                    elif command -v $cmd >/dev/null; then #tests whether the command exists
                                        clear
                                        task=$cmd #changing varibable to task
                                        echo "job installed successfully."
                                        echo "$task"
                                        echo
                                        break 2 #escapes loop(23) and loop(24)
                                    else #else for when the command doesn't exist
                                        clear
                                        echo "This is not a valid command. Please try again"
                                        echo
                                    fi
                                done #end of loop(24)
                                ;;
                            2)
                                clear
                                while [ i = i ]; do #while loop(25) for error handling
                                    echo
                                    echo "Enter the path of the script"
                                    read -p ">>" spath #reads in the path for the script to be installed
                                    if [ -f "$spath" ]; then #tests whether script exists
                                        task=$spath #changing varibable to task
                                        echo "job installed successfully"
                                        echo "$task"
                                        echo
                                        break 2 #escapes loop(23) and loop(25)
                                    else #else for when file doesn't exist
                                        clear
                                        echo "No such file exists. Please try again"
                                        echo
                                    fi
                                done #end of loop(25)
                                ;;
                            *) #wildcard for when the user doesn't enter a valid menu option
                                clear
                                echo "This is not a valid input"
                                echo "Please try again"
                                echo
                                ;;
                        esac #End of case statment
                    done #end of loop(23)
                    clear
                    echo "Would you like to set a new job id? \e[92m(y/n)\e[0m"
                    echo
                    while [ i = i ]; do #while loop(26) for error handling
                        read -p ">> " opt
                        if [ $opt = y ]; then #if statment to test whether user answered y
                            while [ i = i ]; do #while loop(27) for error handling
                                echo "Enter a job ID for the cronjob"
                                echo
                                echo "\e[91mRules: Ensure the job_id is as unique as possible, only alphanumeric characters are supported\e[0m"
                                echo
                                read -p ">> " jid #reads users new job ID
                                job_id="#$jid" #formats the job ID
                                if [ -z "$jid" ]; then #checks whether user input is empty
                                    clear
                                    echo "This is not a valid input"
                                    echo
                                elif grep -w "$job_id" $file 2> /dev/null; then #tests whether the selected job id is already taken & sends stderr to the black hole (/dev/nul)
                                    clear
                                    echo "This job ID is already taken."
                                    echo
                                else
                                    break 2 #escapes loop(26) and loop(27)
                                fi
                            done #end of loop(27)
                        elif [ $opt = n ]; then #if statment to test whether user answered n
                            job_id="#${job_id}" #formats the previous job ID
                            break #escapes loop(26)
                        else #else for error handling for when the user doesn't input a valid option
                            clear
                            echo "This is not a valid input. Please try again \e[92m(y/n)\e[0m"
                        fi
                    done #end of loop(26)
                    clear
                    cron_line="$job_time $task $job_id" #formats the user inputs for crontab
                    echo "$cron_line"
                    echo "$cron_line" >> $file #inputs the cron_line variable into the crontab file
                    echo "2" | echo ":wq" | crontab -e #opens the crontab file, writes it, and then quits. This is done to install the new jobs
                    #"2" is inputted in case crontab hasn't been used before. it selects vi for editor
                    sed -i '/^# /d' $file #deletes every line in the crontab file that starts with "#". This is done so we can test wether there are any jobs or not
                     #also required to display jobs in a nice format
                    clear
                    break #escapes loop(26)
                else
                    clear
                    echo "Not a valid job_id"
                    echo
                fi
            done #end of loop(0)
        else
            echo "No jobs currently running"	
        fi
    else
        echo "no jobs currently running"
    fi
}

#FUCNTION TO REMOVE ONE JOB
remove_one() {
    file=/var/spool/cron/crontabs/$(whoami) #variable for crontab file location
    if [ -f  "$file" ]; then
        if [ -s "$file" ]; then #if statments to test that the crontab file exists and isn't empty
            while [ i = i ]; do #while loop for error handling
                list_jobs #calls list_jobs function
                echo
                echo "Enter the job ID of the job you want to remove"
                echo
                read -p ">>" job_id #reads in user job ID selection
                killthis="#$job_id" #formats ID for removal
                if grep -w "$killthis" $file; then #tests whether input is a job id
                    sed -i "/$killthis$/d" $file #removes line with relevent job ID
                    break #escapes loop
                else
                    clear
                    echo "This is not a valid job_id"
                    echo
                fi
            done
        else
            echo "No jobs currently running"
        fi
    else
        echo "No jobs currently running"
    fi

}

#FUNCTION TO REMOVE ALL JOBS

remove_all() {
	 while [ i = i ]; do #while loop for error handling
                echo "Are you sure you want to remove all the jobs? \e[92m(y/n)\e[0m"
                read -p ">> " rm_opt #reads in user option
                if [ $rm_opt = "y" ]; then #tests if user inputs y
                    clear
                    echo "All jobs will now be removed"
                    crontab -r #removes all crontab jobs
                    break #escapes loop
                elif [ $rm_opt = "n" ]; then #tests if user inputs n
                    clear
                    echo "Jobs will not be removed"
                    break #escapes loop
                else #else for when user does enter a valid input
                    clear
                    echo "This is not a valid option"
                    echo
                fi #end of if
            done #end of while loop
}

clear
echo "\e[93m             __  ____   ______ ____   ___  _   _ _____  _    ____  
            |  \/  \ \ / / ___|  _ \ / _ \| \ | |_   _|/ \  | __ ) 
            | |\/| |\ V / |   | |_) | | | |  \| | | | / _ \ |  _ \ 
            | |  | | | || |___|  _ <| |_| | |\  | | |/ ___ \| |_) |
            |_|  |_| |_| \____|_| \_\\\\\\___/|_| \_| |_/_/   \_\____/ 
\e[0m"
echo
echo "Welcome to the crontab terminal user interface."
echo
while [ i = i ]; #loop to print menu until option 6 is selected
do
    echo "Please select an option from the menu: "
    echo
    echo "\e[92m[1] Display crontab jobs\e[0m" #\e[92m \e[0m used to colour menu
    echo
    echo "\e[92m[2] Insert a job\e[0m"
    echo
    echo "\e[92m[3] Edit a job\e[0m"
    echo
    echo "\e[92m[4] Remove a job\e[0m"
    echo
    echo "\e[92m[5] Remove all jobs\e[0m"
    echo
    echo "\e[92m[6] Exit\e[0m" #Creates a visual menu for the user to interact with.
    echo
    read -p ">> " MENUOPTION #Takes in the users menu option
    case $MENUOPTION in #Replies to users menu selection
        1)
            clear
            echo "You have selected option 1"
            list_jobs #calls list_jobs function
            echo
            echo #Extra blank lines to make things more readable/neat
            ;;
        2)
            clear
            echo "You have selected option 2"
            insert_job #calls insert_job function
            echo
            echo
            ;;
        3)
            clear
            echo "You have selected option 3"
            edit_job #calls edit_job function
            echo
            echo
            ;;
        4)
            clear
            echo "You have selected option 4"
            remove_one #calls remove_one function
            echo
            echo
            ;;
        5)
            clear
            echo "You have selected option 5"
            remove_all #calls remove function
            echo
            echo
            ;;
        6)
            clear
            echo "You have selected option 6"
            echo "The script will now exit"
            break ;; #Escaping the loop
        *)
            clear
            echo "This is not a valid input"
            echo "Please try again"
            echo
            echo
            ;;
    esac #End of case statment
done #End of loop
