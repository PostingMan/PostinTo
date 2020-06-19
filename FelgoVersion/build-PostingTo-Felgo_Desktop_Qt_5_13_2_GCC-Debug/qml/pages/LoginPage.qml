import QtQuick 2.12
import QtQuick.Controls 2.12
import "../components"

Page {
    id: loginPage

    //背景
    Rectangle {anchors.fill: parent; color: "white"}
    
    //顶栏
    Rectangle {
        id: head
        width: dp(100);
        height: width * 0.2
        anchors {
            top: parent.top
            // topMargin: dp(5)
            horizontalCenter: parent.horizontalCenter
        }
        color: "#1565C0"
        
        Row {
            anchors.centerIn: parent
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: "Posting"
                color: "blue"
                font{
                    bold: true
                    family: "微软雅黑"
                    pixelSize: dp(10)
                }
            }
            Rectangle {
                width: inner.width + dp(5)
                height: inner.height + dp(5)
                color: "white"
                radius: dp(2)
                Text {
                    id: inner
                    text: "to"
                    color: "#000"
                    anchors.centerIn: parent
                    font {
                        bold: true
                        family: tintFnt
                        pixelSize: dp(10)
                    }
                }
            }
        }
    }

    //
    Column {
        id: col;
        width: parent.width * 0.95;
        height: width;
        anchors{
            top: head.bottom;
            topMargin: dp(20);
            horizontalCenter: parent.horizontalCenter;
        }
        spacing: dp(3.8);


        EditText {
            id: userCode;
            width: parent.width;
            height: dp(9);
            icon: "../assets/mdpi/ic_login_code.png";
            placeholderText: "Pos ID";

            validator: RegExpValidator {regExp: /^[0-9]*$/}
        }

        //昵称
        EditText {
            id: userId;
            width: parent.width;
            height: dp(9);
            icon: "../assets/mdpi/ic_login_user.png";
            placeholderText: "Pos Nickname";

            validator: RegExpValidator {regExp: /^\w*$/}
        }

        //密码
        EditText {
            id: userPsw;
            width: parent.width;
            height: dp(9);
            icon: "../assets/mdpi/ic_login_psw.png";
            placeholderText: "Password";
            validator: RegExpValidator {regExp: /^\w*$/}  //限制输入类型的正则式
            echoMode: TextInput.Password; //设定输入模式为密码
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
        
        Rectangle {
            width: dp(30)
            height: width * 0.4
            color: "#03A9F4"
            radius: dp(3)
            Text {
                anchors.centerIn: parent
                text: qsTr("Sign in")
                font {
                    family: tintFnt
                    pixelSize: dp(6)
                    bold: true
                }
                color: "#FAFAFA"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    handleLogin()
                }
                onPressed: parent.color = "#f4d17f"
                onReleased: parent.color = "#F90"
            }
        }
        Rectangle {
            width: dp(30)
            height: width * 0.4
            color: "#03A9F4"
            radius: dp(3)
            Text {
                anchors.centerIn: parent
                text: qsTr("Sign up")
                font {
                    family: tintFnt
                    pixelSize: dp(6)
                    bold: true
                }
                color: "#FAFAFA"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    handleSignIn();
                }
                onPressed: parent.color = "#f4d17f"
                onReleased: parent.color = "#F90"
            }
        }
    }
    
    function handleLogin() {

        //信息完整
        if(userCode.text != "" && userId.text != "" && userPsw.text != ""){
            var logData = userCode.text + "/" + userId.text + "/" + userPsw.text;

            //发送数据
            backend.send_message_test("1001" + logData)

            //设置主页id与用户名
            root.setUserInfo(userCode.text, userId.text)

            //本地存储用户名\密码\id
            root.setVal(userCode.text, userId.text, userPsw.text)
        }
        else {
            showChip("没填完整我mysql拿头给您登录？")
        }
    }
    
    function handleSignIn() {

        //信息完整
        if(userCode.text != "" && userId.text != "" && userPsw.text != ""){
            var logData = userCode.text + "/" + userId.text + "/" + userPsw.text;
            backend.send_message_test("1002" + logData)
        }
        else root.showChip("没填完整我mysql拿头给您注册？")
    }
    
    Component.onCompleted: {
        userCode.text = storage.id
        userId.text = storage.userName
        userPsw.text = storage.psw
    }
}
