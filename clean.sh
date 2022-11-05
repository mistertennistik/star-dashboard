#importing utils
. ./utils.sh --source-only


printf "Remaking config file ... \n"
echo "/* WARNING !!! must keep exactly const BASE_PATH as name, even the space before equal:  used for deployment*/
const BASE_PATH = 'http://localhost:5000';" > ./frontEnd/config.js
print_result_sucess_error " -> file has been restored" " -> file restoration failed"


