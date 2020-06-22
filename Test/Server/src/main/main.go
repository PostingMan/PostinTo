package main

import (
   "../config"
   "../dataHandle"
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
	//_, _ = conn.WriteToUDP([]byte(string(buf[0:4])+" Message Received!"), rAddr) // 简单回写数据给客户端
}

var Running bool

func main() {
   fmt.Println("...PostingTo Server Running...")
   Running = true
   
   /* data base */
   dataHandle.Connect()
   defer dataHandle.Close()

   /* 创建通道 */
   syncChan := make(chan struct{}, 1)
   
   lAddr, err := net.ResolveUDPAddr("udp", "0.0.0.0:8848")
   if err != nil {
      fmt.Println("ResolveUDPAddr err:", err)
      return
   }
   /* 监听客户端 */
   conn, err := net.ListenUDP("udp", lAddr)

   if err != nil {
      fmt.Println("net.ListenUDP err:", err)
      return
   }
   defer conn.Close()

   for {
      buf := make([]byte, 2048)
      n, rAddr, err := conn.ReadFromUDP(buf)

      /* 并发 */
      go NewMessage(conn, n, rAddr, buf, err)
      if !Running {
      	syncChan <- struct{}{}
      	break
      }
      
   }

   /* 执行该语句时将会发生阻塞，直到接收到数据，
    * 但接收到的数据会被忽略。
    * 这个方式实际上只是通过通道在 goroutine 
    * 间阻塞收发实现并发同步。 
    */
	<-syncChan
}