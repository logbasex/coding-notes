## service and systemd
- https://www.digitalocean.com/community/tutorials/how-to-configure-a-linux-service-to-start-automatically-after-a-crash-or-reboot-part-1-practical-examples
- https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/chap-managing_services_with_systemd#sect-Managing_Services_with_systemd-Introduction-Features


## Command
```shell
# list all service
sudo systemctl list-unit-files --type=service

# list all service and status
sudo service --status-all

# list only enable service
sudo systemctl list-unit-files --type=service --state=enabled --all

# If the application in question is able to reload its configuration files (without restarting), you can issue the reload command to initiate that process:

sudo systemctl reload application.service
```
- https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units