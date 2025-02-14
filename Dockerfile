FROM ubuntu:18.04

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget

# Setup new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/Sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/Sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Setup Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/Sdk/tools
RUN cd Android/Sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/Sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"

# Run basic check to download Dark SDK
RUN flutter doctor
# Web dev version
RUN flutter channel stable
RUN flutter upgrade

# Install chrome as root due deb package
# USER root

# RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O ./google-chrome-stable_current_amd64.deb
# RUN dpkg -i ./google-chrome-stable_current_amd64.deb
# USER developer
# Check if chrome is installed
# RUN flutter devices
# running in chrome
# RUN flutter run -d chrome

##################################
# HOW TO WAKE UP SERVER
# KEEP READING README.MD
##################################
