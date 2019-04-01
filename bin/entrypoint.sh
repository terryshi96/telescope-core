#! /bin/bash
rsyslogd
cron
touch /var/log/cron.log
puma -C config/puma.rb
