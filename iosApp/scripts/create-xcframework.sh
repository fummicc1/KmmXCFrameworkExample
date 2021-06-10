#!/bin/bash

cd ../

./gradlew :shared:packForXCodeArm -PXCODE_CONFIGURATION=${CONFIGURATION}
./gradlew :shared:packForXCodeX64 -PXCODE_CONFIGURATION=${CONFIGURATION}
FRAMEWORK_NAME="shared"
ARM64PATH="./shared/build/xcode-frameworks-arm/${FRAMEWORK_NAME}.framework"
X64PATH="./shared/build/xcode-frameworks-X64/${FRAMEWORK_NAME}.framework"
UNIVERSAL_PATH="./shared/build/xcode-frameworks-universal/"

if [ -d ${UNIVERSAL_PATH} ]; then
    rm -rf ${UNIVERSAL_PATH}
fi

xcodebuild -create-xcframework -framework "${X64PATH}" -framework "${ARM64PATH}" -output "${UNIVERSAL_PATH}/${FRAMEWORK_NAME}.xcframework"
