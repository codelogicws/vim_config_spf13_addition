myArray=""
arrayLenth=""
userAnswer=""
isProgramRunning=1

function setArray {
    myArray=($(tmuxinator list))
    myArray=("${myArray[@]:2}")
    arrayLength=${#myArray[@]}
}

function printPrompt {
    echo "Choose one of the following tmuxinator setups"
    echo "Current Project Folder $PROJECT_FOLDER"
    echo "************************"
    for (( i=0; i<arrayLength; i=i+1 )); do
        echo $(( i ))": "${myArray[i]}
    done
    echo "$arrayLength: Exit"
}

function getUsersAnswer {
    read -p "Choice: " userAnswer
}

function executeUserRequest {
	if [ $userAnswer -eq $arrayLength ]; then
        isProgramRunning=0
    elif [ $userAnswer -lt $arrayLength ]; then
        tmuxinator start "${myArray[userAnswer]}"
    fi
}

setArray
while [ $isProgramRunning -gt 0 ]; do
    clear
    printPrompt
    getUsersAnswer
    executeUserRequest
done
