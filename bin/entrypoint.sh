#! /bin/bash
service cron start
service rsyslog start
puma -C config/puma.rb
