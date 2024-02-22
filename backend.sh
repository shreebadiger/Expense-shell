echo -e "\e[34m Disabling Nodejs default version \e[0m"
dnf module disable nodejs -y &>> /tmp/expense.log

echo -e "\e[34m Enabling nodejs 18 version \e[0m"
dnf module enable nodejs:18 -y &>> /tmp/expense.log

echo -e "\e[34m Installing nodejs \e[0m"
dnf install nodejs -y &>> /tmp/expense.log

echo -e "\e[34m Copying backend config file \e[0m"
cp backend.service /etc/systemd/system/backend.service &>> /tmp/expense.log

echo -e "\e[34m Adding expense user \e[0m"
useradd expense &>> /tmp/expense.log

echo -e "\e[34m Creating directory \e[0m"
mkdir /app &>> /tmp/expense.log

echo -e "\e[32m Removing old content \e[0m"
rm -rf /app/* &>> /tmp/expense.log

echo -e "\e[34m Downloading and extracting backend file \e[0m"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip &>> /tmp/expense.log
cd /app &>> /tmp/expense.log
unzip /tmp/backend.zip &>> /tmp/expense.log

echo -e "\e[34m Installing nodejs dependencies \e[0m"
npm install &>> /tmp/expense.log

echo -e "\e[34m Installing mysql client \e[0m"
dnf install mysql -y &>> /tmp/expense.log

echo -e "\e[34m Loading the schema \e[0m"
mysql -h mysql-dev.sbadiger93.online -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> /tmp/expense.log


echo -e "\e[34m Restarting backend \e[0m"
systemctl daemon-reload &>> /tmp/expense.log
systemctl enable backend &>> /tmp/expense.log
systemctl restart backend &>> /tmp/expense.log

