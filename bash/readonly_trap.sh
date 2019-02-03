#!/bin/bash

RESULT=`mkdir piyo; mkdir piyo`
echo normal: $?
readonly RESULT=`mkdir hoge; mkdir hoge`
echo readonly: $?
