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

## Systemd timers vs Crontab

- https://trstringer.com/systemd-timer-vs-cronjob/
- https://unix.stackexchange.com/questions/278564/cron-vs-systemd-timers

## [systemd-tmpfiles - Managing Temporary Files & Directories](https://www.putorius.net/systemd-tmpfiles.html)

- **systemd-tmpfiles-setup-dev.service** - Creates Static Device Nodes in /dev
- **systemd-tmpfiles-setup.service** - Creates Volatile Files and Directories
- **systemd-tmpfiles-clean.service** - Cleanup of Temporary Directories
- **systemd-tmpfiles-clean.timer** - Timer unit to trigger systemd-tmpfiles-clean.service

```shell
systemctl cat systemd-tmpfiles-setup.service

# A systemd timer unit called systemd-tmpfiles-clean.timer triggers the systemd-tmpfiles-clean.service on a regular interval,
# which then executes the systemd-tmpfiles–clean command.
systemctl show -p TriggeredBy systemd-tmpfiles-clean
systemctl cat systemd-tmpfiles-clean.service

# The timer will start systemd-tmpfiles-clean.service 15 minutes after boot, and every 24 hours afterward

# [Timer]
# OnBootSec=15min
# OnUnitActiveSec=1d
systemctl cat systemd-tmpfiles-clean.timer

# Trigger: Tue 2022-09-13 20:30:32 +07; 11min left
systemctl status systemd-tmpfiles-clean.timer

journalctl -u systemd-tmpfiles-clean.timer
journalctl -u systemd-tmpfiles-clean.service
```

Using [**/var/tmp**](https://unix.stackexchange.com/questions/30489/what-is-the-difference-between-tmp-and-var-tmp) for store files in the long-time instead of **/tmp** 