import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: chatP
    property alias _title:_title.text
    property var roomCode

    background: Rectangle {color: "white"}
    
    //顶栏
    header: Rectangle{
        anchors.top: parent.top
        anchors.topMargin: dp(50)

        color: "#039BE5"
        width: parent.width
        height: dp(50)
        Text {
            id: _title
            anchors.centerIn: parent
            text: "No." + roomCode
            color: "#4b2e2b"
            font.pixelSize: dp(20)
            font.family: tintFnt
        }

        /* 退出按钮 */
        Image {
            id: popIco
            source: "../../assets/mdpi/ic_arrow_back.png"
            height: parent.height * 0.6
            anchors{
                left: parent.left
                leftMargin: dp(3)
                verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stack.pop()
                    root.backPress()
                    //backend.send_message_test("1006" + userId + "/" + roomCode)
                    backend.send_message_test("1007")
                }
            }
        }
        
    }

    
    /* 消息泡泡 */
    ListView {
        id: view
        anchors{
            top: parent.top
            topMargin: dp(70)
            bottom: input.top
            bottomMargin: dp(4)
            horizontalCenter: parent.horizontalCenter
        }
        width: dp(250)
        clip: true
        model: ListModel {
            id: listmode
        }
        
        add: Transition {
          ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 800; easing.type: Easing.OutQuart }
            NumberAnimation { properties: "scale"; from: 0; to: 1; duration: 200; easing.type: Easing.InQuart }
          }
        }
//        addDisplaced: Transition {
//          NumberAnimation { properties: "x,y"; duration: 100 }
//        }
//        remove: Transition {
//          id: removeTransition;
//          property real targetY: 0
//          ParallelAnimation {
//            NumberAnimation { property: "opacity"; to: 0; duration: 400 }//easing: Easing.OutQuint}
//            NumberAnimation { properties: "scale"; to: 0; duration: 400 }
//            NumberAnimation { id: yAnim; property: "y"; to: removeTransition.targetY; duration: 400 }
//          }
//        }
//        removeDisplaced: Transition {
//          NumberAnimation { properties: "x,y"; duration: 400 }
//        }
        
        delegate: Column {
            id: column
            anchors.right: sentByMe ? parent.right : undefined
            anchors.rightMargin: sentByMe ? 20 : undefined
            spacing: dp(3)
            
            readonly property bool sentByMe: model.flag === "Y"

            Row {
                id: messageRow
                spacing: dp(1.3)
                anchors.right: sentByMe ? parent.right : undefined
                anchors.left: sentByMe ? undefined : parent.left
                anchors.leftMargin: dp(3)
                layoutDirection: sentByMe ? Qt.RightToLeft : Qt.LeftToRight
                Rectangle {
                    id: avatar
                    width: dp(30)
                    height: width
                    radius: width/2
                    Text {
                        anchors.centerIn: parent
                        text: model.from[0]
                        font.family: tintFnt
                        font.pixelSize: parent.width * 0.6
                    }
                }

                Rectangle {
                    width: Math.min(
                               messageText.implicitWidth + dp(5),
                               0.6 * (view.width - avatar.width - messageRow.spacing))
                    height: messageText.implicitHeight + dp(5)
                    color: sentByMe ? "lightgrey" : "steelblue"
                    radius: dp(2.1)
                    Label {
                        id: messageText
                        text: content
                        color: sentByMe ? "black" : "white"
                        anchors.fill: parent
                        anchors.margins: dp(2.5)
                        wrapMode: Label.Wrap
                        font.family: "Microsoft YaHei UI"
                    }
                }
            }

            Label {
                id: timestampText
                text: from + "--" + time
                color: "lightgrey"
                anchors.right: sentByMe ? parent.right : undefined
                anchors.left: sentByMe? undefined : messageRow.left
            }
            
            add: Transition {
                from: "fromState"
                to: "toState"
            }
        }
    }
    
//    TextArea {
//        id: input
//        width: dp(75)
//        height: Math.min(Math.max(dp(8), text.height), text.height * 6);
//        anchors {
//            bottom: parent.bottom
//            bottomMargin: dp(3.5)
//            left: parent.left
//            leftMargin: dp(6)
//        }
//        background: Rectangle {color: "#eeeeee"; radius: dp(2)}
//        font.pixelSize: dp(4)
//    }


