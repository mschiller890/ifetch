#!/bin/bash

# Printing using ANSI color codes
print_in_color() {
    echo -e "\e[1;${1}m${2}\e[0m"
}

# Getting the system's hostname
get_hostname() {
    cat /proc/sys/kernel/hostname
}

# Getting the operating system and kernel version
get_os_info() {
    os=$(uname -s)
    kernel=$(uname -r)
    echo "$os $kernel"
}

# Getting uptime
get_uptime() {
    uptime=$(uptime -p | sed 's/up //')
    echo "$uptime"
}

# Getting the shell being used
get_shell() {
    echo "$SHELL"
}

# Getting CPU information
get_cpu_info() {
    cpu=$(lscpu | grep 'Model name' | awk -F: '{print $2}' | sed 's/^[ \t]*//')
    echo "$cpu"
}

# Getting memory usage
get_memory_info() {
    memory=$(free -h | grep Mem | awk '{print $3 "/" $2}')
    echo "$memory"
}

# Getting disk usage
get_disk_info() {
    disk=$(df -h --total | grep 'total' | awk '{print $3 "/" $2}')
    echo "$disk"
}

# Getting screen resolution
get_resolution() {
    if command -v xrandr &> /dev/null; then
        resolution=$(xrandr | grep '*' | awk '{print $1}')
    else
        resolution="N/A (xrandr not found)"
    fi
    echo "$resolution"
}

# Getting the desktop environment
get_de() {
    echo "$XDG_CURRENT_DESKTOP"
}

# Getting the username
get_username() {
    user=$(whoami)
    echo "$user"
}

# Getting battery status
get_battery_info() {
    if [ -f /sys/class/power_supply/BAT0/status ]; then
        battery_status=$(cat /sys/class/power_supply/BAT0/status)
        battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)
        echo "$battery_status - $battery_capacity%"
    else
        echo "Battery information not available."
    fi
}

# Getting network information
# Doesn't work, will fix later.
get_network_info() {
    ip=$(hostname | awk '{print $1}')
    network_info="IP Address: $ip"
    echo "$network_info"
}

# Collect system information
hostname=$(get_hostname)
os_info=$(get_os_info)
uptime_info=$(get_uptime)
shell_info=$(get_shell)
cpu_info=$(get_cpu_info)
memory_info=$(get_memory_info)
disk_info=$(get_disk_info)
resolution_info=$(get_resolution)
de_info=$(get_de)
user_info=$(get_username)
battery_info=$(get_battery_info)
# network_info=$(get_network_info)

# Custom ASCII logo with system info and color codes
text="
         /\\          $(print_in_color 33 'Host:') $hostname
        /  \\         $(print_in_color 33 'OS:') $os_info
       /\\   \\        $(print_in_color 33 'Uptime:') $uptime_info
      /      \\       $(print_in_color 33 'Shell:') $shell_info
     /   ,,   \\      $(print_in_color 33 'CPU:') $cpu_info
    /   |  |  -\\     $(print_in_color 33 'Memory:') $memory_info
   /_-''    ''-_\\    $(print_in_color 33 'Disk:') $disk_info
                     $(print_in_color 33 'Resolution:') $resolution_info
                     $(print_in_color 33 'Desktop Environment:') $de_info
                     $(print_in_color 33 'User:') $user_info
                     $(print_in_color 33 'Battery:') $battery_info"

# Print the wall of text
echo "$text"
