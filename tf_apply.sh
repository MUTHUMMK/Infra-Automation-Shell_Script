#!/bin/bash

cd /home/ubuntu/cron/staging/infra
sh create.sh


cd /home/ubuntu/cron/staging/dev
sh test.sh
sh terraform-notify.sh start