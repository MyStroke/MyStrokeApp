import { StyleSheet } from "react-native";
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';

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
        iconBar: {
            textAlign: "center",
        },
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
    Homenotstatus: {
        alignItems: "center",
        justifyContent: "center",
        text: {
            marginBottom: 20,
            fontSize: 20,
        },
        btn: {
            backgroundColor: "#160F29",
            borderRadius: 10,
            width: 200,
            height: 50,
            alignItems: "center",
            justifyContent: "center",

            text: {
                color: "#F3DFC1",
                fontSize: 15,
            }
        }
    },
    HowToUse: {
        width: 40,
        height: 40,
        borderRadius: 100,
        position: "absolute",
        top: 10,
        right: 10,
        icon: {
            color: "#246A73",
            fontSize: 35,
            fontWeight: "bold",
            textAlign: "center",
        },
        model: {
            container: {
                backgroundColor: "#246A73",
                width: wp('100%'),
                height: hp('100%'),
                position: "relative",
                padding: 50,
            },
            HowToUse: {
                width: 40,
                height: 40,
                borderRadius: 100,
                position: "absolute",
                top: 10,
                right: 10,
                icon: {
                    color: "#F3DFC1",
                    fontSize: 35,
                    fontWeight: "bold",
                    textAlign: "center",
                }
            },
            text: {
                color: "#F3DFC1",
                fontSize: 20,
            },
        },
    },
});