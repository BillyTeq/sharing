#!/bin/sh

/var/ossec/bin/ossec-control start

/var/ossec/bin/ossec-authd -n 


tail -f /var/ossec/logs/ossec.log
