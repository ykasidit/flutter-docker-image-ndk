#!/bin/bash

# Define the paths for Android SDK, platform-tools, and NDK
ANDROID_SDK="$HOME/android-sdk"
PLATFORM_TOOLS="$ANDROID_SDK/platform-tools"
NDK_BIN="$ANDROID_SDK/ndk/26.2.11394342"

# Step 1: Check if the Android SDK is installed
if [ -d "$ANDROID_SDK" ]; then
    echo "Android SDK found at $ANDROID_SDK."
else
    echo "Android SDK not found. Please ensure it's installed at $ANDROID_SDK."
    exit 1
fi

# Step 2: Check if platform-tools are available in the SDK
if [ -d "$PLATFORM_TOOLS" ]; then
    echo "Platform-tools found in Android SDK."
else
    echo "Platform-tools not found. Please ensure it's installed in $PLATFORM_TOOLS."
    exit 1
fi


# Step 4: Add Android SDK, platform-tools, and NDK to PATH in ~/.bash_profile if not already present
if ! grep -q "$ANDROID_SDK" ~/.bash_profile; then
    echo "Adding $ANDROID_SDK, platform-tools, and NDK to PATH in ~/.bash_profile..."
    echo "export ANDROID_HOME=$ANDROID_SDK" >> ~/.bash_profile
    echo "export PATH=\$PATH:$ANDROID_SDK/tools" >> ~/.bash_profile
    echo "export PATH=\$PATH:$ANDROID_SDK/tools/bin" >> ~/.bash_profile
    echo "export PATH=\$PATH:$PLATFORM_TOOLS" >> ~/.bash_profile
    echo "export PATH=\$PATH:$NDK_BIN" >> ~/.bash_profile
else
    echo "Android SDK, platform-tools, and NDK are already in the PATH."
fi

# Step 5: Apply changes to the current session
echo "Applying changes to the current session..."
source ~/.bash_profile

# Step 6: Verify the updated PATH
echo "Updated PATH:"
echo $PATH

# Step 7: Verify adb command (part of platform-tools)
if command -v adb &> /dev/null; then
    echo "adb is successfully added to the PATH."
else
    echo "adb not found in the PATH. Please check your setup."
fi

# Step 8: Verify ndk-build command (part of NDK)
if command -v ndk-build &> /dev/null; then
    echo "ndk-build is successfully added to the PATH."
else
    echo "ndk-build not found in the PATH. Please check your NDK installation."
fi
