import React from "react";
import { Switch, Text, View } from "react-native";
import requestPermission from './permission';
import { Camera } from 'expo-camera';

export default function Camerapage() {
    let [cameratype, setcameratype] = React.useState()
    let [isFrontCamera, setisFrontCamera] = React.useState(false)
    let [flashMode, setflashMode] = React.useState()
    let [isFlashOn, setisFlashOn] = React.useState(false)

    React.useEffect(() => {
        requestPermission()
    }, [])

    const switchCameraType = (v) => {
        let t = (v) ? Camera.Constants.Type.front : Camera.Constants.Type.back
        setcameratype(t)
        setisFrontCamera(v)
    }

    const switchFlashMode = (v) => {
        let f = (v) ? Camera.Constants.FlashMode.on : Camera.Constants.FlashMode.off
        setflashMode(f)
        setisFlashOn(v)
    }

    return (
        <View>
            <Camera style={{ width: 200, height: 200 }} type={cameratype} flashMode={flashMode} />
            <View>
                <Text>Camera Type</Text>
                <Switch value={isFrontCamera} onValueChange={switchCameraType} />
            </View>
            <View>
                <Text>Flash Mode</Text>
                <Switch value={isFlashOn} onValueChange={switchFlashMode} />
            </View>
        </View>
    )
}