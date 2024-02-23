log_file="/tmp/expense.log"
color="\e[34m"

status_check(){
if [ $? -eq 0 ]; then
    echo -e "\e[35m Success \e[0m"
    else
    echo -e "\e[36m Failure \e[0m"
    exit 1
fi
}