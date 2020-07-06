package dataHandle

import (
	"../config"
	_ "../mysql"
	"database/sql"
	"fmt"
	"net"               /* 网络相关包 */
	"strconv"           /* 字符串与数字转换 */
	"strings"
	"sync"  			/* 互斥锁/读写锁 */
	"time"
)

type Client struct {
	id         	string
	clientAddr 	*net.UDPAddr
	status     	bool
	name        string
	curRom      string
}

type ChatRoom struct {
	id			string
	memCnt  	int
	clients     []*Client
	lastTime	string
}

var (
	dbhostip     = 	  "127.0.0.1:3306"
	dbusername   = 	  "root"
	dbpassword   = 	  "root"
	dbname 		 =    "mysql"
	db 				  *sql.DB
)

var userMutex 	sync.RWMutex //读写锁
var userCon     map[string] bool
var userCnt     int

var roomMutex   sync.RWMutex 
var rooms 		map[string] *ChatRoom
var roomCnt 	int

//错误检测，若检测到错误，程序会立刻停止运行
func checkErr(err error){
	if err!=nil {
		panic(err)
	}
}

//关闭数据库连接
func Close() {
	fmt.Println("Closing MySQL")
	err := db.Close()
	checkErr(err)
	fmt.Println("MySQL Closed")
}

//连接数据库
func Connect() {
	var err error
	db, err = sql.Open("mysql",dbusername+":"+dbpassword+"@tcp("+dbhostip+")/"+dbname+"?charset=utf8")
	checkErr(err)
	userCnt = 0
	roomCnt = 0
	userCon = make(map[string] bool)
	rooms   = make(map[string] *ChatRoom)
	fmt.Println(db.Stats())
	fmt.Println("connect db ok")

}

