import React from "react";
import { Text, View, TouchableOpacity, Modal } from "react-native";
import style from "../style";

import { AntDesign } from '@expo/vector-icons';

export default function Howtouse() {
    const [modalVisible, setModalVisible] = React.useState(false);

    return (
        <View style={style.HowToUse}>
            {/*     How to Use    */}
            <TouchableOpacity onPress={() => setModalVisible(true)}>
                <AntDesign name="questioncircleo" style={style.HowToUse.icon} />
            </TouchableOpacity>
            {/*     Model    */}
            <Modal visible={modalVisible}>
                {/*     Model Container    */}
                <View style={style.HowToUse.model.container}>
                    <Text style={{ color: "#F3DFC1", fontSize: 30, }}>วิธีการใช้งาน</Text>
                    <View style={{ padding: 20, }}>
                        <Text style={style.HowToUse.model.text}>การเชื่อมต่อกับอุปกรณ์</Text>
                        <View style={{ marginTop: 20, }}>
                            <Text style={style.HowToUse.model.text}>หน้าหลัก</Text>
                        </View>
                        <View style={{ marginTop: 20, }}>
                            <Text style={style.HowToUse.model.text}>การบำบัดด้วยเกม</Text>
                        </View>
                    </View>
                </View>
                {/*     How to Use    */}
                <TouchableOpacity style={style.HowToUse} onPress={() => setModalVisible(false)}>
                    <AntDesign name="questioncircleo" style={style.HowToUse.model.HowToUse.icon} />
                </TouchableOpacity>
            </Modal>
        </View>
    )
}