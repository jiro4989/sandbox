@echo off

set now=%date:~0,4%-%date:~5,2%-%date:~8,2%
cd %userprofile%\mydocs\note\day
start gvim %now%.md
