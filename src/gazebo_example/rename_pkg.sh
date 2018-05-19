#!/bin/sh

DEFAULT_OLD_PKG_NAME="gazebo_example"

if [ -z "$1" ]
  then
    echo "No name to replace provided"
    exit
fi

if [ -z "$2" ]; then
    OLD_PKG_NAME=$DEFAULT_OLD_PKG_NAME
else
    OLD_PKG_NAME=$2
fi

while true; do
    read -p "Do you confirm you want to rename the package from "$OLD_PKG_NAME" to "$1"? [Y/N]:  " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

rename "s/$OLD_PKG_NAME/$1/" **/*
find . -name "*.cpp" -type f -exec sed -i -e "s/$OLD_PKG_NAME/$1/g" {} +
find . -name "*.h" -type f -exec sed -i -e "s/$OLD_PKG_NAME/$1/g" {} +
find . -name "*.py" -type f -exec sed -i -e "s/$OLD_PKG_NAME/$1/g" {} +
find . -name "*.txt" -type f -exec sed -i -e "s/$OLD_PKG_NAME/$1/g" {} +
find . -name "*.xml" -type f -exec sed -i -e "s/$OLD_PKG_NAME/$1/g" {} +
mv ../$OLD_PKG_NAME/ ../$1
