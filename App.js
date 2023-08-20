import styles from './style';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

import { MaterialCommunityIcons } from '@expo/vector-icons';
import { FontAwesome } from '@expo/vector-icons';

import Home from './component/Home';

export default function App() {
    const Tab = createBottomTabNavigator();
    return (
        <NavigationContainer>
            <Tab.Navigator initialRouteName='Home' screenOptions={styles.BarStyle}>

                {/*         Test         */}
                <Tab.Screen name="Test" component={Home} options={{
                    tabBarIcon: ({color}) => (
                        <MaterialCommunityIcons name="test-tube" size={35} color={color} />
                    )
                }} />

                {/*        Home       */}
                <Tab.Screen name="Home" component={Home} options={{
                    tabBarIcon: ({color}) => (
                        <MaterialCommunityIcons name="home-circle" size={35} color={color} />
                    )
                }} />

                {/*        Game       */}
                <Tab.Screen name="Game" component={Home} options={{
                    tabBarIcon: ({color}) => (
                        <FontAwesome name="gamepad" size={24} color={color} />
                    )
                }} />

            </Tab.Navigator>
        </NavigationContainer>
    );
}