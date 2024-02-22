echo -e "\e[32m Installing Nginx \e[0m"
dnf install nginx -y

echo -e "\e[32m Copying nginx config file \e[0m"
cp expense.conf /etc/nginx/default.d/expense.conf

echo -e "\e[32m Removing nginx default content \e[0m"
rm -rf /usr/share/nginx/html/*

echo -e "\e[32m Downloading Expense content \e[0m"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip 

echo -e "\e[32m Extracting Expense content \e[0m"
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip

echo -e "\e[32m Restarting Nginx \e[0m"
systemctl enable nginx
systemctl restart nginx

