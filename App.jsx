import React, { useState, useEffect } from 'react';
import styles from './style';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { useFonts } from 'expo-font';

// เพิ่ม Icon ที่จะนำมาใช้งาน
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { FontAwesome } from '@expo/vector-icons';

// เพิ่ม Component ที่จะนำมาใช้งาน
import Loading from './component/Loading';
import Home from './component/Home/Home';
import Game from './component/Game/Game';
import Test from './component/Test/Test';

export default function App() {
    const Tab = createBottomTabNavigator();

    const [isLoading, setIsLoading] = useState(true);
    const [scoreData, setScoreData] = useState([0]);
    const [status, setstatus] = React.useState("");
    const [status2, setstatus2] = React.useState("");
    const [showknowledge, setShowknowledge] = React.useState(false);

    const [fontsLoaded, fontError] = useFonts({
        'IBMPlexSansThai-Medium': require('./assets/fonts/IBMPlexSansThai-Medium.ttf'),
    });

    let lineData = scoreData.map((score) => ({ value: score, dataPointText: score }));

    const showstatus = () => {
        if (lineData.length > 1) {
            setShowknowledge(true);
            const latestData = lineData[lineData.length - 1]; // ดึงค่าล่าสุดจากอาร์เรย์
            if (latestData.value > 29) {
                setstatus("Good");
                setstatus2("คุณสามารถใช้มือหยิบจับสิ่งของได้ ตามปกติ")
            }

            else if (latestData.value > 19) {
                setstatus("Average");
                setstatus2("คุณอย่าใช้มือมากเกินไป")
            }

            else if (latestData.value > 0) {
                setstatus("Bad");
                setstatus2("คุณต้องทำการบำบัดอย่างเดียว")
            }

            else {
                setstatus("ยังไม่ได้ทำแบบทดสอบ");
                setstatus2(null)
            }
        }
    };

    React.useEffect(() => {
        showstatus();
    }, [lineData]);

    useEffect(() => {
        setTimeout(() => {
            setIsLoading(false);
        }, 3000);
    }, []);

    const updateScoreData = (score) => {
        const lastScore = scoreData.pop();

        if (lastScore !== score) {
            setScoreData((prevScoreData) => [...prevScoreData, score]);
        } else {
            setScoreData((prevScoreData) => [...prevScoreData, score]);
        }
    };

    return (
        <NavigationContainer>
            {isLoading ? (
                // หน้า Loading  
                <Tab.Navigator screenOptions={styles.Loading}>
                    <Tab.Screen name="Loading" component={Loading} options={{ tabBarIcon: () => null }} />
                </Tab.Navigator>
            ) : (
                <Tab.Navigator initialRouteName='Home' screenOptions={styles.BarStyle}>

                    {/*        Home       */}
                    <Tab.Screen name="Home" options={{
                        tabBarIcon: ({ color }) => (
                            <MaterialCommunityIcons name="home-circle" style={styles.BarStyle.iconBar} size={40} color={color} />
                        )}} >
                        {({ navigation }) => <Home navigation={navigation} showknowledge={showknowledge} status={status} status2={status2} />}
                    </Tab.Screen>

                    {/*         Test         */}
                    <Tab.Screen name="Test" options={{
                        tabBarIcon: ({ color }) => (
                            <MaterialCommunityIcons name="test-tube" style={styles.BarStyle.iconBar} size={40} color={color} />
                        )}}>
                        {({ navigation }) => <Test navigation={navigation} status={status} lineData={lineData} status2={status2} showknowledge={showknowledge} scoreData={scoreData} />}
                    </Tab.Screen>

                    {/*        Game       */}
                    <Tab.Screen name="Game" options={{
                        tabBarIcon: ({ color }) => (
                            <FontAwesome name="gamepad" style={styles.BarStyle.iconBar} size={40} color={color} />
                        )}}>
                        {() => <Game updateScoreData={updateScoreData} />}
                    </Tab.Screen>

                </Tab.Navigator>
            )}
        </NavigationContainer>
    );
}