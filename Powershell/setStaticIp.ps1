# Define the interface index or adapter's name. Typically, Ethernet adapters might be named 'Ethernet' or 'Ethernet 0'. You might need to adapt this based on your system.
$interfaceIndex = (Get-NetAdapter | Where-Object {$_.Name -eq 'Ethernet'}).ifIndex

# Define static IP details
$ipAddress = "192.168.1.10"  # Desired static IP address
$prefixLength = 24  # CIDR notation for subnet mask. 24 corresponds to 255.255.255.0

# Set Static IP address
New-NetIPAddress -InterfaceIndex $interfaceIndex -IPAddress $ipAddress -PrefixLength $prefixLength -DefaultGateway $defaultGateway

Write-Output "Static IP Configuration Applied"
