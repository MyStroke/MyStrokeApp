import React from "react";
import { View, StyleSheet, Text } from "react-native";
import { LineChart } from "react-native-gifted-charts"

export default function LineChartComponent({ lineData, status, status2, showknowledge }) {

    return (
        <View style={styles.container}>
            {/*         Graph        */}
            <View style={styles.graph}>
                <LineChart
                    dataPointsColor="yellow"
                    thickness={6}
                    color="#07BAD1"
                    noOfSections={2}
                    isAnimated
                    areaChart
                    yAxisTextStyle={{ color: '#1F1639' }}
                    hideRules
                    data={lineData}
                    curved
                    startFillColor={'rgb(84,219,234)'}
                    endFillColor={'rgb(84,219,234)'}
                    startOpacity={0.4}
                    endOpacity={0.4}
                    spacing={38}
                    backgroundColor="#1F1639"
                    initialSpacing={10}
                    dataPointsHeight={20}
                    dataPointsWidth={20}
                    width={250}
                />
            </View>
            {/*         box          */}
            {showknowledge ? (
                <View style={styles.box}>
                    <View style={{ flex: 1, marginTop: "8%",  }}>
                        <Text style={styles.box.text}>You are in</Text>
                        <Text style={styles.box.status}>
                            {status}
                        </Text>
                        <Text style={styles.box.text}>Condition</Text>
                    </View>
                    <View style={{ flex: 1, justifyContent: 'flex-end' }}>
                        <Text style={styles.box.status2}>{status2}</Text>
                    </View>
                </View>
            ) : null
            }
            {/*         History      */}
            <View style={styles.History}>
                <Text style={{ color: "#F3DFC1", fontSize: 20, textAlign: "center", padding: 10, }}>ประวัติการรักษา</Text>
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: "center",
        alignItems: 'center',
        position: 'relative',
    },
    box: {
        marginTop: 50,
        width: 300,
        height: 300,
        backgroundColor: "#1F1639",
        borderRadius: 20,
        alignItems: "center",
        justifyContent: "center",

        text: {
            color: "white",
            fontSize: 20,
            textAlign: "center",
            padding: 10,
        },

        status: {
            color: "#368F8B",
            fontSize: 60,
            textAlign: "center",
            padding: 10,
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
    graph: {
        maxWidth: 350,
        width: 350,
        marginTop: 50,
        justifyContent: "center",
    },
    History: {
        position: 'absolute',
        top: 10,
        left: 10,
        backgroundColor: "#246A73",
        padding: 5,
        borderRadius: 5,
    },
});