//处理客户端发来的信息
func HandleMsg(buf []byte, conn *net.UDPConn, rAddr *net.UDPAddr) {
	fmt.Println("---begin handleMsg---")
	defer func() {
		if errs := recover(); errs != nil{
			fmt.Println(errs)
		}
	}()

	//获取前四位的信息类型编号
	/* strconv.Atoi string ---> int */
	data, err := strconv.Atoi(string(buf[0:4]))
	checkErr(err)

	//根据类型编号对应进行处理
	switch data {
		/* 响应客户端启动事件 */
		case config.START_CODE:
			fmt.Println("Client start")
			defer func() {
				if errs := recover(); errs != nil{
					fmt.Println(errs)
				}
			}()

		/* 响应用户登录事件 */
		case config.LOGIN_CODE:
			fmt.Println("Somebody is trying to Login")
			loginData := string(buf[4:])
			loginData = config.CompressStr(loginData)
			left  := strings.Index(loginData, "/")
			right := strings.LastIndex(loginData, "/")

			/* 获取报文中的用id/昵称/密码 */
			id := loginData[0:left]
			name := loginData[left+1:right]
			psw := loginData[right+1:]

			flag  := LoginQuery(id, name, psw)
			
			/* 登录人id与密码正确 */
			if flag == config.LOGIN_SUCCESS {
				fmt.Println("Login Success")
				userMutex.RLock()
				bitMsg := []byte("8100") 
				_, _ = conn.WriteToUDP(bitMsg, rAddr)

			} else if flag == config.LOGIN_FAILED {
				fmt.Println("Login Failed")
				/* 8101 ---> LOGIN_FAILED */
				bitMsg := []byte("8101")// + "登陆失败,请检查信息")
				_, _ = conn.WriteToUDP(bitMsg, rAddr)
			}
			PrintStatus()

		/* 响应用户注册事件 */
		case config.SIGNIN_CODE:
			fmt.Println("Somebody is trying to Sign In")
			loginData := string(buf[4:])
			loginData = config.CompressStr(loginData)

			left  := strings.Index(loginData, "/")
			right := strings.LastIndex(loginData, "/")

			flag  := SignInQuery(loginData[0:left], loginData[left+1:right], loginData[right+1:])

			if flag == config.SIGNIN_SUCCESS {
				/* 8102 ---> SIGNIN_SUCCESS */
				bitMsg := []byte("8102")// + "注册成功")
				
				/* 回写给客户端，注册成功 */
				res, err := conn.WriteToUDP(bitMsg, rAddr)
				fmt.Println(res, err)
			} else if flag == config.SIGNIN_FAILED {
				/* 8103 ---> SIGNIN_FAILED */
				bitMsg := []byte("8103")// + "注册失败,id可能已被占用")
				res, err := conn.WriteToUDP(bitMsg, rAddr)
				fmt.Println(res, err)
			}
		
		/* 响应用户发聊天消息事件 */
		case config.GET_MSG_CODE:
			roomMutex.Lock()

			Data := string(buf[4:])
			Data = config.CompressStr(Data)

			left  := strings.Index(Data, "/")
			right := strings.LastIndex(Data, "/")
			roomCode := Data[0:left]
			userId   := Data[left+1:right]
			content  := Data[right+1:]

			fmt.Println(roomCode, userId, content)
			for _, value := range rooms[roomCode].clients {
				if value.id != userId {
					res, eee := conn.WriteToUDP([]byte("1003"+
						userId+"/"+
						content+"/"+
						GetUserNameQuery(userId)+"/"+
						roomCode),
							value.clientAddr)
					fmt.Println(res, eee)
				}
			}
			//roomMutex.RUnlock()
			roomMutex.Unlock()

		/* 响应用户加入房间事件 */
		case config.GET_INTO_ROM:
			
			createData := string(buf[4:])
			createData = config.CompressStr(createData)
			pos := strings.Index(createData, "/")
			roomCode := createData[0:pos]
			userId   := createData[pos+1:]
			if roomCode == "" {
				return
			}
			roomMutex.RLock()
			/* 房间不存在就创建 */
			if _, ok := rooms[roomCode]; !ok {
				roomMutex.RUnlock()
				roomMutex.Lock()

				rom := new(ChatRoom)
				rom.id = roomCode
				rom.lastTime = config.GetCurTime()
				rom.memCnt = 1

				client := new(Client)
				client.id = userId
				client.clientAddr = rAddr
				rom.clients = append(rom.clients, client)

				rooms[roomCode] = rom
				roomMutex.Unlock()
			} else {
				roomMutex.RUnlock()
				roomMutex.Lock()

				client := new(Client)
				client.id = userId
				client.clientAddr = rAddr
				rooms[roomCode].clients = append(rooms[roomCode].clients, client)

				rooms[roomCode].lastTime = config.GetCurTime()
				rooms[roomCode].memCnt++
				roomMutex.Unlock()
			}
			_,_ = conn.WriteToUDP([]byte("1009"+userId), rAddr)
			PrintStatus()

		/* 响应用户退出房间事件，若房间内无用户则关闭该房间 */
		case config.QUIT_THE_ROOM:
			//defer func() {
			//	if errs := recover(); errs != nil{
			//		fmt.Println(errs)
			//	}
			//}()
			roomMutex.Lock()

			Data := string(buf[4:])
			Data = config.CompressStr(Data)
			pos := strings.Index(Data, "/")
			userId   := Data[0:pos]
			roomCode := Data[pos+1:]
			//fmt.Println(userId, roomCode)
			if roomCode == "" {
				roomMutex.Unlock()
				return
			}

			var index int
			index = -1
			var value *Client

			if nil != rooms[roomCode] {
				for index, value = range rooms[roomCode].clients {
					if value.id == userId {
						break
					}
				}
			}

            if index == -1 {
            	roomMutex.Unlock()
				return
			}

			rooms[roomCode].lastTime = config.GetCurTime()
			rooms[roomCode].clients = append(rooms[roomCode].clients[:index],
				rooms[roomCode].clients[index+1:]...)
			rooms[roomCode].memCnt--

			if rooms[roomCode].memCnt == 0 {
				delete(rooms, roomCode)
			}

			PrintStatus()
			roomMutex.Unlock()

		/* 响应用户刷新房间信息事件，返回当前存在的所有房间号码 */
		case config.REQ_ROOM_INFO:
			fmt.Println("Refreshing")
			roomMutex.Lock() //加锁
			PrintStatus()
			for key, _ := range rooms {
				//key 是 string 类型， 对应的 value 是 ChatRoom 类型
				//client's 1007 是 NEW_ROOM
				_, _ = conn.WriteToUDP([]byte("1007"+key), rAddr)
				fmt.Println(key)
			}
			roomMutex.Unlock() //解锁

			/* client's 1008 is ROOM_FINISH */
			_, _ = conn.WriteToUDP([]byte("1008"), rAddr)

		/* 响应创建房间事件 */
		case config.CREATE_ROOM:

			createData := string(buf[4:])
			createData = config.CompressStr(createData)
			pos := strings.Index(createData, "/")
			
			roomCode := createData[0:pos]	/* 房间号 */
			userId   := createData[pos+1:]	/* 创建者id */
            if roomCode == "" {
            	return
			}
			roomMutex.RLock() //读锁
			if _, ok := rooms[roomCode]; !ok {
				roomMutex.RUnlock()
				roomMutex.Lock()

				rom := new(ChatRoom)
				rom.id = roomCode
				rom.lastTime = config.GetCurTime()
				rom.memCnt = 1

				client := new(Client)
				client.id = userId
				client.clientAddr = rAddr
				rom.clients = append(rom.clients, client)

				rooms[roomCode] = rom
				roomMutex.Unlock()
			} else {
				roomMutex.RUnlock()
				roomMutex.Lock()

				client := new(Client)
				client.id = userId
				client.clientAddr = rAddr
				rooms[roomCode].clients = append(rooms[roomCode].clients, client)

				rooms[roomCode].lastTime = config.GetCurTime()
				rooms[roomCode].memCnt++
				roomMutex.Unlock()
			}
			// initCntI := rooms[roomCode].memCnt
			// initCntS := strconv.Itoa(initCntI)
			// fmt.Println("roomCode is" + roomCode + " memCnt is " + initCntS)
			/* client's 1007 is NEW_ROOM */
			_, _ = conn.WriteToUDP([]byte("1007"+roomCode), rAddr)
			PrintStatus()

		/* 响应用户打卡事件 */
		case config.SET_SHOWYEAR:
			Data := string(buf[4:])
			Data = config.CompressStr(Data)
			pos  := strings.Index(Data, "/")
			id   := Data[0:pos]
			sygj   := Data[pos+1:]
			SygjQuery(id, sygj)

		/* 响应用户查看谁是冠军（当天最晚打卡的用户）事件 */
		case config.GET_SHOWYEAR:
			t := config.GetCurTime()
			t = t[0:2]
			if n, _ :=strconv.Atoi(t); n >= 0 && n < 6{
				id, sygj, tim := GetSygjQuery(time.Now().AddDate(0, 0, -2).Format("2006-01-02 15:04:05")[0:10])
				_, _ = conn.WriteToUDP([]byte("1011"+id+"/"+GetUserNameQuery(id)+"/"+tim+"/"+sygj), rAddr)
			} else {
				id, sygj, tim := GetSygjQuery(time.Now().AddDate(0,0,-1).Format("2006-01-02 15:04:05")[0:10])
				_, _ = conn.WriteToUDP([]byte("1011"+id+"/"+GetUserNameQuery(id)+"/"+tim+"/"+sygj), rAddr)
			}
		
		/* 响应用户查看房间用户事件 */
		case config.REQ_MEM_LIST:
			roomMutex.Lock()
			fmt.Println("request member list")
			roomCode := string(buf[4:])
			roomCode = config.CompressStr(roomCode)
			fmt.Println("roomCode is " + roomCode)

			for key, _ := range rooms {
				fmt.Println("the rooms")
				fmt.Println(key)
			}
			/* 如果该房间存在， 获取该房间所有用户的用户名 */
			if _, ok := rooms[roomCode]; ok {
				
				fmt.Println(rooms[roomCode].clients[0].id) //will be ok
				allmem := rooms[roomCode].clients
				for _, member := range allmem {
					
					fmt.Println("the member name is ")
					//fmt.Println(member.name)
					name := GetUserNameQuery(member.id)
					_, _ = conn.WriteToUDP([]byte("1012"+name), rAddr)
					fmt.Println("in room " + roomCode)
					
				}


			} else {
				fmt.Println("没有...")

			}
			roomMutex.Unlock()




		default:
			fmt.Println("Undefined message type!")
			fmt.Println(rAddr, string(buf[4:]))
	}
	
	fmt.Println("---over handle ---")
}

