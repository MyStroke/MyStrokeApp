import React from "react";
import { View, Text, Image } from "react-native";
import { StyleSheet } from "react-native";
import style from "../../style";

export default function Home({ boxstatus }) {
    return (
        <View style={styles.container}>
            <View style={styles.box}>
                <Text style={styles.box.text}>You are in</Text>
                <Text style={styles.box.status}>{boxstatus}</Text>
                <Text style={styles.box.text}>Condition</Text>
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
    },
    box: {
        marginTop: 50,
        width: 200,
        height: 200,
        backgroundColor: "#1F1639",
        borderRadius: 100,
        alignItems: "center",
        justifyContent: "center",

        text: {
            color: "#F3DFC1",
            fontSize: 20,
            textAlign: "center",
            padding: 10,
        },

        status: {
            color: "#368F8B",
            fontSize: 40,
            textAlign: "center",
        },

        status2: {
            paddingTop: 15,
            color: "#F3DFC1",
            fontSize: 15,
            textAlign: "center",
            alignItems: "center",
            width: 300,
            height: 53,
            flexShrink: 5,
            borderBottomLeftRadius: 20,
            borderBottomRightRadius: 20,
            backgroundColor: "#246A73",
        }
    },
    IconStyle: {
        width: 128,
        height: 128,
    }
});