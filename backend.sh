log_file="/tmp/expense.log"
color="\e[34m"

echo -e "${color} Disabling Nodejs default version \e[0m"
dnf module disable nodejs -y &>> $log_file
echo $?

echo -e "${color} Enabling nodejs 18 version \e[0m"
dnf module enable nodejs:18 -y &>> $log_file
echo $?

echo -e "${color} Installing nodejs \e[0m"
dnf install nodejs -y &>> $log_file
echo $?

echo -e "${color} Copying backend config file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>> $log_file
echo $?

echo -e "${color} Adding expense user \e[0m"
useradd expense &>> $log_file
echo $?

echo -e "${color} Creating directory \e[0m"
mkdir /app &>> $log_file
echo $?

echo -e "${color} Removing old content \e[0m"
rm -rf /app/* &>> $log_file
echo $?

echo -e "${color} Downloading and extracting backend file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>> $log_file
cd /app &>> /tmp/expense.log
unzip /tmp/backend.zip &>> $log_file
echo $?

echo -e "${color} Installing nodejs dependencies \e[0m"
npm install &>> $log_file
echo $?

echo -e "${color} Installing mysql client \e[0m"
dnf install mysql -y &>> $log_file
echo $?

echo -e "${color} Loading the schema \e[0m"
mysql -h mysql-dev.sbadiger93.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> /tmp/expense.log
echo $?


echo -e "${color} Restarting backend \e[0m"
systemctl daemon-reload &>> $log_file
systemctl enable backend &>> $log_file
systemctl restart backend &>> $log_file
echo $?

