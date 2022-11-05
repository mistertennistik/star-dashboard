# importing utils
. ./utils.sh --source-only

# default base path if no args
api_base_path="http://localhost:5000"

## checking args -b or -a here @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
while getopts ":b:a:" opt; do
  case $opt in
    b) api_base_path="$OPTARG"
    ;;
    a) a_var="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    exit 1
    ;;
  esac

  case $OPTARG in
    -*) echo "Option $opt needs a valid argument"
    exit 1
    ;;
  esac
done

printf "Argument api_base_path is %s\n" "$api_base_path"

## @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


######################  Manage config.js file <<<<<<<<<<<<<<<
printf " \n\n******** remplacement du BASE_PATH dans le fichier de config ... ************ \n\n"

# get entire line with definition of -BASE_PATH- variable and escape it
initial_bp_escaped=$(escape_url_for_sed "$(grep "const BASE_PATH =" ./frontEnd/config.js)")

# escape base path (given or default)
base_path_with_escaped=$(escape_url_for_sed $api_base_path)

# make replacement in config file
sed -i -e "s/$initial_bp_escaped/const BASE_PATH = '$base_path_with_escaped';/g" ./frontEnd/config.js

# success or error message after treatment
print_result_sucess_error " => base path successfully replaced : $base_path_with_escaped" " => error while replacing"
####################### <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<



######################## Remove star* containers **********************************

printf " \n\n******** Supression en force des containers 'star' ...************ \n\n"
docker rm -f $(docker ps -a --filter name=star* -q);

####################### **********************************************************


##### Build docker images and run it >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
printf " \n\n******** Build and deploy de l'API ...************ \n\n"
docker build ./backEnd -t python-alpine-flask && docker run -d --name star-data-api -p 5000:5000 python-alpine-flask ;

printf " \n\n******** Build and deploy du front ... ************ \n\n"
docker build ./frontEnd -t nginx-dashboard-front && docker run --name star-data-dashboard -d -p 8080:80 nginx-dashboard-front ;

##### >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
