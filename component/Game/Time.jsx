import React, { useState, useEffect } from 'react';
import { View, StyleSheet, Text, TouchableOpacity } from 'react-native';

export default function Timer({ updateScoreData }) {
    const [time, setTime] = useState(10);
    const [isActive, setIsActive] = useState(false);
    const [Score, setScore] = useState(0);
    const [topscore, setTopscore] = useState(0);

    // ตั้งเวลา 10 วินาที
    useEffect(() => {
        let interval = null;

        if (isActive && time > 0) {
            interval = setInterval(() => {
                setTime((prevTime) => prevTime - 1);
            }, 1000);
        } else if (time === 0) {
            setIsActive(false);
            updateScoreData(Score);
        }

        return () => {
            clearInterval(interval);
        };
    }, [isActive, time]);

    // แสดงเวลาในรูปแบบ 00 วินาที
    const formatTime = (seconds) => {
        const remainingSeconds = seconds % 60;

        return `${remainingSeconds.toString().padStart(2, '0')} วินาที`;
    };

    // กดเพื่อเริ่มหรือหยุดเวลา
    const toggleTimer = () => {
        if (isActive) {
            setIsActive(false);
            setTime(10);
        } else {
            setIsActive(true);
            setTime(10);
            setScore(0);
        }
    };

    // แสดงคะแนนสูงสุด
    if (Score > topscore) {
        setTopscore(Score);
    }

    return (
        <View>
            <View style={styles.container}>
                <Text style={styles.score}>Score: {Score}</Text>
                <Text style={styles.timer}>{formatTime(time)}</Text>
                <TouchableOpacity onPress={toggleTimer} style={styles.button}>
                    <Text style={styles.buttonText}>{isActive ? 'เริ่มใหม่' : 'เริ่ม'}</Text>
                </TouchableOpacity>
                {/*         กดเมื่อเริ่ม         */}
                {isActive ?
                    <TouchableOpacity onPress={() => setScore(Score + 1)} style={styles.button}>
                        <Text style={styles.buttonText}>กด</Text>
                    </TouchableOpacity>
                    : null
                }
                <Text style={styles.score}>Topscore: {topscore}</Text>
            </View>
        </View>
    );
};

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
    },
    score: {
        fontSize: 30,
    },
    timer: {
        marginTop: 20,
        fontSize: 60,
        fontWeight: 'bold',
    },
    button: {
        marginTop: 20,
        width: 100,
        padding: 10,
        backgroundColor: '#160F29',
        borderRadius: 5,
    },
    buttonText: {
        color: 'white',
        textAlign: 'center',
        fontSize: 20,
    },
});