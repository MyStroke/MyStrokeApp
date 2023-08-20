import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';

import { MaterialCommunityIcons } from '@expo/vector-icons';
import { FontAwesome } from '@expo/vector-icons';

import Home from './component/Home';

export default function App() {
    const Tab = createBottomTabNavigator();
    return (
        <NavigationContainer>
            <Tab.Navigator screenOptions={{
                tabBarShowLabel: false
            }}>

                {/*         Test         */}
                <Tab.Screen name="Test" component={Home} options={{
                    tabBarIcon: () => (
                        <MaterialCommunityIcons name="test-tube" size={35} color="black" />
                    )
                }} />

                {/*        Home       */}
                <Tab.Screen name="Home" component={Home} options={{
                    tabBarIcon: () => (
                        <MaterialCommunityIcons name="home-circle" size={35} color="black" />
                    )
                }} />

                {/*        Game       */}
                <Tab.Screen name="Game" component={Home} options={{
                    tabBarIcon: () => (
                        <FontAwesome name="gamepad" size={24} color="black" />
                    )
                }} />
            </Tab.Navigator>
        </NavigationContainer>
    );
}