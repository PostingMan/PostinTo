#include "backend.h"
#include <QDebug>
Backend::Backend(QObject *parent) : QObject(parent){}

void Backend::init(){

    m_socket = new QUdpSocket();

    /* sure must be any */
    m_socket->bind(QHostAddress::Any, port);

    connect(m_socket, SIGNAL(readyRead()), this, SLOT(read_msg()));

}


/*
 * 向服务端发送请求报文，服务端对不同的请求作出对应的响应
 */
void Backend::send_message_test(QVariant msg){
    QByteArray message = msg.toString().toUtf8();
    qint64 ret;
    ret = m_socket->writeDatagram(message, QHostAddress("39.97.118.39"), port);


    if(ret == -1) {
        qDebug() << "send message faild";
    } else {
        qDebug() << "send message ok: ";
        qDebug() << "the message is " << message;

    }

}

void Backend::read_msg(){
    
    /* 此处更正为handle Msg！ */
    QString data;
    /* dat 接收8848端口的数据 */
    char dat[1024] = "";
    m_socket->readDatagram(dat, 1024);
    data = dat;
    
    QString temp = data.mid(0, 4);
    
    switch(temp.toInt()){
    
    case START_CODE: emit welcome(); break;
    case LOGIN_SUCCESS: emit loginS(); break;
    case LOGIN_FAILED: emit loginF(); break;
    case SIGN_SUCCESS: emit signS(); break;
    case SIGN_FAILED: emit signF(); break;
    case NEW_ROOM: emit getNewRoom(data.mid(4, -1)); break; /* -1 means returns all characters that are available from the position 4 */
    case ROOM_FINISH: emit getRoomFinish(); break;
    case SHOWYEAR_CHAMPION: {
        int arr[3] = {0};
        int cnt = 0;
        for (int i = 4; i < data.length(); i++) {
            if(data[i] == '/'){
                arr[cnt] = i;
                cnt++;
            }
        }
//        qDebug()<<data.mid(4, arr[0] - 4)<<
//            data.mid(arr[0]+1, arr[1]-arr[0])<<
//                data.mid(arr[1]+1, arr[2]-arr[1])<<
//                    data.mid(arr[2]+1, -1);
        emit getShowYearChampion(
                data.mid(4, arr[0] - 4),
                data.mid(arr[0]+1, arr[1]-arr[0]-1), 
                data.mid(arr[1]+1, arr[2]-arr[1]-1), 
                data.mid(arr[2]+1, -1)
        ); break;
    }
        
    case GET_MSG_CODE: {
        int arr[3] = {0};
        int cnt = 0;
        for (int i = 4; i < data.length(); i++) {
            if(data[i] == '/'){
                arr[cnt] = i;
                cnt++;
            }
        }
//        qDebug()<<data.mid(4, arr[0] - 4)<<
//            data.mid(arr[0]+1, arr[1]-arr[0])<<
//                data.mid(arr[1]+1, arr[2]-arr[1])<<
//                    data.mid(arr[2]+1, -1);
        emit getChatMsg(
                data.mid(4, arr[0] - 4),
                data.mid(arr[0]+1, arr[1]-arr[0]-1), 
                data.mid(arr[1]+1, arr[2]-arr[1]-1), 
                data.mid(arr[2]+1, -1)
        );
        break;
    }
    
    case MEMBER_IN: emit memberin(data.mid(4,-1)); break;
    default: break;
    }
    
}
