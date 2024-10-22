#!/bin/bash

set -e
IMG=`cat IMAGE`
TARGET_ANDROID_SDK_PATH=$HOME/android-sdk
TARGET_FLUTTER_PATH=$HOME/flutter

read -p "This will REMOVE $TARGET_ANDROID_SDK_PATH, REMOVE $TARGET_FLUTTER_PATH, install/set default java, change ~/.bashrc - please review/proceed at your own risk. Proceed? (y/n)" -n 1 -r
echo    # (optional) move to a new line

# https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi


source ./setup_host_java.sh
sudo docker rm -f android-sdk || echo "ok"

CMD="sudo docker run --name android-sdk --rm -d $IMG tail -f /dev/null"
echo "final CMD:"
echo "$CMD"
$CMD
echo "rm old dirs"
rm -rf $TARGET_FLUTTER_PATH
rm -rf $TARGET_ANDROID_SDK_PATH
echo "copy new dirs"
sudo docker cp android-sdk:/opt/android-sdk-linux $TARGET_ANDROID_SDK_PATH
sudo docker cp android-sdk:/usr/local/flutter $TARGET_FLUTTER_PATH
sudo chown -R $USER $TARGET_ANDROID_SDK_PATH
sudo chmod -R 755 $TARGET_ANDROID_SDK_PATH
sudo chown -R $USER $TARGET_FLUTTER_PATH
sudo chmod -R 755 $TARGET_FLUTTER_PATH
source ./setup_android_sdk.sh
source ./setup_flutter.sh

# add to .bashrc if not present
grep -qxF 'if [ -f ~/.bash_profile ]; then source ~/.bash_profile; fi' ~/.bashrc || echo 'if [ -f ~/.bash_profile ]; then source ~/.bash_profile; fi' >> ~/.bashrc

flutter doctor

echo "SUCCESS - android sdk/ndk flutter ready - pls close this terminal and open a new one and try below command to confirm:"
echo "flutter doctor"
