#!/bin/sh

cp /etc/alertmanager/alertmanager.yml.tmpl /etc/alertmanager/alertmanager.yml

sed -i "s/\${SLACK_USERNAME}/${SLACK_USERNAME}/g" /etc/alertmanager/alertmanager.yml
sed -i "s/\${SLACK_CHANNEL}/${SLACK_CHANNEL}/g" /etc/alertmanager/alertmanager.yml
sed -i "s#\${SLACK_WEBHOOK}#${SLACK_WEBHOOK}#g" /etc/alertmanager/alertmanager.yml

cat /etc/alertmanager/alertmanager.yml
env

echo "===== Checking AlertManager configuration ====="
amtool check-config /etc/alertmanager/alertmanager.yml

echo "===== Starting AlertManager ====="
exec "$@"
