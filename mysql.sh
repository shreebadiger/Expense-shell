source common.sh
if [ -z "$1" ]; then
echo -e "\e[35m Password Missing \e[0m"
exit
fi
MY_SQL_PASSWORD=$1

echo -e "${color} Disabling mysql default version  \e[0m"
dnf module disable mysql -y  &>> $log_file
status_check

echo -e "${color} Create mysql Repo  \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>> $log_file
status_check

echo -e "${color} Installing mysql \e[0m"
dnf install mysql-community-server -y &>> $log_file
status_check

echo -e "${color} Enabling and Starting mysql  \e[0m"
systemctl enable mysqld &>> $log_file
systemctl start mysqld &>> $log_file
status_check

echo -e "${color} Setting up username and password to mysql database \e[0m"
mysql_secure_installation --set-root-pass ${MY_SQL_PASSWORD} &>> $log_file
status_check


