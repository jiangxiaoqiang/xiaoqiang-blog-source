
PROGRAM_NAME="credit-system"
DEPLOY_PATH="/opt/app/backend/credit-system/"
DEPLOY_SOURCE_PATH="/home/dolphin/source/hldev/credit-system"
START_SCRIPT_PATH="/opt/app/backend/credit-system/stop.sh"
STOP_SCRIPT_PATH="/opt/app/backend/credit-system/stop.sh"
BUILD_SCRIPT="/home/dolphin/source/hldev/credit-system/build-jar.sh"

cd $DEPLOY_SOURCE_PATH
bash $BUILD_SCRIPT

# stop website
if [ ! -f "$STOP_SCRIPT_PATH" ]; then
	echo "$STOP_SCRIPT_PATH is not exits"
else
	STOP_SCRIPT_PATH
fi
# backup website program
# mv /opt/app/backend/credit-system/stop.sh

# fetch the latest program

# start program


