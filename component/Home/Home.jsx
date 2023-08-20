import React from "react";
import { View, Text, Image } from "react-native";
import { StyleSheet } from "react-native";

export default function Home() {
    return (
        <View style={{ flex: 1, alignItems: "center", justifyContent: "center" }}>
            <Text>Home</Text>
            <Image source={require('../../data/Logo.png')} style={styles.IconStyle} />
        </View>
    );
}

const styles = StyleSheet.create({
    IconStyle: {
        width: 128,
        height: 128,
    }
});