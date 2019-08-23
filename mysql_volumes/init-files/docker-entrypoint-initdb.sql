update user set authentication_string=PASSWORD("root_pass") where User='root';
GRANT ALL PRIVILEGES ON *.* TO 'derivco_user'@'%' IDENTIFIED BY 'derivco_pass' WITH GRANT OPTION;
create database IF NOT EXISTS football CHARACTER SET utf8 COLLATE utf8_general_ci;
FLUSH PRIVILEGES