package main

import (
   "../config"
   "../dataHandle"
   "../logo"
   "fmt"
   "net"
)

func NewMessage(conn *net.UDPConn, n int, rAddr *net.UDPAddr, buf []byte, err error) {
   if err != nil {
      fmt.Println("conn.ReadFromUDP err:", err)
      return
   }
   config.PrintTime()
   dataHandle.HandleMsg(buf[:n], conn, rAddr)
}


func main() {

   logo.Printlogo()
   
   /* data base */
   /*
    * - defer: 在语句前声明关键字 defer 后
    * 在函数执行到最后时会逆序执行之前
    * 用 defer 声明的语句
    */
   dataHandle.Connect()
   defer dataHandle.Close()
   
   lAddr, err := net.ResolveUDPAddr("udp", "0.0.0.0:8848")
   if err != nil {
      fmt.Println("ResolveUDPAddr err:", err)
      return
   }

   /* 监听发送到本地地址 lAddr 的UDP数据包 */
   conn, err := net.ListenUDP("udp", lAddr)
   
   if err != nil {
      fmt.Println("net.ListenUDP err:", err)
      return
   }
   defer conn.Close()

   for {
      buf := make([]byte, 2048)
      n, rAddr, err := conn.ReadFromUDP(buf)

      /* 并发地处理各个客户端发来的消息 */
      go NewMessage(conn, n, rAddr, buf, err)
      
   }

}