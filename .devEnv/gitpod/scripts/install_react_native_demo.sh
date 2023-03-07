#!/usr/bin/env bash

yarn create expo-app demo

mv demo/* .
rm -rf demo/

sed -i "s/\"start\": \"expo start\"/\"start\": \"expo start --host tunnel\"/" package.json
yarn add @expo/ngrok@^4.1.0