# Taken from: http://winterdom.com/2008/08/mypowershellprompt With a couple modifications.

$homeDir = "c:\Projects"

function shorten-path([string] $path) { 
   $loc = $path.Replace($HOME, '~') 
   # remove prefix for UNC paths 
   $loc = $loc -replace '^[^:]+::', '' 
   # make path shorter like tabs in Vim, 
   # handle paths starting with \\ and . correctly 
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2') 
}

function Test-Admin {
 $identity = [Security.Principal.WindowsIdentity]::GetCurrent()
 $principal = new-object Security.Principal.WindowsPrincipal $identity
 $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)   
}

function prompt { 
   # our theme 
   $cdelim = [ConsoleColor]::DarkCyan 
   $chost = [ConsoleColor]::Green 
   $cloc = [ConsoleColor]::Cyan 
   $time = get-date -u "%H:%M"
   # So we know if the shell is running as admin
   $adminTag = ""

   if (Test-Admin) {
      $origTitle = $Host.UI.RawUI.WIndowTitle;
      $chost = [ConsoleColor]::Red
      $adminTag = ">>>"
   }

   write-host "$adminTag [$time]" ([net.dns]::GetHostName()) -n -f $chost 
   write-host ' {' -n -f $cdelim 
   write-host ((pwd).Path) -n -f $cloc 
   write-host '}' -f $cdelim 
   return '$ ' 
}

cd $homeDir