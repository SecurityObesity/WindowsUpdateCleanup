if (([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Managing the Windows Update Service configuration to Disabled"
    Set-Service -Name "wuauserv" -StartupType Disabled;
    Write-Host "Stopping the Windows Update Service"
    Stop-Service -Name "wuauserv";
    Write-Host
    Write-Host "Managing the Background Intelligent Transfer Service configuration to Disabled"
    Set-Service -Name "bits" -StartupType Disabled;
    Write-Host "Stopping the Background Intelligent Transfer Service"
    Stop-Service -Name "bits"
    Write-Host
    Write-Host "-- Removing ALL temporary files and Cache files to this operation"
    Remove-Item -Path "C:\Windows\WindowsUpdate.log" -Force
    Remove-Item -Path "C:\Windows\SoftwareDistribution\Download\*" -Recurse -Force
    Remove-Item -Path "C:\Windows\SoftwareDistribution\DataStore\DataStore.edb" -Force
    Remove-Item -Path "C:\Windows\SoftwareDistribution\DataStore\Logs\*" -Recurse -Force
    Remove-Item -Path "C:\Windows\SoftwareDistribution\PostRebootEventCache.V2\*" -Recurse -Force
    Write-Host
    Write-Host "Managing the Background Intelligent Transfer Service configuration to Automatic"
    Set-Service -Name "bits" -StartupType Automatic;
    Write-Host "Starting the Background Intelligent Transfer Service"
    Start-Service -Name "bits"
    Write-Host
    Write-Host "Managing the Windows Update Service configuration to Automatic"
    Set-Service -Name "wuauserv" -StartupType Automatic;
    Write-Host "Starting the Windows Update Service"
    Start-Service -Name "wuauserv";
    Write-Host
    Write-Host "The operation is successfully completed."
}
else
{
    Write-Host
    Write-Warning "The Program needs to be running with Administrator Privileges through User Account Control.";
    Write-Host "You need to start a new Powershell Console with Run As Administrator.";
    Write-Host
}
