#!/bin/bash

# Step 1: Check if OpenJDK 17 is installed
if ! java -version 2>&1 | grep -q '17'; then
    echo "OpenJDK 17 not found. Installing..."

    # Detect package manager and install OpenJDK 17
    if [ -x "$(command -v apt)" ]; then
        sudo apt update
        sudo apt install -y openjdk-17-jdk
    elif [ -x "$(command -v dnf)" ]; then
        sudo dnf install -y java-17-openjdk-devel
    elif [ -x "$(command -v yum)" ]; then
        sudo yum install -y java-17-openjdk-devel
    else
        echo "Unsupported package manager. Please install OpenJDK 17 manually."
        exit 1
    fi
else
    echo "OpenJDK 17 is already installed."
fi

# Step 2: Set OpenJDK 17 as the default Java version
echo "Setting OpenJDK 17 as the default Java version..."
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-17-openjdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-17-openjdk-amd64/bin/javac 1
sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java
sudo update-alternatives --set javac /usr/lib/jvm/java-17-openjdk-amd64/bin/javac

# Step 3: Add JAVA_HOME to ~/.bash_profile if not already present
JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
if ! grep -q "JAVA_HOME=$JAVA_HOME" ~/.bash_profile; then
    echo "Adding JAVA_HOME to ~/.bash_profile..."
    echo "export JAVA_HOME=$JAVA_HOME" >> ~/.bash_profile
    echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.bash_profile
else
    echo "JAVA_HOME is already set in ~/.bash_profile."
fi

# Step 4: Apply changes to the current session
source ~/.bash_profile

# Verify the setup
echo "Java version set to:"
java -version
echo "JAVA_HOME set to: $JAVA_HOME"