//    AppTextEdit {
//        id: input
//        width: parent.width * 0.7
//        height: Math.min(Math.max(dp(8), text.height), text.height * 6)
//        anchors {
//            bottom: parent.bottom
//            bottomMargin: dp(3.5)
//            left: parent.left
//            leftMargin: dp(6)
//        }

//    }
    TextArea {
            id: input
            width: dp(75)
            height: Math.min(Math.max(dp(8), text.height), text.height * 6);
            anchors {
                bottom: parent.bottom
                bottomMargin: dp(3.5)
                left: parent.left
                leftMargin: dp(6)
            }
            background: Rectangle {color: "#eeeeee"; radius: dp(2)}
            font.pixelSize: dp(4)
        }

        Rectangle {
            anchors{
                right: parent.right
                bottom: parent.bottom
                rightMargin: dp(4)
                bottomMargin: dp(4.2)
            }
            width: dp(10)
            radius: dp(3)
            height: dp(8)
            color: "#FABC04"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (input.text != ""){
                        send2server()
                        input.focus = false
                    }
                    else
                        root.showChip("消息为空!")
                }
            }
            Text {
                anchors.centerIn: parent
                text: qsTr("发送")
                font.family: tintFnt
                color: "black"
            }
        }


    

    /* footer */
//    Rectangle {
//        width: parent.width
//        height: dp(50)
//        color: "white"
//        anchors.bottom: parent.bottom
//        anchors.leftMargin: 10
//        anchors.horizontalCenter: parent.horizontalCenter

//        RowLayout {
//            width: parent.width
//            anchors {
//                bottom: parent.bottom
//                bottomMargin: dp(3.5)
//                centerIn: parent

//            }
//            spacing: dp(10)

//            TextArea {
//                id: input
//                width: 200

//                height: Math.min(Math.max(dp(8), text.height), text.height * 6);
//                anchors {
////                    bottom: parent.bottom
////                    bottomMargin: dp(3.5)
//                    left: parent.left
//                    leftMargin: dp(10)
//                }
//                background: Rectangle {color: "#eeeeee"; radius: dp(2);}
//                font.pixelSize: dp(20)
//            }
//            AppTextEdit {
//                id: input
//                width: 200
//                height: Math.min(Math.max(dp(8), text.height), text.height * 6);
//                anchors {
//                    //                    bottom: parent.bottom
//                    //                    bottomMargin: dp(3.5)
//                    left: parent.left
//                    leftMargin: dp(10)
//                }

//            }

//            AppButton {
//                anchors {
//                    right: parent.right
//                    rightMargin: dp(3.5)

//                }
//                width: parent.width * 0.2
//                radius: dp(8)
//                text: qsTr("SEND")

//                onClicked: {
//                    if (input.text != ""){

//                        send2server()
//                        root.showChip("suc")
//                        input.focus = false
//                    }
//                    else
//                        root.showChip("消息为空!")
//                }

//            }

//        }

//    }

//    Rectangle {
//            anchors{
//                right: parent.right
//                bottom: parent.bottom
//                rightMargin: dp(4)
//                bottomMargin: dp(4.2)
//            }
//            width: dp(10)
//            radius: dp(3)
//            height: dp(8)
//            color: "#FABC04"
//            MouseArea {
//                anchors.fill: parent
//                onClicked: {
//                    if (input.text != ""){
//                        send2server()
//                        input.focus = false
//                    }
//                    else
//                        root.showChip("消息为空!")
//                }
//            }
//            Text {
//                anchors.centerIn: parent
//                text: qsTr("发送")
//                font.family: tintFnt
//                color: "black"
//            }
//        }

    
    Connections {
        target: root
        onBackPress: {
            //1006: QUIT_THE_ROOM
             backend.send_message_test("1006" + userId + "/" + roomCode)
        }
    }
    
    Connections {
        target: backend
        onGetChatMsg: {
            if(room === roomCode ){
                listmode.append({from: name, flag: "N", content: msg, time: Qt.formatDateTime(new Date(), "hh:mm:ss")})
                view.positionViewAtEnd()
            }
        }
    }
    
    // temp Version
    function send2server(){

        backend.send_message_test("1004" + roomCode + "/" + userId + "/" + input.text)
        listmode.append({from: userName, flag: "Y", content: input.text, time: Qt.formatDateTime(new Date(), "hh:mm:ss")})
        input.text = ""
        view.positionViewAtEnd()

    }
}
