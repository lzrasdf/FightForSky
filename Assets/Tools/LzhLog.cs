using UnityEngine;  
using System.Collections;  
using System.IO;  
  
public class LzhLog : MonoBehaviour   
{  
    static int line = 0;  
    public static void print(string info)  
    {  
        line ++;  
        string path = Application.dataPath + "/LogFile.txt";  
        StreamWriter sw;  
        //Debug.Log (path);

        if (line == 1)  
        {  
            sw = new StreamWriter(path, false);  
            string fileTitle = "日志文件创建的时间  " + System.DateTime.Now.ToString();  
            sw.WriteLine (fileTitle);  
        }  
        else  
        {  
            sw = new StreamWriter (path, true);  
        }  
          
        string lineInfo = line + "\t" + "时刻 " + Time.time + ": ";  
        //sw.WriteLine (lineInfo); 
        string temp = System.DateTime.Now.ToString() + "--" + info;
        sw.WriteLine (temp);
        
        sw.Flush ();  
        sw.Close ();  
    }

    //暂时这么处理，每次都是重新写入
    public static void clear()
    {
        line = 1;
        string path = Application.dataPath + "/LogFile.txt";  
        StreamWriter sw;  

        sw = new StreamWriter(path, false);  
        string fileTitle = "日志文件创建的时间  " + System.DateTime.Now.ToString();  
        sw.WriteLine (fileTitle);

        sw.Flush ();  
        sw.Close ();  
    }

}  