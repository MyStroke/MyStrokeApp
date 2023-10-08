import React, { useState, useEffect } from "react";
import { View, Text, Button, StyleSheet } from "react-native";
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from "react-native-responsive-screen";
import { Camera } from 'expo-camera'
import { WebView } from 'react-native-webview';
import { firebase } from "../Server/Server";

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

    // รับคะแนนจาก firebase
    useEffect(() => {
        const db = firebase.firestore();
        db.collection("user-score").onSnapshot((querySnapshot) => {
            querySnapshot.forEach((doc) => {

                if (Array.isArray(doc.data().score)) {
                    const scores = doc.data().score.map(item => item.playerScore);
                    for (let key in scores) {
                        // console.log(scores[key]);
                        updateScoreData(scores[key]);
                    }
                }
            });
        });
    }, []);

    return (
        <View style={styles.container}>
            <WebView source={{ uri: 'https://mystroke-game.netlify.app/' }}
                style={{ width: wp("100%") }}
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