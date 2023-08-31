import React, { useState } from "react";
import { View, Text, Button, StyleSheet } from "react-native";
import Time from "./Time";
import Graph from "./Graph";
import Howtouse from "../Howtouse";

export default function Game({ updateScoreData }) {
    const [topscore, setTopscore] = useState(0)
    const [Score, setScore] = useState(0);
    // const [scorerealtime, setscorerealtime] = useState(0)

    // แสดงคะแนนสูงสุด
    if (Score > topscore) {
        setTopscore(Score);
    }

    return (
        <View style={styles.container}>
            <Text style={{fontSize: 30}}>Topscore: {topscore}</Text>
            <Graph />
            <Time updateScoreData={updateScoreData} Score={Score} setScore={setScore} />
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