import React from "react";
import { Camera } from 'expo-camera';

export default async function permission() {

    let { status } = await Camera.requestCameraPermissionsAsync()

    if (status === 'granted') {
        return true
    } else {
        return false
    }
}