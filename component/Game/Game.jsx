import React from "react";
import { View, Text, Button, StyleSheet } from "react-native";
import Time from "./Time";

export default function Game({updateScoreData}) {
    return (
        <View style={styles.container}>
            <Time updateScoreData={updateScoreData} />
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: "center",
        alignItems: "center"
    }
});