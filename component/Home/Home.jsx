import React from "react";
import { View, Text, Image, TouchableOpacity, Modal } from "react-native";
import { StyleSheet } from "react-native";
import { widthPercentageToDP as wp, heightPercentageToDP as hp } from 'react-native-responsive-screen';
import { AntDesign } from '@expo/vector-icons';
import { MaterialCommunityIcons } from '@expo/vector-icons';

export default function Home({ boxstatus, statusHomepage }) {
    const [modalVisible, setModalVisible] = React.useState(false);
    return (
        <View style={styles.container}>
            {/*     Box Status   */}
            <View style={styles.box}>
                <Text style={styles.box.text}>You are in</Text>
                <Text style={styles.box.status}>{boxstatus}</Text>
                <Text style={styles.box.text}>Condition</Text>
            </View>
            {/*     Status2    */}
            <View style={{ marginTop: 20, }}>
                <Text style={styles.status}>{statusHomepage}</Text>
            </View>
            {/*     How to Use    */}
            <TouchableOpacity style={styles.HowToUse} onPress={() => setModalVisible(true)}>
                <AntDesign name="questioncircleo" style={styles.HowToUse.icon} />
            </TouchableOpacity>
            {/*     Warn     */}
            <View style={styles.warn}>

                {/*     Water   */}
                <View style={{width: "50%", padding: 5,}}>
                    <Text style={{fontSize: 20, paddingBottom: 5,}}><MaterialCommunityIcons name="water-plus" size={24} color="#246A73" /> อย่าลืมดื่มน้ำ</Text>
                    <Text>รู้ไหมว่าการดื่มน้ำมีส่วนช่วยในการทำงานของระบบประสาท</Text>
                </View>

                <Text style={{width: 3, height: 150, flexShrink: 0, backgroundColor: "#246A73"}}></Text>

                {/*     walk     */}
                <View style={{width: "50%", padding: 5, marginLeft: 20,}}>
                    <Text style={{fontSize: 20, paddingBottom: 5,}}><MaterialCommunityIcons name="walk" size={24} color="#246A73" /> หมั่นเดินบ้าง</Text>
                    <Text>รู้ไหมว่าการเดินมีส่วนช่วยในการทำงานของระบบประสาท</Text>
                </View>

            </View>
            {/*     Model    */}
            <Modal visible={modalVisible}>
                {/*     Model Container    */}
                <View style={styles.model.container}>
                    <Text style={{ color: "#F3DFC1", fontSize: 30, }}>วิธีการใช้งาน</Text>
                    <View style={{ padding: 20, }}>
                        <Text style={styles.model.text}>การเชื่อมต่อกับอุปกรณ์</Text>
                        <View style={{ marginTop: 20, }}>
                            <Text style={styles.model.text}>หน้าหลัก</Text>
                        </View>
                        <View style={{ marginTop: 20, }}>
                            <Text style={styles.model.text}>การบำบัดด้วยเกม</Text>
                        </View>
                    </View>
                </View>
                {/*     How to Use    */}
                <TouchableOpacity style={styles.HowToUse} onPress={() => setModalVisible(false)}>
                    <AntDesign name="questioncircleo" style={styles.model.HowToUse.icon} />
                </TouchableOpacity>
            </Modal>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: "center",
        justifyContent: "center",
        position: "relative",
    },
    box: {
        marginTop: 50,
        width: 200,
        height: 200,
        backgroundColor: "#1F1639",
        borderRadius: 100,
        alignItems: "center",
        justifyContent: "center",

        text: {
            color: "#F3DFC1",
            fontSize: 20,
            textAlign: "center",
            padding: 10,
        },

        status: {
            color: "#368F8B",
            fontSize: 40,
            textAlign: "center",
        },

        status2: {
            paddingTop: 15,
            color: "#F3DFC1",
            fontSize: 15,
            textAlign: "center",
            alignItems: "center",
            width: 300,
            height: 53,
            flexShrink: 5,
            borderBottomLeftRadius: 20,
            borderBottomRightRadius: 20,
            backgroundColor: "#246A73",
        }
    },
    status: {
        color: "#F3DFC1",
        padding: 10,
        fontSize: 15,
        width: wp('50%'),
        textAlign: "center",
        backgroundColor: "#246A73",
        borderRadius: 5,
    },
    IconStyle: {
        width: 128,
        height: 128,
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
        }
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
    warn: {
        width: wp("100%"),
        marginTop: 20,
        flexDirection: 'row',
        padding: 20,
    },
});