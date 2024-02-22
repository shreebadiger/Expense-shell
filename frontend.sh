log_file="/tmp/expense.log"
color="\e[32m"

echo -e "${color} Installing Nginx \e[0m"
dnf install nginx -y &>> $log_file
echo $?

echo -e "${color} Copying nginx config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf &>> $log_file
echo $?

echo -e "${color} Removing nginx default content \e[0m"
rm -rf /usr/share/nginx/html/* &>> $log_file
echo $?

echo -e "${color} Downloading Expense content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip  &>> $log_file
echo $?

echo -e "${color} Extracting Expense content \e[0m"
cd /usr/share/nginx/html/ &>> $log_file
unzip /tmp/frontend.zip &>> $log_file
echo $?

echo -e "${color} Restarting Nginx \e[0m"
systemctl enable nginx &>> $log_file
systemctl restart nginx &>> $log_file
echo $?

