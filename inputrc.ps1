# Up and Downs, we don't like arrow keys here
Set-PSReadLineKeyHandler -Key ctrl+p -Function PreviousHistory
Set-PSReadLineKeyHandler -Key ctrl+n -Function NextHistory

Set-PSReadLineKeyHandler -Key ctrl+j -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key ctrl+k -Function HistorySearchBackward

# Editing
Set-PSReadlineKeyHandler -Key ctrl+w -Function ShellKillWord
Set-PSReadlineKeyHandler -Key alt+d -Function BackwardWord
Set-PSReadlineKeyHandler -Key alt+f -Function NextWord

# Management Stuff
# Set-PSReadlineKeyHandler -Key ctrl+alt+h -Function

# Set-PSReadlineKeyHandler -Key ctrl+w -Function c


# Scrolling Handled by wt.exe
# Set-PSReadLineKeyHandler -Key ctrl+u -Function ScrollDisplayUp
# Set-PSReadLineKeyHandler -Key ctrl+d -Function ScrollDisplayDown

# Set-PSReadLineKeyHandler -Key ctrl+y -Function ScrollDisplayDownLine
# Set-PSReadLineKeyHandler -Key ctrl+e -Function ScrollDisplayUpLine
