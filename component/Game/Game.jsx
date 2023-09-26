import React, { useState, useEffect} from "react";
import { View, Text, Button, StyleSheet } from "react-native";
import { widthPercentageToDP as wp, heightPercentageToDP as hp }  from "react-native-responsive-screen";
import { Camera } from 'expo-camera'
import { WebView } from 'react-native-webview';

import Time from "./Time";
import Graph from "./Graph";
import Howtouse from "../Howtouse";

export default function Game({ updateScoreData }) {
    const [hasPermission, setHasPermission] = useState(0);
    const [topscore, setTopscore] = useState(0)
    const [Score, setScore] = useState(0);
    // const [scorerealtime, setscorerealtime] = useState(0)

    // แสดงคะแนนสูงสุด
    if (Score > topscore) {
        setTopscore(Score);
    }

    useEffect(() => {
        (async () => {
          const { status } = await Camera.requestCameraPermissionsAsync();
          setHasPermission(status === 'granted');
        })();
      }, []);

      if (hasPermission === null) {
        return <View />;
      }
      if (hasPermission === false) {
        return <Text>No access to camera</Text>;
      }

    return (
        <View style={styles.container}>
            {/* <Text style={{fontSize: 30}}>Topscore: {topscore}</Text>
            <Graph />
            <Time updateScoreData={updateScoreData} Score={Score} setScore={setScore} /> */}
            <WebView source={{ uri: 'https://effulgent-chebakia-76c57d.netlify.app/' }} 
            style={{width: wp("100%")}} 
            originWhitelist={['*']}
            allowsInlineMediaPlayback
            javaScriptEnabled
            mediaPlaybackRequiresUserAction={false}
            javaScriptEnabledAndroid
            useWebkit
            />
            <Howtouse />
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: "center",
        alignItems: "center"
    },
});