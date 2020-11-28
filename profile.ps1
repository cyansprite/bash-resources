# MODULES
Import-Module PSReadLine
Import-Module PSFzf

# SSH
ssh-agent
# ssh-add

# PROMPT
function prompt
{
    Write-Host ("[" + $(get-date -Format "HH:mm:ss") + "] ") -nonewline -foregroundcolor Cyan
    Write-Host ($PWD) -nonewline -foregroundcolor Yellow
    return " \> "
}

# ALIASES
Set-Alias -Name l -Value Get-ChildItem

Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

# INPUT
# Up and Downs, we don't like arrow keys here
Set-PSReadLineKeyHandler -Key ctrl+p -Function PreviousHistory
Set-PSReadLineKeyHandler -Key ctrl+n -Function NextHistory

Set-PSReadLineKeyHandler -Key ctrl+j -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key ctrl+k -Function HistorySearchBackward

# Editing
Set-PSReadlineKeyHandler -Key ctrl+w -Function BackwardKillWord
Set-PSReadlineKeyHandler -Key ctrl+u -Function BackwardKillLine
Set-PSReadlineKeyHandler -Key ctrl+k -Function KillLine

Set-PSReadlineKeyHandler -Key alt+d -Function KillWord
Set-PSReadlineKeyHandler -Key alt+b -Function BackwardWord
Set-PSReadlineKeyHandler -Key alt+f -Function NextWord

Set-PSReadlineKeyHandler -Key ctrl+e -Function EndOfLine
Set-PSReadlineKeyHandler -Key ctrl+a -Function BeginningOfLine

Set-PSReadlineKeyHandler -Key ctrl+f -Function CharacterSearch
Set-PSReadlineKeyHandler -Key ctrl+F -Function CharacterSearchBackward

# Management Stuff
# Set-PSReadlineKeyHandler -Key ctrl+alt+h -Function

# Set-PSReadlineKeyHandler -Key ctrl+w -Function c

# Scrolling Handled by wt.exe
# Set-PSReadLineKeyHandler -Key ctrl+u -Function ScrollDisplayUp
# Set-PSReadLineKeyHandler -Key ctrl+d -Function ScrollDisplayDown

# Set-PSReadLineKeyHandler -Key ctrl+y -Function ScrollDisplayDownLine
# Set-PSReadLineKeyHandler -Key ctrl+e -Function ScrollDisplayUpLine

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
