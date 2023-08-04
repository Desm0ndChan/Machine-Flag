# Disable Windows Firewall on all profiles
Write-Host "Disabling Windows Firewall"
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Disable Real-Time Monitoring
Write-Host "Disabling Windows Defender"
Set-MpPreference -DisableRealtimeMonitoring $true

# Disable Behavior Monitoring
Set-MpPreference -DisableBehaviorMonitoring $true

# Disable On Access Protection
Set-MpPreference -DisableOnAccessProtection $true

# Disable IOAV Protection
Set-MpPreference -DisableIOAVProtection $true

# Open registry key
$RegistryKeyPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"

# Disable Windows Security
New-ItemProperty -Path $RegistryKeyPath -Name "DisableAntiSpyware" -Value 1 -PropertyType DWORD -Force

Write-Host "Disabling IPv6"
Disable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6

Write-Host "Disabling Sleep Mode"
powercfg /Change monitor-timeout-ac 0
powercfg /Change monitor-timeout-dc 0
powercfg /Change standby-timeout-ac 0
powercfg /Change standby-timeout-dc 0
powercfg /Change hibernate-timeout-ac 0
powercfg /Change hibernate-timeout-dc 0

Write-Host "Disabling Windows Update"
sc stop WaasMedicSvc
sc stop wuauserv
sc stop UsoSvc
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\wuauserv" -Name "Start" -Value 4

Write-Host "Cleaning Up"
Remove-Item -path C:\inetpub\logs\LogFiles\* -recurse
Remove-Item "C:\Users\*\AppData\Roaming\Microsoft\Windows\Recent\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Users\*\AppData\Local\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\`$Recycle.Bin\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Users\*\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" -Force -ErrorAction SilentlyContinue