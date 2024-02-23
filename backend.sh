log_file="/tmp/expense.log"
color="\e[34m"

if [ -z "$1" ]; then
echo -e "\e[35m Password Missing \e[0m"
exit
fi
MY_SQL_PASSWORD=$1
status_check(){
if [ $? -eq 0 ]; then
    echo -e "\e[35m Success \e[0m"
    else
    echo -e "\e[36m Failure \e[0m"
fi
}


echo -e "${color} Disabling Nodejs default version \e[0m"
dnf module disable nodejs -y &>> $log_file
status_check

echo -e "${color} Enabling nodejs 18 version \e[0m"
dnf module enable nodejs:18 -y &>> $log_file
status_check

echo -e "${color} Installing nodejs \e[0m"
dnf install nodejs -y &>> $log_file
status_check

echo -e "${color} Copying backend config file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>> $log_file
status_check

id expense &>> $log_file
if [ $? -ne 0 ]; then
   echo -e "${color} Adding expense user \e[0m"
   useradd expense &>> $log_file
status_check
fi

if [ ! -d /app ]; then
echo -e "${color} Creating directory \e[0m"
mkdir /app &>> $log_file
status_check
fi

echo -e "${color} Removing old content \e[0m"
rm -rf /app/* &>> $log_file
status_check

echo -e "${color} Downloading and extracting backend file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>> $log_file
cd /app &>> /tmp/expense.log
unzip /tmp/backend.zip &>> $log_file
status_check

echo -e "${color} Installing nodejs dependencies \e[0m"
npm install &>> $log_file
status_check

echo -e "${color} Installing mysql client \e[0m"
dnf install mysql -y &>> $log_file
status_check

echo -e "${color} Loading the schema \e[0m"
mysql -h mysql-dev.sbadiger93.online -uroot -p${MY_SQL_PASSWORD} < /app/schema/backend.sql &>> $log_file
status_check


echo -e "${color} Restarting backend \e[0m"
systemctl daemon-reload &>> $log_file
systemctl enable backend &>> $log_file
systemctl restart backend &>> $log_file
status_check

