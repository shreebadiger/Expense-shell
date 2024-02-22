echo -e "\e[32m Installing Nginx \e[0m"
dnf install nginx -y &>> /tmp/expense.log

echo -e "\e[32m Copying nginx config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>> /tmp/expense.log

echo -e "\e[32m Removing nginx default content \e[0m"
rm -rf /usr/share/nginx/html/* &>> /tmp/expense.log

echo -e "\e[32m Downloading Expense content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip  &>> /tmp/expense.log

echo -e "\e[32m Extracting Expense content \e[0m"
cd /usr/share/nginx/html/ &>> /tmp/expense.log
unzip /tmp/frontend.zip &>> /tmp/expense.log

echo -e "\e[32m Restarting Nginx \e[0m"
systemctl enable nginx &>> /tmp/expense.log
systemctl restart nginx &>> /tmp/expense.log

