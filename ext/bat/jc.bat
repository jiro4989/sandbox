@echo off

cd %userprofile%\Documents\tmp
javac tmp.java -encoding utf-8

if %errorlevel% == 1 goto eof
echo success compile
java tmp

:eof
pause

