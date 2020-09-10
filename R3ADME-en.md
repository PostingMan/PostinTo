#                             PostinTo 
> This project is inherited from[LCBHSStudent](https://github.com/LCBHSStudent)'s[Go_QML_UDP-chat-room-demo](https://github.com/LCBHSStudent/Go_QML_UDP-chat-room-demo)
> Thank him for his generosity
<img src="img/intro.png" alt="intro" style="zoom:67%;" />



English | [简体中文](README.md)

🙏Tips :For some reason,the picture may not be loaded. Please visit [our gitee](https://gitee.com/jaywhen/PostinTo)

------------

## Resume

> **PostinTo is a cross platform(`Windows`, `Linux`, `MacOS`, `Android`, `ios`) chat room application developed by QT and Felgo on the client side and Golang on the server side**

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

![Interaction logic diagram](img/conver.jpg)

​																									

​																				*`（Interaction logic diagram）`*

------------------------------------------

### 服务端部分（Server-side）

> The server-side program is written in **Go**. It is deployed on the cloud server **CentOS** and runs in the background using **Screen**
>
> Services provided
>
> - Respond to users' login, registration, room creation, chat message sending (crud of database, exclusive access of resources)
> - Send / Receive / Process UDP message

--------------------------------------------------------

### UI

> The UI part is mainly written in **QML**. The **Felgo** framework is used to further support the mobile terminal, and a small part of **C + +** realizes message sending and processing logic

------------------------------------------------------------------------------

## Further information

- [Details](group-21-App.pptx) 
- [Code specification](Notes/codesimple.md)
- [Server related configuration](Notes/ECS-Config.md) 
- [Consult](Notes/reference.md)

----------------------------

## Download our app

[.apk包下载(Download)](https://github.com/PostingMan/PostinTo/releases/tag/v1.2.0-stable)



## FAQ

- [cant login ?](Notes/FAQ.md)
