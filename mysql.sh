log_file="/tmp/expense.log"
color="\e[33m"

echo -e "${color} Disabling mysql default version  \e[0m"
dnf module disable mysql -y  &>> $log_file
echo $?

echo -e "${color} Create mysql Repo  \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>> $log_file
echo $?

echo -e "${color} Installing mysql \e[0m"
dnf install mysql-community-server -y &>> $log_file
echo $?

echo -e "${color} Enabling and Starting mysql  \e[0m"
systemctl enable mysqld &>> $log_file
systemctl start mysqld &>> $log_file
echo $?

echo -e "${color} Setting up username and password to mysql database \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>> $log_file
echo $?