/* 操作数据库 */

/* 
 * 查询登录人信息，若 id 与密码都与数据库中相匹配
 * 则返回 LOGIN_SUCCESS，否则返回 LOGIN_FAILED
 */
func LoginQuery(id string, nickname string, psw string)(flag int) {
	var userid    string
	var username  string
	var userpsw   string
	var userLtime string
	err := db.QueryRow("SELECT * FROM users WHERE userId=?", id).Scan(&userid, &username, &userpsw,
		&userLtime)
	checkErr(err)

	fmt.Println(id, userid, psw, userpsw)

	if id == userid && psw == userpsw {
		stmt, e := db.Prepare("UPDATE users SET userName=? WHERE userId=?")
		defer  stmt.Close()
		if e != nil {
			fmt.Println(e)
		}
		_, _ = stmt.Exec(nickname, id)
		return config.LOGIN_SUCCESS
	} else {
		return config.LOGIN_FAILED
	}

}

/* 
 * 用户注册操作，若 id 在 MYSQL 的 users 表中不存在
 * 则将相关信息插入 users 表中，成功返回 SIGNIN_SUCCESS
 * 否则用户存在，返回 SIGNIN_FAILED
 */
func SignInQuery(id string, nickname string, psw string)(flag int) {
	var cnt int
	e := db.QueryRow("SELECT COUNT(userId) FROM users WHERE userId=?", id).Scan(&cnt)
	checkErr(e)
	if cnt == 0 {
		stmt, er := db.Prepare("INSERT INTO users(userId, userName, userPsw, userLastLtime) VALUE (?,?,?,?)")
		if er != nil {
			panic(er)
		}
		defer stmt.Close()
		res, err := stmt.Exec(id, nickname, psw, config.PrintTime())
		if err != nil {
			panic(err)
		}
		fmt.Println(res.RowsAffected())
		return config.SIGNIN_SUCCESS
	} else {
		fmt.Println("Id exists!")
		return config.SIGNIN_FAILED
	}
	return 0
}

