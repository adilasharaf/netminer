#!/bin/sh

readonly PACKETSDK_ID="8qzS6oDZI3FdIrU-d9mQkTIQF2tLsi9YoXphzAB5-9o=:0"
arch=$(uname -m)

# Download Earnapp installer
curl -fsSL https://brightdata.com/static/earnapp/install.sh >/src/earnapp.sh

PRODUCT="earnapp"
VERSION=$(grep VERSION= /src/earnapp.sh | cut -d'"' -f2)

if [ $arch = "x86_64" ]; then
    file=$PRODUCT-x64-$VERSION
elif [ $arch = "amd64" ]; then
    file=$PRODUCT-x64-$VERSION
elif [ $arch = "armv7l" ]; then
    file=$PRODUCT-arm7l-$VERSION
elif [ $arch = "armv6l" ]; then
    file=$PRODUCT-arm7l-$VERSION
elif [ $arch = "aarch64" ]; then
    file=$PRODUCT-aarch64-$VERSION
elif [ $arch = "arm64" ]; then
    file=$PRODUCT-aarch64-$VERSION
else
    file=$PRODUCT-arm7l-$VERSION
fi

# Download and make Earnapp executable
curl -fsSL https://cdn-earnapp.b-cdn.net/static/$file >/usr/bin/earnapp
echo | md5sum /usr/bin/earnapp
chmod +x /usr/bin/earnapp
rm -r /src/earnapp.sh

# Download and make Castarsdk executable
curl -fsSL https://download.castarsdk.com/linux.zip -o linux.zip
echo | md5sum linux.zip
sleep 2
unzip linux.zip -d linux
sleep 2
mv linux/CastarSdk_amd64 /usr/bin/castarsdk
sleep 2
chmod +x /usr/bin/castarsdk
sleep 2
rm -r linux.zip && rm -r linux

# Download and make Packetsdk executable
curl -fsSL https://storage-dl.packetsdk.com/d/packetsdk/linux/packet_sdk_linux-$PACKETSDK_V.zip?sign=$PACKETSDK_ID -o packetsdk.zip
echo | md5sum packetsdk.zip
unzip packetsdk.zip -d packetsdk
sleep 2
mv packetsdk/$arch/packet_sdk /usr/bin/packetsdk
sleep 2
chmod +x /usr/bin/packetsdk
sleep 2
rm -r packetsdk.zip && rm -r packetsdk

# Download and make Pawns executable
# curl -fsSL https://cdn.pawns.app/download/cli/latest/linux_$arch/pawns-cli >/usr/bin/pawns
# echo | md5sum /usr/bin/pawns
# chmod +x /usr/bin/pawns

# https://cdn-earnapp.b-cdn.net/static/earnapp-x64-1.549.762
