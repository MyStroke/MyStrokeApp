import React from "react";
import { View, StyleSheet } from "react-native";
import { LineChart } from "react-native-gifted-charts"

export default function LineChartComponent({ scoreData }) {
    let lineData = [{ value: 0, dataPointText: 0 }];
    lineData = scoreData.map((score) => ({ value: score, dataPointText: score }));

    if (lineData.length > 1) {
        lineData.shift();
        lineData.pop();
    }
    

    return (
        <View>
            <View style={{ marginTop: 50 }}>
                <LineChart style={styles.graph}
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
                />
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: "center",
    },
    graph: {
        backgroundColor: "#1F1639",
        marginTop: 50,
        borderRadius: 20,
    },
});
