#!/bin/bash

cd /home/ubuntu/cron/staging/infra
sh destroy.sh

cd /home/ubuntu/cron/staging/dev
sh terraform-notify.sh terminate