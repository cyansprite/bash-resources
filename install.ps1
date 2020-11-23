# NOTE: remove ' for syntax highlighting

$scriptblock = '
# So we can use it manually in our profile.ps1
Set-Service ssh-agent -StartupType Manual

# Profiles for powershell.exe and pwsh
Remove-Item C:\Users\Brand\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Force
cmd /c mklink C:\Users\Brand\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 C:\Users\Brand\Documents\bash-resources\profile.ps1
Remove-Item C:\Users\Brand\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 -Force
cmd /c mklink C:\Users\Brand\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 C:\Users\Brand\Documents\bash-resources\profile.ps1

# Windows terminal
Remove-Item C:\Users\Brand\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Force
cmd /c mklink C:\Users\Brand\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json C:\Users\Brand\Documents\bash-resources\wtsettings.json

# Neovim
New-Item -ItemType Directory -Force -Path C:\Users\Brandon\AppData\Local\nvim
Remove-Item C:\Users\Brand\AppData\Local\nvim\init.vim -Force
cmd /c mklink C:\Users\Brand\AppData\Local\nvim\init.vim C:\Users\Brand\Documents\bash-resources\nvim-plugs\init.vim
Remove-Item C:\Users\Brand\AppData\Local\nvim\plug.vim -Force
cmd /c mklink C:\Users\Brand\AppData\Local\nvim\plug.vim C:\Users\Brand\Documents\bash-resources\nvim-plugs\plug.vim

# Plug
Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
New-Item "$env:LOCALAPPDATA/nvim-data/site/autoload/plug.vim" -Force

# DotFiles
Remove-Item C:\Users\brand\.gitconfig -Force
cmd /c mklink C:\Users\brand\.gitconfig C:\Users\brand\Documents\bash-resources\.gitconfig

Write-Output "================================================="
Write-Output "Finished"
'

$sh = new-object -com 'Shell.Application'
$sh.ShellExecute('powershell', "-NoExit -Command $scriptblock", '', 'runas')
