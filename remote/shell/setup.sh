#!/bin/bash

######################
# PURPOSE
######################
# Configuration using Variables for DJANGO Deployment for Stack using:
#   - Ubuntu
#   - Python (with Python VirtualEnv)
#   - Django
#   - PostgreSQL Database
#   - Gunicorn
#   - Nginx
# This setup aggregates all partial setups (e.g. ubuntu, python) into one single file
# This is where EDIT/CHANGE should be made


######################
# USAGE
######################
# See "README.md" file


######################
# CONFIG - VARIABLES
######################
# Naming Convention
# - Value    e.g. 'text' | 123 | "$VAR" | etc
# - Folder   e.g. 'foldername'
# - File     e.g. 'file.ext'
# - Path     e.g. '/path/subpath',  '/path/subpath/file.ext'
#
# Path
# - Doesn't work (quotes):       ~"/$PROJECT_ROOT_FOLDER/$PROJECT_FOLDER"
# - Works (quotes + absolute):   "/home/$UBUNTU_USERNAME/$PROJECT_ROOT_FOLDER/$PROJECT_FOLDER"
# - Works (no quotes + ${}):     ~/${PROJECT_ROOT_FOLDER}/${PROJECT_FOLDER}
# - Works (hard code):           ~/dev/deploy-ec2

# Ubuntu
UBUNTU_APT_DEP_LIST='python3-pip python3-dev libpq-dev postgresql postgresql-contrib nginx'
UBUNTU_USERNAME='ubuntu'

# Project
PROJECT_ROOT_FOLDER='dev'
PROJECT_FOLDER='deploy-ec2'
PROJECT_DJANGO_FOLDER='deploy_ec2'
PROJECT_FOLDER_PATH="/home/$UBUNTU_USERNAME/$PROJECT_ROOT_FOLDER/$PROJECT_FOLDER"
PROJECT_SHELL_FOLDER_PATH="$PROJECT_FOLDER_PATH/remote/shell"
PROJECT_DJANGO_FOLDER_PATH="$PROJECT_FOLDER_PATH/$PROJECT_DJANGO_FOLDER"

# Python
PY_VENV_FOLDER='venv'
PY_VENV_DEP_LIST_FILE_PATH="$PROJECT_FOLDER_PATH/remote/requirements.txt"

# Aws
APP_IP_SELF='0.0.0.0'
APP_IP_ADDR=${1:-''}  # from command-line argument
APP_PORT=80

# Django
DJ_SETTINGS_FILE_PATH="$PROJECT_DJANGO_FOLDER_PATH/$PROJECT_DJANGO_FOLDER/settings.py"
DJ_STATIC_FOLDER='static'
DJ_MEDIA_FOLDER='media'
DJ_SUPERUSER_USERNAME='djsuperuser'
DJ_SUPERUSER_PASSWORD='djsuperuser1234'
DJ_SUPERUSER_EMAIL='xyz@xyz.com'

# Database
DB_SHELL_USERNAME='postgres'
DB_NAME='dbtest'
DB_USERNAME='dbtestuser'
DB_PASSWORD='dbtestpassword'

# Http Server - Gunicorn
GUNICORN_SOCKET_CONF_TEMPLATE_FILE_PATH="$PROJECT_SHELL_FOLDER_PATH/template-gunicorn.socket.sh"
GUNICORN_SERVICE_CONF_TEMPLATE_FILE="$PROJECT_SHELL_FOLDER_PATH/template-gunicorn.service.sh"
GUNICORN_SERVICE_CONF_FILE_PATH='/etc/systemd/system/gunicorn.service'

# Proxy Server - Nginx
NGINX_CONF_TEMPLATE_FILE_PATH="$PROJECT_SHELL_FOLDER_PATH/template-nginx.conf.sh"
NGINX_CONF_FILE_PATH="/etc/nginx/sites-available/$PROJECT_DJANGO_FOLDER"
NGINX_SITE_ROOT_PATH='/etc/nginx/sites-enabled'

# Message when setup is Complete
logStart() {
    echo -e "\e[95m$1 setup started\e[0m"
}
logEnd() {
    echo -e "\e[95m$1 setup completed\e[0m\n"
}


######################
# TASKS
######################
source $PROJECT_SHELL_FOLDER_PATH/setup-ubuntu.sh
source $PROJECT_SHELL_FOLDER_PATH/setup-python.sh
source $PROJECT_SHELL_FOLDER_PATH/setup-database.sh
source $PROJECT_SHELL_FOLDER_PATH/setup-gunicorn.sh
source $PROJECT_SHELL_FOLDER_PATH/setup-nginx.sh
source $PROJECT_SHELL_FOLDER_PATH/setup-django.sh
logEnd 'All'