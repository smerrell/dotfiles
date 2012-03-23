@echo off
set source=%1
set target=%2
set cmd=mklink /h

if exist %source%\NUL (set cmd=mklink /j)

set vim=%target:~-4%
if "%vim%" == ".vim" (set target=%target:.vim=vimfiles%)

%cmd% %target% %source%
