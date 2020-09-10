#                             PostinTo 
> 本项目继承自[LCBHSStudent](https://github.com/LCBHSStudent)的[Go_QML_UDP-chat-room-demo](https://github.com/LCBHSStudent/Go_QML_UDP-chat-room-demo)
> 感谢大佬的慷慨！

<img src="img/intro.png" alt="intro" style="zoom:67%;" />



简体中文 | [English](R3ADME-en.md)

🙏tips: 由于众所周知的原因，可能会出现图片无法加载的情况，请访问：[我们位于码云上的仓库](https://gitee.com/jaywhen/PostinTo)

------------

## 简述

> PostinTo 是一款客户端使用 Qt + Felgo 开发，服务端使用 Golang 开发的跨多端（`Windows`, `Linux`, `MacOS`, `Android`, `ios`）的聊天室应用

```
 ________   ________   ________   _________   ___   ________    _________   ________     
|\   __  \ |\   __  \ |\   ____\ |\___   ___\|\  \ |\   ___  \ |\___   ___\|\   __  \    
\ \  \|\  \\ \  \|\  \\ \  \___|_\|___ \  \_|\ \  \\ \  \\ \  \\|___ \  \_|\ \  \|\  \   
 \ \   ____\\ \  \\\  \\ \_____  \    \ \  \  \ \  \\ \  \\ \  \    \ \  \  \ \  \\\  \  
  \ \  \___| \ \  \\\  \\|____|\  \    \ \  \  \ \  \\ \  \\ \  \    \ \  \  \ \  \\\  \ 
   \ \__\     \ \_______\ ____\_\  \    \ \__\  \ \__\\ \__\\ \__\    \ \__\  \ \_______\
    \|__|      \|_______||\_________\    \|__|   \|__| \|__| \|__|     \|__|   \|_______|
                         \|_________|                                                    
```

![交互逻辑图](img/conver.jpg)

​																																*`交互逻辑图`*



### 服务端部分

> 服务端程序采用 `Go` 编写，将其部署在云服务器(`CentOS`)上，使用 `Screen` 来实现后台运行.
>
> 提供的服务：
>
> - 响应用户的登录、注册、创建房间、发送聊天消息等操作（数据库的CRUD、资源互斥访问）
> - 发送/接收/处理UDP报文



### UI部分

> UI部分主要采用`Qml`编写，使用了 `Felgo` 框架来对移动端做进一步的支持，小部分的 `C++` 实现报文发送以及处理逻辑



## 进一步了解

- [项目详细说明](group-21-App.pptx) 
- [代码规范](Notes/codesimple.md)
- [服务端相关配置](Notes/ECS-Config.md) 
- [参考](Notes/reference.md)



## Android安装包下载

[.apk包下载](https://github.com/PostingMan/PostinTo/releases/tag/v1.2.0-stable)



## FAQ

- [客户端软件无法登录？](Notes/FAQ.md)
