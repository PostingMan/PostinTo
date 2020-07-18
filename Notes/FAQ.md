> 注：我们组成员由于暑期将往各自方向发展，故该项目暂停维护，服务端软件暂时停止运行
>
> 若有任何问题可联系：[Jaywhen](https://github.com/jaywhen): 
>
> - mail: jaywhenxiang@foxmail.com
> - QQ: 1742884132

运行服务端软件您需要：

- 在一台配置了 `Golang`语言环境 、 `MYSQL` 的计算机（ `OS` 最好为 `Linux`，任意发行版）上编译运行服务端程序：

  - > ```bash
    > # 在项目目录 \PostinTo\Server\main 下
    > # 编译
    > go build main.go 
    > 
    > # 运行
    > ./main
    > ```
  
- 其中，`MYSQL` 数据库中至少这张表：

  ![table](..\img\yiban.png)

- 若为云服务器，请确保配置了 `UDP` 安全组，即您的服务器（`PC`）能够接收外网发来的数据报