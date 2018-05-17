package com.prosay.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.prosay.common.Config;

/**
 * Servlet implementation class Action
 */
@WebServlet("/robot")
public class Action extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	     //以后可以通过常量类获取   
		    private static final String APIKEY = Config.APIKEY;
		    private static final String URL = Config.URL+"?key=";
		    //http://www.tuling123.com/openapi/api?APKKEY=APIKEY&question=info;
		    
		 /**
		  * post:http://www.tuling123.com/openapi/api
			*string:key=您的apikey#apikey
			*info=今天天气怎么样#请求内容   
		  */
		    
		    
      	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	     }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//设置请求及响应编码
		request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
	   //获取文本输入的值  
       String  text = request.getParameter("text");
       String result = getResult(text); //拿到答复
       response.getWriter().println(result); //输出到前面页面
	}

   //根据前台页面用户问题的内容 获取回复答案
	private String getResult(String text) {
		StringBuffer sb = new StringBuffer();
		//将用户输入的内容 调用接口
		//第1步 拼接链接地址和参数  参数里面有APIKEY
		try {
			String  info = URLEncoder.encode(text,"utf-8");  //这是解码器
			String  getUrl = URL+APIKEY+"&info="+info;
			java.net.URL  queryURL = new URL(getUrl);
		  //通过这个URL地址打开链接 使用IO流读取链接当中的输入流  拼接成需要的字符串
			URLConnection  connection = queryURL.openConnection();
			
			
			BufferedReader  br = new BufferedReader(
					new InputStreamReader(
							connection.getInputStream(),"utf-8"));
			
			String line = "";
			while((line = br.readLine())  != null){
				sb.append(line);
			}
			br.close();
			
			
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(sb);
		return sb.toString();
	}

}
