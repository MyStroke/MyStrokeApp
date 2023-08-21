import React, { useState, useEffect } from "react";
import { View, Text, ActivityIndicator, StyleSheet, Image } from "react-native";

export default function Loading() {
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        setTimeout(() => {
            setIsLoading(false); // เมื่อโหลดเสร็จสิ้น
        }, 5000);
    }, []);

    return (
        <View style={styles.container}>
            {isLoading ? (
                <>
                    <Image source={require("../data/Logo.png")} style={styles.Logo} />
                    <Text style={{ color: "#F3DFC1", fontSize: 35, marginTop: 10, }}>MYSTROKE</Text>
                </>
            ) : null}
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
        backgroundColor: "#160F29",
    },
    Logo: {
        width: 128,
        height: 128,
    }
});