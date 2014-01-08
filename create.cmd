@echo off
set path=%path%;%~dp0
for /f "tokens=*" %%a in ('^
wget -qO- http://www.partitionwizard.com/free-partition-manager.html ^|
sed "s/\d034/\n/g" ^|
grep "download.*cnet.*com.*Partition-Wizard-Home-Edition"  ^|
sed "s/\d038/%%26/g"') do for /f "tokens=*" %%b in ('^
wget -qO- %%a ^|
sed "s/\d034/\n/g" ^|
grep "dw.*cbsi.*com.*redir" ^|
sed "s/.*destUrl=//g;" ^|
sed "s/\d038/%%26/g" ^|
sed "s/%%3A/:/g" ^|
sed "s/%%2F/\//g"') do for /f "tokens=*" %%c in ('^
wget -qO- %%b ^|
sed "s/[\d039]/\n/g" ^|
grep "^http.*exe" ^|
sed "s/^.*fileName=//g"') do (
wget http://www.partitionwizard.com/download/%%c -O "%~dp0%%c"
)

set t=%~dp0tmp
if exist "%t%" rd "%t%" /Q /S
for /f "delims=" %%f in ('dir /b "%~dp0pwhe*.exe"') do (
innounp -x -y -c -d"%t%" "%~dp0%%f"
)
mv "%t%\{app}" "%~dp0\PWP"
rd "%t%" /Q /S
pause
