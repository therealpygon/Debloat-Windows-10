#Requires -RunAsAdministrator

# Description
# ===========
# This script removes OneDrive leftover files
# It has to executed after long after script 4 to allow the uninstall process to complete

Import-Module -DisableNameChecking $PSScriptRoot\..\lib\common-lib.psm1 -Force

Print-Script-Banner($MyInvocation.MyCommand.Name)

#=============================================================================

if ($testModeEnabled) {
    Write-Debug "testModeEnabled"
    return
}

if($skipOneDriveUnintall) {
    Write-Host "One drive leftover removal skipped"
}

#Necessary to succeed in files removal
Stop-Process -name explorer
Start-Sleep -s 3

# Removing OneDrive leftovers
foreach ($directory in (Get-ChildItem "$env:WinDir\WinSxS\*onedrive*")) {
    Remove-Item -ErrorAction SilentlyContinue -Recurse -Force $directory.FullName
}

$userLocalAppData="$userHomeFolder\AppData\Local"
$localUserOneDriveFolder = "$userLocalAppData\Microsoft\OneDrive"
if (Test-Path $localUserOneDriveFolder) {
    Remove-Item -Recurse -Force  $localUserOneDriveFolder
}