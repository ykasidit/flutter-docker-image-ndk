#!/bin/bash

# Define the path you want to add
FLUTTER_PATH="$HOME/flutter/bin"

# Check if ~/flutter/bin is already in the PATH in .bash_profile
if ! grep -q "$FLUTTER_PATH" ~/.bash_profile; then
    echo "Adding $FLUTTER_PATH to PATH in ~/.bash_profile"
    
    # Add the export line to the .bash_profile
    echo "export PATH=\$PATH:$FLUTTER_PATH" >> ~/.bash_profile
else
    echo "$FLUTTER_PATH is already in the PATH."
fi

# Apply the changes to the current session
echo "Applying changes to the current session..."
source ~/.bash_profile

# Verify the updated PATH
echo "Updated PATH:"
echo $PATH
