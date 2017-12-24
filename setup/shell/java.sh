#!/bin/bash

# java
# ------------------------------------------------------------
#sudo apt-get update -y
#sudo apt-get install software-properties-common python-software-properties -y
#sudo add-apt-repository ppa:webupd8team/java -y
#sudo apt-get install oracle-java8-installer -y

javaapts=(
  "junit4"
  "ant"
  "maven"
  "openjdk-8-jdk"
  "openjfx"
)
for apt in ${javaapts[@]}; do
  sudo apt-get install $apt -y
done

