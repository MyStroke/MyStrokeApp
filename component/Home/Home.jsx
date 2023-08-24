import React from "react";
import { View, Text, Image } from "react-native";
import { StyleSheet } from "react-native";

export default function Home() {
    return (
        <View style={styles.container}>
            <Text>Home</Text>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
    },
    IconStyle: {
        width: 128,
        height: 128,
    }
});