#!/bin/bash

# Kotlin�̃C���X�g�[��
curl -s http://get.sdkman.io | bash
source $HOME/.sdkman/bin/sdkman-init.sh
sdk install kotlin
sudo apt-get install -y gradle

