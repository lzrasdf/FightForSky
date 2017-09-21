/// =============================================
/// 
/// author : zhl
/// module : socket客户端
/// desc :
///     1）采用 tcp 协议，多线程的同步通讯
/// time : 2017/09/20
///     
/// todo : 
///     1）心跳包
///     2）udp 协议
///     3）异步通讯
/// 
/// =============================================

using UnityEngine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Net.Sockets;
using System.Net;
using LuaInterface;

namespace LuaFramework {
	public class MyNetworkManager : Manager 
	{
	    private static byte[] result = new byte[1024];
	    private static IPAddress ip = IPAddress.Parse("192.168.5.117"); //设定服务器IP地址
	    private static Socket clientSocket = null; // socket接口

	    private static void Connect()
	    {
	    	Debug.Log("!!!!TryConnectNetWork!!!!");
	        clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
	        try
	        {
	            clientSocket.Connect(new IPEndPoint(ip, 8888)); //配置服务器IP与端口

	            Thread recvMsg = new Thread(new ThreadStart(RecvMsg));
	            recvMsg.IsBackground = true;
	            recvMsg.Start();
	           /* send_test();*/
	        }
	        catch
	        {
	        	Debug.LogError("连接服务器失败，请按回车键退出！");
	            return;
	        }
	    }

	    // 连接请求
	    public static void ReqConnect()
	    {
	        Connect();
	    }

	    // 切断网路请求
	    public static void ReqDisConnect()
	    {
	    	Debug.LogWarning("ReqDisConnect---->>>");
	        clientSocket.Shutdown(SocketShutdown.Both);
	        clientSocket.Close();
	    }

	    // 发送消息接口
	    public static void SendMsg(String Str)
	    {
	        try
	        {
	            clientSocket.Send(Encoding.UTF8.GetBytes(Str));
	            Debug.Log("向服务器发送消息:" + Str);
	        }
	        catch
	        {
	            clientSocket.Shutdown(SocketShutdown.Both);
	            clientSocket.Close();
	        }
	    }
	    /// <summary>
	    /// 消息接收函数，是运行在后台的线程，一旦有消息发送到该端口就会被接收到。
	    /// </summary>
	    public static void RecvMsg()
	    {
	        try
	        {
	            //通过clientSocket接收数据
	            int receiveLength = clientSocket.Receive(result);
	            String Str = Encoding.UTF8.GetString(result, 0, receiveLength);
	            while (Str != "q")
	            {
	                if (receiveLength > 0)
	                {
	                    // TODO：协议接口可以写在这里，需要注意的是，当协议内容为空时，协议长度是1，因为字符串结尾默认"0"
	                    Debug.Log("接收服务器消息:" + Str);
	                    TestMessage(Str);
	                }
	                try
	                {
	                    receiveLength = clientSocket.Receive(result);
	                    Str = Encoding.UTF8.GetString(result, 0, receiveLength);
	                }
	                catch
	                {
	                    break;
	                }
	            }
	        }
	        catch
	        {
	            clientSocket.Shutdown(SocketShutdown.Both);
	            clientSocket.Close();
	        }
	    }

	    public static void TestMessage(string context) {
            CallMethod("asdf",context);
        }

		/// <summary>
        /// 执行Lua方法
        /// </summary>
        public static object[] CallMethod(string func, params object[] args) {
        	//怎么传递参数才是大问题我勒个去
            return Util.CallMethod("Game", func);
        }
	}
}