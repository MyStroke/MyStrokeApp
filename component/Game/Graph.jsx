import React from 'react';
import { View, StyleSheet, Text } from 'react-native';
import { LineChart } from 'react-native-gifted-charts';

export default function Graph() {
    const lineData = [
        { value: 0 }, { value: 100 }, { value: 8 },
        { value: 92 }, { value: 19 }, { value: 81 },
        { value: 0 }, { value: 100 }];

    return (
        <View style={styles.graph}>
            <LineChart
                areaChart
                curved
                data={lineData}
                height={250}
                width={250}
                hideYAxisText={true}
                showVerticalLines
                spacing={44}
                initialSpacing={0}
                color1="skyblue"
                textColor1="green"
                hideDataPoints
                dataPointsColor1="blue"
                startFillColor1="skyblue"
                startOpacity={0.8}
                endOpacity={0.3}
            />
        </View>
    );
}

const styles = StyleSheet.create({
    graph: {
        maxWidth: 350,
        width: 350,
        marginTop: 50,
        justifyContent: "center",
    }
})