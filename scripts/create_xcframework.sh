#!/bin/bash

cd "${SRCROOT}/../"

./gradlew :shared:packForXCodeArm -PXCODE_CONFIGURATION=${CONFIGURATION}
./gradlew :shared:packForXCodeX64 -PXCODE_CONFIGURATION=${CONFIGURATION}
FRAMEWORK_NAME="shared"
ARM64PATH="./shared/build/xcode-frameworks-arm/${FRAMEWORK_NAME}.framework"
X64PATH="./shared/build/xcode-frameworks-X64/${FRAMEWORK_NAME}.framework"
UNIVERSAL_PATH="./shared/build/xcode-frameworks-universal/"

if [ -d ${UNIVERSAL_PATH} ]; then
    rm -rf ${UNIVERSAL_PATH}
fi

xcodebuild -create-xcframework -framework "${ARM64PATH}" -framework "${X64PATH}" -output "${UNIVERSAL_PATH}/${FRAMEWORK_NAME}.xcframework"

cd "${UNIVERSAL_PATH}/${FRAMEWORK_NAME}.xcframework"

PlistBuddy="/usr/libexec/PlistBuddy"

${PlistBuddy} -c "Copy :AvailableLibraries:1 :AvailableLibraries:2" "Info.plist"
${PlistBuddy} -c "Set :AvailableLibraries:2:SupportedPlatform simulator" "Info.plist"
${PlistBuddy} -c "Set :AvailableLibraries:2:LibraryIdentifier ios-arm64-simulator" "Info.plist"