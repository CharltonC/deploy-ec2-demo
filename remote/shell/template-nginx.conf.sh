#!/bin/bash

# Template of a Nginx config file "<djangoProjectName>"

echo "$(cat <<EOF
server {
	listen $APP_PORT;
	server_name $APP_IP_ADDR;

	location = /favicon.ico {
		access_log off;
		log_not_found off;
	}

	location /$DJ_STATIC_FOLDER/ {
		root $PROJECT_DJANGO_FOLDER_PATH;
	}

	location /$DJ_MEDIA_FOLDER/ {
		root $PROJECT_DJANGO_FOLDER_PATH;
	}

	location / {
		include proxy_params;
		proxy_pass http://unix:$PROJECT_FOLDER_PATH/$PROJECT_DJANGO_FOLDER.sock;
	}
}
EOF
)"
