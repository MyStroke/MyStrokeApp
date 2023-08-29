import React, { useState } from "react";
import { View, Text, Button, StyleSheet } from "react-native";
import Time from "./Time";
import Graph from "./Graph";

export default function Game({ updateScoreData }) {
    const [topscore, setTopscore] = useState(0)

    return (
        <View style={styles.container}>
            <Text style={{fontSize: 30}}>Topscore: {topscore}</Text>
            <Graph />
            <Time updateScoreData={updateScoreData} setTopscore={setTopscore} topscore={topscore} />
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