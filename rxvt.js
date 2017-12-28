var objShell = new ActiveXObject("shell.application");
objShell.ShellExecute("C:\Program Files (x86)/Xming/Xming.exe", ":0 -clipboard -multiwindow", "", "open", 0);
objShell.ShellExecute("bash.exe", "-c rxvt", "", "open", 0);