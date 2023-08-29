import React from 'react';
import { View, StyleSheet, Text } from 'react-native';
import { LineChart } from 'react-native-gifted-charts';

export default function Graph() {
    const lineData = [
        { value: 50 }, { value: 45 }, { value: 15 },
        { value: 70 }, { value: 35 }, { value: 50 },
        { value: 50 }, { value: 50 }, { value: 50 }, { value: 50 }];

    return (
        <View style={styles.graph}>
            <LineChart
                areaChart
                curved
                data={lineData}
                height={250}
                maxValue={100}
                minValue={0}
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