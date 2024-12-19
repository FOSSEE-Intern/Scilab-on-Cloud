#!/bin/bash
export WORKING_DIR="/scilab-on-cloud"
export SOC_PID="/tmp/scilab.on/cloud.pid"
sed -i "s/ALLOWED_HOSTS.*/ALLOWED_HOSTS = ['*']/g" /Sites/scilab-on-cloud/soc/settings.py
sed -i 's/SESSION/#SESSION/' /Sites/scilab-on-cloud/soc/settings.py
sleep 30
python3 manage.py makemigrations website
python3 manage.py migrate
export DJANGO_SETTINGS_MODULE=soc.settings &&
python3 tornado_main.py