func GetUserNameQuery(id string)(name string) {
	err := db.QueryRow("SELECT userName FROM users WHERE userId=?", id).Scan(&name)
	if name == "" {
		name = "無"
	}
	if err != nil {
		fmt.Println("查无此人")
		fmt.Println(err)
	}
	return
}

func PrintStatus() {
	for index, value := range userCon{
		fmt.Println(index, value)
	}
	for index, value := range rooms{
		fmt.Println(index, value)
	}
}

func SygjQuery(id string, sygj string){
	var cnt int
	var dat string
	t := config.GetCurTime()
	t = t[0:2]
	if n, _ :=strconv.Atoi(t); n >= 0 && n < 6{
		dat = time.Now().AddDate(0,0,-1).Format("2006-01-02 15:04:05")[0:10]

	} else {
		dat = time.Now().Format("2006-01-02 15:04:05")[0:10]
	}

	e := db.QueryRow("SELECT COUNT(date) FROM sygj WHERE date=?", dat).Scan(&cnt)
	checkErr(e)

	if cnt == 0 {
		db.QueryRow("INSERT INTO sygj(userId, sygj, date, time) VALUE(?,?,?,?)", id, sygj, dat, config.GetCurTime())
	} else {
		db.QueryRow("UPDATE sygj SET userId=? WHERE date=?", id, dat)
		db.QueryRow("UPDATE sygj SET time=? WHERE date=?", config.GetCurTime(), dat)
		db.QueryRow("UPDATE sygj SET sygj=? WHERE date=?", sygj, dat)
	}
}

func GetSygjQuery(date string)(id string, sygj string, tim string){
	var cnt int
	fmt.Println(date)

	e := db.QueryRow("SELECT COUNT(date) FROM sygj WHERE date=?", date).Scan(&cnt)
	checkErr(e)
	if cnt == 0 {
		return "?", "昨日无人秃头~", "11:45:14"
	} else {
		_ = db.QueryRow("SELECT userId, sygj, time FROM sygj WHERE date=?", date).Scan(&id, &sygj, &tim)
		return
	}
}
