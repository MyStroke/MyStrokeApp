import React, { useState, useEffect } from 'react';
import styles from './style';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

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
    const [scoreData, setScoreData] = useState([]);

    useEffect(() => {
        setTimeout(() => {
            setIsLoading(false);
        }, 3000);
    }, []);

    const updateScoreData = (score) => {
        setScoreData((prevScoreData) => [...prevScoreData, score]);
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
                    <Tab.Screen name="Home" component={Home} options={{
                        tabBarIcon: ({ color }) => (
                            <MaterialCommunityIcons name="home-circle" size={40} color={color} />
                        )
                    }} />

                    {/*         Test         */}
                    <Tab.Screen name="Test" options={{
                        tabBarIcon: ({ color }) => (
                            <MaterialCommunityIcons name="test-tube" size={40} color={color} />
                        )
                    }}>
                        {() => <Test scoreData={scoreData} />}
                    </Tab.Screen>

                    {/*        Game       */}
                    <Tab.Screen name="Game" options={{
                        tabBarIcon: ({ color }) => (
                            <FontAwesome name="gamepad" size={40} color={color} />
                        )
                    }}>
                        {() => <Game updateScoreData={updateScoreData} />}
                    </Tab.Screen>

                </Tab.Navigator>
            )}
        </NavigationContainer>
    );
}