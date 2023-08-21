import { StyleSheet } from "react-native";

export default StyleSheet.create({
    style: {
        backgroundColor: "#160F29",
    },
    BarStyle: {
        tabBarShowLabel: false, // ปิดการแสดงชื่อ Tab
        tabBarActiveTintColor: "#F3DFC1", // สีของ Icon เมื่อ active
        // ตั้งค่า Tab Bar Style
        tabBarStyle: {
            backgroundColor: "#160F29",
            height: 60,
        },
        // ตั้งค่า Header Style
        headerStyle: {
            backgroundColor: "#160F29",
        },
        headerTintColor: "#F3DFC1", // สีของตัวอักษรบน Header
        headerTitle: "MyStroke", // ตั้งค่า Title บน Header
    },
    Loading: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
        tabBarShowLabel: false,
        tabBarStyle: {
            display: "none",
        },
        headerShown: false,
    },
});