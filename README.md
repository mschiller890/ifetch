# ifetch
Lightweight (and bad) alternative to neofetch.

# Features
Basically same as neofetch, currently aimed to be used on Arch.
The list of information includes:
- Hostname (`cat /proc/sys/kernel/hostname`)
- OS and kernel info (`os=$(uname -s)`, `kernel=$(uname -r)`)
- Uptime (`uptime -p | sed 's/up //'`)
- Shell (`echo $SHELL`)
- CPU info (`lscpu | grep 'Model name' | awk -F: '{print $2}' | sed 's/^[ \t]*//'`)
- RAM info (`free -h | grep Mem | awk '{print $3 "/" $2}'`)
- Disk info (`df -h --total | grep 'total' | awk '{print $3 "/" $2}'`)
- Resolution, requires xrandr (`xrandr | grep '*' | awk '{print $1}'`)
- Desktop environment (`echo "$XDG_CURRENT_DESKTOP"`)
- Username (`whoami`)
- Battery status and capacity (`battery_status=$(cat /sys/class/power_supply/BAT0/status)`, `battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity`)

![image](https://github.com/user-attachments/assets/994fd84c-f3a2-4f3e-9710-5d0ed0c688a2)
