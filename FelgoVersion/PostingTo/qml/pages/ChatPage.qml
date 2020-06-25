import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Page {
    id: chatP
    property alias _title:_title.text
    property var roomCode
    property var memCnt

    background: Rectangle {color: "#40C4FF"}
    
    //顶栏
    header: Rectangle{
        // anchors.top: parent.top
        anchors.topMargin: dp(10)


        color:  Theme.colors.tintLightColor
        width: parent.width
        height: dp(60)
        Text {
            id: _title
            anchors.centerIn: parent
            text: "🌖  " + roomCode + " "+memCnt+" in"
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
                leftMargin: dp(8)
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

        Image {
            id: listIco
            source: "../../assets/mdpi/ic_more_w.png"
            height: parent.height * 0.8
            anchors{
                right: parent.right
                rightMargin: dp(8)
                verticalCenter: parent.verticalCenter
            }
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.pushStack(1)
                    stack.currentItem.roomid = roomCode
                    // backend.send_message_test("1010" + roomCode)

                }
            }

        }
        
    }

    
    /* 消息泡泡 */
    ListView {
        id: view
        Text {
            id: titles
            //text: qsTr("chachacha")
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }
        anchors{
            top: parent.top
            topMargin: dp(85)
            bottom: input.top
            bottomMargin: dp(4)
            horizontalCenter: parent.horizontalCenter
        }

        width: dp(350)
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

        delegate: Column {
            id: column
            anchors.right: sentByMe ? parent.right : undefined
            anchors.rightMargin: sentByMe ? dp(8) : undefined
            spacing: dp(6)
            
            readonly property bool sentByMe: model.flag === "Y"

            Row {
                id: messageRow
                spacing: dp(3)
                anchors.right: sentByMe ? parent.right : undefined
                anchors.left: sentByMe ? undefined : parent.left
                anchors.leftMargin: dp(3)
                layoutDirection: sentByMe ? Qt.RightToLeft : Qt.LeftToRight
                Rectangle {
                    id: avatar
                    width: dp(35)
                    height: width
                    radius: width/2
                    Text {
                        anchors.centerIn: parent
                        text: model.from[0]
                        font.family: tintFnt
                        font.pixelSize: parent.width * 0.7
                    }
                }

                Rectangle {
                    width: Math.min(
                               messageText.implicitWidth + dp(5),
                               0.6 * (view.width - avatar.width - messageRow.spacing))
                    height: messageText.implicitHeight + dp(5)
                    color: sentByMe ? "#61649f" : "ghostwhite"
                    radius: dp(5)
                    Label {
                        id: messageText
                        text: content
                        color: sentByMe ? "white" : "black"
                        anchors.fill: parent
                        anchors.margins: dp(2.5)
                        wrapMode: Label.Wrap
                        // font.family: "Microsoft YaHei UI"
                    }
                }
            }

            Label {
                id: timestampText
                text: from + "-" + time
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
    

    TextArea {
        id: input
        width: parent.width * 0.7
        height: Math.min(Math.max(dp(8), text.height), text.height * 6);
        anchors {
            bottom: parent.bottom
            bottomMargin: dp(15)
            left: parent.left
            leftMargin: dp(6)
        }
        background: Rectangle {color: "#eeeeee"; radius: dp(2)}
        font.pixelSize: dp(20)
    }

    AppButton {
        anchors{
            right: parent.right
            bottom: parent.bottom
            rightMargin: dp(6)
            bottomMargin: dp(15)
        }
        width: parent.width * 0.2
        radius: dp(3)
        height: input.height
        onClicked: {
            if (input.text != ""){
                send2server()
                input.focus = false
            }
            else
                root.showChip("消息为空!")
        }
        Text {
            anchors.centerIn: parent
            text: qsTr("SEND")
            font.family: tintFnt
            font.pixelSize: dp(14)
            color: "black"
        }
        backgroundColor: "#EEFF41"

    }


    
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
        onMemBerIn: {
            showChip(memid+" coming~")
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
