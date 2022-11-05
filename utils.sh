function print_result_sucess_error(){
    if [ $? -eq 0 ] 
    then 
        echo "$1" 
    else 
        echo "$2" 
    fi
}

function escape_url_for_sed(){
    echo "$1" | sed 's/\//\\\//g'
}