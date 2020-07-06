import QtQuick 2.0
import Felgo 3.0

Page {
    id: memberlistP
    property var roomid

    Rectangle {
        anchors.topMargin: dp(10)
        color:  Theme.colors.tintLightColor
        width: parent.width
        height: dp(90)

        Text {
            //id: _title
            anchors.centerIn: parent
            text: "🌖  " + roomid
            color: "#4b2e2b"
            font.pixelSize: dp(20)
            font.family: tintFnt
        }

        Image {
            id: popIco
            source: "../../assets/mdpi/ic_arrow_back.png"
            height: parent.height * 0.8
            width: dp(15)
            anchors{
                left: parent.left
                leftMargin: dp(8)
                // verticalCenter: parent.verticalCenter
                bottom: parent.bottom
                bottomMargin: dp(5)
            }
            fillMode: Image.PreserveAspectFit
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    stack.pop()
                }
            }
        }


    }


    Rectangle {
        id: memlistRec
        anchors.centerIn: parent
        width: parent.width * 0.7
        height: parent.height * 0.5
        color: "#555555"
        opacity: 0.7
        Text {
            text: qsTr("...some peoples ...")
            color: "white"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
        }

        ListView {
            id: memList
            anchors.centerIn: parent
            width: dp(200)
            height: parent.height * 0.55

            model: ListModel {
                id: memmodel
            }
            clip: true
            spacing: dp(6)
            delegate: Rectangle {
                property var mems: modelData
                width: parent.width
                height: dp(25)
                color: "white"
                radius: 5
                Text {
                    anchors.centerIn: parent
                    text: parent.mems
                    font.pixelSize: parent.height * 0.6
                    color: "black"
                }

            }
            /* server's 1010 is REQ_MEM_LIST */
            // Component.onCompleted: backend.send_message_test("1010"+roomid)
        }

    }

    Connections {
       target: backend
       onGetMemList: {
           memmodel.append({modelData: memname})
       }
    }

}
