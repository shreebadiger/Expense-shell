echo -e "\e[33m Disabling mysql default version  \e[0m"
dnf module disable mysql -y  &>> /tmp/expense.log

echo -e "\e[33m Create mysql Repo  \e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>> /tmp/expense.log

echo -e "\e[33m Installing mysql \e[0m"
dnf install mysql-community-server -y &>> /tmp/expense.log

echo -e "\e[33m Enabling and Starting mysql  \e[0m"
systemctl enable mysqld &>> /tmp/expense.log
systemctl start mysqld &>> /tmp/expense.log

echo -e "\e[33m Setting up username and password to mysql database \e[0m"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>> /tmp/expense.log

