import Felgo 3.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import "../components"

Page {
    id: loginPage
    title: qsTr("Login")
    //bk color or img
    background: Rectangle {color: "white"}

    Column {
        id: header
        visible: true
        anchors {
            bottom: mid.top
            bottomMargin: dp(30)
            horizontalCenter: parent.horizontalCenter
        }
        spacing: dp(5)

        AppText {
          text: "PostinTo"
          font.pixelSize: sp(35)
          color: "#7B1FA2"
          font.bold: true
        }
        AppText {
            text: "\"Keep in touch\""
            font.pixelSize: sp(10)
        }

    }

    Column {
        id: mid

        anchors.centerIn: parent
        spacing: dp(15)
        width: dp(256)

        AppTextField {
            id: userCode
            width: parent.width
            placeholderText: "ID"
            validator: RegExpValidator {regExp: /^[0-9]*$/}

        }

        AppTextField {
            id: userId
            width: parent.width
            inputMode: inputModeUsername
            placeholderText: "Nickname"
            validator: RegExpValidator {regExp: /^\w*$/}
        }

        AppTextField {
            id: userPsw
            width: parent.width
            placeholderText: "Password"
            validator: RegExpValidator {regExp: /^\w*$/}
            inputMode: inputModePassword
        }
    }


    //登录\注册按钮
    Row {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: dp(18)
        }
        spacing: dp(10)

        AppButton {
            radius: dp(5)
            text: "sign in"
            onClicked: {
                handleLogin()
            }
        }

        AppButton {
            radius: dp(5)
            text: "sign up"
            onClicked: {
                handleSignIn()
            }
        }
    }

    function handleLogin() {
        //信息完整
        if(userCode.text != "" && userId.text != "" && userPsw.text != ""){
            var logData = userCode.text + "/" + userId.text + "/" + userPsw.text;

            //发送数据
            /* 1001 ---> LOGINSMG_CODE */
            backend.send_message_test("1001" + logData)

            //设置主页id与用户名
            root.setUserInfo(userCode.text, userId.text)

            //本地存储用户名\密码\id
            root.setVal(userCode.text, userId.text, userPsw.text)
        }
        else {
            showChip("请完善信息!")
        }
    }

    function handleSignIn() {
        /* 信息完整 */
        if(userCode.text != "" && userId.text != "" && userPsw.text != ""){
            var logData = userCode.text + "/" + userId.text + "/" + userPsw.text;

            /* 1002 ---> SIGNIN_CODE */
            backend.send_message_test("1002" + logData)
        }
        else root.showChip("信息完整才能注册哦～")
    }

    Component.onCompleted: {
        userCode.text = storage.id
        userId.text = storage.userName
        userPsw.text = storage.psw
    }
}



