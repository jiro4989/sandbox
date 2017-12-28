@echo off

kotlinc-jvm %1 -include-runtime -d %~n1.jar
if %errorlevel% == 1 goto eof
echo success compile
java -jar %~n1.jar

:eof
