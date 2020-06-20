import Felgo 3.0
import QtQuick 2.12
import QtQuick.Controls 2.12 /* TextField */
import QtQuick.Layouts 1.12

Page {
    id: mainP
    title: qsTr("Main Page")
    
    //bk
//    Rectangle {
//        anchors.fill: parent
//        color: "white"
//    }

    /* header */
    Rectangle {
//        anchors.top: parent.top
//        anchors.topMargin: dp(60)
        anchors.bottom: listRec.top
        anchors.bottomMargin: dp(15)
        width: parent.width
        height: dp(65)
        color: "white" /*Theme.colors.tintLightColor*/

        RowLayout {
            width: parent.width
            anchors.centerIn: parent

            //昨日秃头冠军
            Rectangle {
                id: user
                width: dp(35)
                height: width
                radius: width / 2
                color: "#00838F"

                anchors {
//                    top: parent.top
                    left: parent.left
                    margins: dp(6.5)
                }

                Text {
                    text: userName[0]//JSON.stringify(userName)[0]
                    anchors.centerIn: parent;
                    font {
                        family: tintFnt
                        pixelSize: dp(15)
                        bold: true
                    }
                    color: "#FFFFFF"
                }
            }

            AppButton {
                id: beChampion
                text: "want C"

                onClicked: {
                    root.showMask()
                    setChampion.createObject(root)
                }

            }

            AppButton {
                id: seeChampion
                text: "Y C"
                onClicked: {
                    root.showMask()
                    championPage.createObject(root)
                }

            }
        }

    }


    Rectangle {
        id: listRec
        anchors.centerIn: parent
        width: parent.width * 0.7
        height: parent.height * 0.5
        color: "#555555"
        opacity: 0
        Text {
            text: qsTr("some rooms ...")
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

        }

        ParallelAnimation {
            id: create;
            PropertyAnimation {
                target: listRec
                property: "height";
                to: parent.height * 0.6
                duration: 325
                easing.type: Easing.InQuart
            }
            PropertyAnimation {
                target: listRec
                property: "width";
                to: parent.width * 0.85

                duration: 325
                easing.type: Easing.OutQuart
            }
            PropertyAnimation {
                target: listRec
                property: "radius"
                to: dp(10)
                duration: 325
            }
            PropertyAnimation {
                target: listRec
                property: "opacity"
                to: 0.7
                duration: 325
                easing.type: Easing.InQuart
            }
        }
        Component.onCompleted: create.start()
        
        ListView {
            id: roomList
            anchors.centerIn: parent
            width: dp(200)
            height: parent.height * 0.55

            model: ListModel{
                id: roomodel
            }
            clip: true
            spacing: dp(6)
            delegate: Rectangle {
                property var roomCod: modelData
                width: parent.width
                height: dp(25)
                color: "white"
                radius: 5
                Text {
                    anchors.centerIn: parent
                    text: "[" + parent.roomCod + "]"
                    font.family: "Agency FB Negreta"
                    font.pixelSize: parent.height * 0.6
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: getIntoRoom(modelData)
                }
            }
            Component.onCompleted: backend.send_message_test("1007")
        }
    }
    
    Image {
        id: flash
        source: "../../assets/mdpi/ucrop_ic_rotate.png"
        width: dp(30)
        fillMode: Image.PreserveAspectFit
        anchors {
            right: listRec.right
            bottom: listRec.bottom
            margins: dp(6)
        }
        PropertyAnimation {
            id: flashAni
            target: flash
            property: "rotation"
            from: 0
            to: 360
            duration: 800
            loops: Animation.Infinite
        }

        MouseArea {
            anchors.centerIn: parent
            width: dp(8)
            height: dp(8)
            onClicked: {
                flashAni.start()
                timeOutT.start()
                backend.send_message_test("1007")
                root.showChip("刷新中")
                roomodel.clear()
            }
        }
    }
    
    Timer {
        id: timeOutT
        interval: 500
        repeat: flashAni.running
        onTriggered: if(flashAni.running) backend.send_message_test("1007")
    }

    RowLayout {
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.bottomMargin: dp(30)
        spacing: dp(5)

        AppTextField {
            id: input
            width: listRec.width * 0.5
            anchors.left: parent.left
            anchors.leftMargin: dp(30)

            placeholderText: "请输入房间ID"
            placeholderTextColor: "gray"

        }
        AppButton {
            anchors.right: parent.right
            anchors.rightMargin: dp(20)
            radius:dp(5)

            text: qsTr("Go/join-in")

            onClicked: {
                var pd = false
                for(var dat in roomList.model) {
                    if(input.text === roomList.model[dat]){
                        pd = true
                        break
                    }
                }
                if(pd) {
                    input.focus = false
                    backend.send_message_test("1005" + input.text + "/" + userId)
                    root.pushStack(0)
                    stack.currentPage.roomCode = input.text
                    input.text = ""
                }
                else {
                    input.focus = false
                    backend.send_message_test("1003" + input.text + "/" + userId)
                    root.pushStack(0)
                    stack.currentPage.roomCode = input.text
                    //stack.currentItem.roomCode = input.text
                    input.text = ""
                }
            }

        }
    }
    
    Component {
        id: championPage
        MouseArea {
            id: th_is
            anchors.fill: parent
            onClicked: dest.start()
            property alias source: img.source
            property var userName
            property var userId
            property var saying
            property var time
            
            Image {
                id: img
                source: "../../assets/champion.jpg"
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                opacity: 0

                /* frog avat */
                Rectangle {
                    anchors {
                        right: parent.right
                        top: parent.top
                        topMargin: dp(10)
                        rightMargin: dp(20)
                    }
                    opacity: 0.8
                    width: dp(20)
                    radius: width / 2
                    height: width
                    Text {
                        id: txt
                        text: qsTr("🐸")
                        anchors.centerIn: parent
                        font.pixelSize: parent.height * 0.5
                    }
                    Image {
                        x: -dp(7)
                        y: -dp(5)
                        width: parent.width * 0.8
                        fillMode: Image.PreserveAspectFit
                        source: "../../assets/ic_tg.png"
                        rotation: -45
                    }
                }

                /* boss says */
                Rectangle {
                    color: "#DDA0DD"
                    width: parent.width * 0.6
                    height: parent.width * 0.35
                    radius: dp(3)
                    opacity: 0.65
                    anchors {
                        bottom: parent.bottom
                        horizontalCenter: parent.horizontalCenter
                        bottomMargin: dp(5)
                    }

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: dp(10)
                        spacing: dp(1.5)
                        Repeater {
                            model: ListModel{id: mod}
                            delegate: Text {
                                text: str
                                anchors.left: parent.left
                                font{
                                    pixelSize: dp(3.5)
                                    bold: true
                                    family: "微软雅黑"
                                }
                            }
                        }
                    }
                }
            }
            ParallelAnimation {
                id: create;
                PropertyAnimation {
                    target: img
                    property: "width";
                    to: dp(100)
                    duration: 325
                    easing.type: Easing.OutQuart
                }
                PropertyAnimation {
                    target: img
                    property: "opacity"
                    to: 1
                    duration: 325
                    //easing.type: Easing.InQuart
                }
            }
            ParallelAnimation {
                id: dest;
                PropertyAnimation {
                    target: img
                    property: "width";
                    to: dp(200)
                    duration: 325
                    easing.type: Easing.InQuad
                }
                PropertyAnimation {
                    target: img
                    property: "opacity"
                    to: 0
                    duration: 325
                    //easing.type: Easing.OutQuad
                }
                onFinished: {
                    root.closeMask()
                    th_is.destroy()
                }
            }
            Connections { 
                target: backend
                onGetShowYearChampion: {
                    mod.append({str: "昨日大佬：\n" + id})
                    mod.append({str: "他昨天一直肝到...：\n" + time})
                    mod.append({str: "大佬语录：\n" + sygj})
                    txt.text = name[0]
                }
            }
            
            Component.onCompleted: {
                create.start()
                backend.send_message_test("1009")
            }
        }
    }
    
    Component {
        id: setChampion
        MouseArea {
            id: th_is
            anchors.fill: parent
            onClicked: {
                dest.start()
                root.showChip("秃头成功")
                if(inp.text != "")
                    backend.send_message_test("1008"+userId+"/"+inp.text)
                else
                    backend.send_message_test("1008"+userId+"/"+"这个人很懒")
            }
            Image {
                id: img
                source: "../../assets/beChampion.jpg"
                anchors.verticalCenter: parent.verticalCenter
                fillMode: Image.PreserveAspectFit
                opacity: 0
                
                Rectangle {
                    color: "white"; radius: dp(3); opacity: 0.7
                    anchors.horizontalCenter: parent.horizontalCenter;
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: dp(5)
                    width: img.width * 0.6
                    height: width * 0.18
                    TextInput {
                        id: inp
                        clip: true
                        anchors.fill: parent
                        font {
                            family: "微软雅黑"
                            pixelSize: height * 0.6
                        }
                        maximumLength: 15
                    }    
                }
                
            }
            ParallelAnimation {
                id: create;
                PropertyAnimation {
                    target: img
                    property: "width";
                    to: dp(100)
                    duration: 325
                    easing.type: Easing.OutQuart
                }
                PropertyAnimation {
                    target: img
                    property: "opacity"
                    to: 1
                    duration: 325
                }
            }
            ParallelAnimation {
                id: dest;
                PropertyAnimation {
                    target: img
                    property: "width";
                    to: dp(200)
                    duration: 325
                    easing.type: Easing.InQuad
                }
                PropertyAnimation {
                    target: img
                    property: "opacity"
                    to: 0
                    duration: 325
                }
                onFinished: {
                    root.closeMask()
                    th_is.destroy()
                }
            }
            Component.onCompleted: create.start()
        }
    }
    
    Connections {
        target: backend
        onGetNewRoom: {
            roomodel.append({modelData: id})
        }
        onGetRoomFinish: {
            flashAni.stop()
            flash.rotation = 0;
            root.showChip("更新成功!")
        }
    }
    
    Connections {
        target: root
        onBackPress: {
            roomodel.clear()
        }
    }
    
    function getIntoRoom(data) {
        flashAni.stop()
        flash.rotation = 0
        input.focus = false
        root.pushStack(0)
        stack.currentPage.roomCode = data
        backend.send_message_test("1005" + data + "/" + userId)
    }
}
