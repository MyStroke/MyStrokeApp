import React from "react";
import { Text, View, TouchableOpacity, Modal, ScrollView, Image } from "react-native";
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
                <ScrollView style={style.HowToUse.model.container}>
                    <Text style={{ color: "#F3DFC1", fontSize: 30, }}>วิธีการใช้งาน</Text>
                    <View style={{ padding: 20, }}>

                        <Text style={style.HowToUse.model.text}>หากคุณยังไม่เคยเล่น</Text>
                        <Image source={require("../data/Howtouse/1.jpeg")} style={style.HowToUse.model.image} />

                        <View style={{ marginTop: 20, }}>
                            <Text style={style.HowToUse.model.text}>วิธีการเล่น</Text>
                        </View>

                        <View style={{ marginTop: 20, }}>
                            <Text style={style.HowToUse.model.text}>ดูผลการทดสอบ</Text>
                            <View>
                                <Image source={require("../data/Howtouse/3-1.jpeg")} style={style.HowToUse.model.image} />
                                <Image source={require("../data/Howtouse/3-2.jpeg")} style={style.HowToUse.model.image} />
                            </View>
                        </View>
                    </View>
                </ScrollView>

                {/*     How to Use    */}
                <TouchableOpacity style={style.HowToUse} onPress={() => setModalVisible(false)}>
                    <AntDesign name="questioncircleo" style={style.HowToUse.model.HowToUse.icon} />
                </TouchableOpacity>

            </Modal>
        </View>
    )
}